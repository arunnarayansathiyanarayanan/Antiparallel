import { streamText } from 'ai';
import { anthropic } from '@ai-sdk/anthropic';
import { Ratelimit } from '@upstash/ratelimit';
import { Redis } from '@upstash/redis';
import { NextRequest } from 'next/server';
import { z } from 'zod';
import { buildBrandContext } from '@/lib/ai/context-builder';
import { buildSystemPrompt } from '@/lib/ai/system-prompt';
import { createClient } from '@/lib/supabase/server';
import type { ChatMessage } from '@/types';

// Only initialise Redis if env vars are present (skips in local dev without Upstash)
const ratelimit =
  process.env.UPSTASH_REDIS_REST_URL && process.env.UPSTASH_REDIS_REST_TOKEN
    ? new Ratelimit({
        redis: Redis.fromEnv(),
        limiter: Ratelimit.slidingWindow(50, '1 d'),
        prefix: 'brain:chat',
      })
    : null;

const requestSchema = z.object({
  brandId: z.string().uuid(),
  messages: z.array(z.object({
    role: z.enum(['user', 'assistant']),
    content: z.string().min(1),
  })).min(1),
});

export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    const parsed = requestSchema.safeParse(body);
    if (!parsed.success) {
      return Response.json({ error: 'Invalid request body' }, { status: 400 });
    }
    const { messages, brandId } = parsed.data as { messages: ChatMessage[]; brandId: string };

    // Rate limiting — 50 messages per brand per day
    if (ratelimit) {
      const { success, remaining } = await ratelimit.limit(`brand:${brandId}`);
      if (!success) {
        return Response.json(
          { error: `Daily message limit reached. ${remaining} messages remaining today.` },
          { status: 429 }
        );
      }
    }

    const ctx = await buildBrandContext(brandId);
    const systemPrompt = buildSystemPrompt(ctx);

    const result = await streamText({
      model: anthropic('claude-sonnet-4-20250514'),
      system: systemPrompt,
      messages,
      maxTokens: 1024 as number,
      onFinish: async ({ text }) => {
        // Persist conversation asynchronously
        const supabase = createClient();
        const updatedMessages: ChatMessage[] = [
          ...messages,
          { role: 'assistant', content: text, timestamp: new Date().toISOString() },
        ];

        const { data: existing } = await supabase
          .from('conversations')
          .select('id')
          .eq('brand_id', brandId)
          .order('updated_at', { ascending: false })
          .limit(1)
          .single();

        if (existing) {
          await supabase
            .from('conversations')
            .update({ messages: updatedMessages, updated_at: new Date().toISOString() })
            .eq('id', existing.id);
        } else {
          await supabase
            .from('conversations')
            .insert({ brand_id: brandId, messages: updatedMessages });
        }
      },
    });

    return result.toDataStreamResponse();
  } catch (err) {
    return Response.json({ error: 'Internal server error' }, { status: 500 });
  }
}
