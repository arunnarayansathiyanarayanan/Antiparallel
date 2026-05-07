import { streamText } from 'ai';
import { anthropic } from '@ai-sdk/anthropic';
import { NextRequest } from 'next/server';
import { z } from 'zod';
import { buildBrandContext } from '@/lib/ai/context-builder';
import { buildSystemPrompt } from '@/lib/ai/system-prompt';
import { extractAndStoreInsights } from '@/lib/ai/memory';
import { createClient } from '@/lib/supabase/server';
import type { ChatMessage } from '@/types';

const CLAUDE_MODEL = process.env.CLAUDE_MODEL_ID ?? 'claude-sonnet-4-20250514';

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
    const { messages, brandId } = parsed.data;

    const ctx = await buildBrandContext(brandId);
    const systemPrompt = buildSystemPrompt(ctx, 'web');

    const result = await streamText({
      model: anthropic(CLAUDE_MODEL),
      system: systemPrompt,
      messages,
      maxTokens: 1024 as number,
      onFinish: async ({ text }) => {
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

        // Extract and store any durable learnings — fire and forget
        extractAndStoreInsights(brandId, updatedMessages).catch(() => {/* silent */});
      },
    });

    return result.toDataStreamResponse();
  } catch {
    return Response.json({ error: 'Internal server error' }, { status: 500 });
  }
}
