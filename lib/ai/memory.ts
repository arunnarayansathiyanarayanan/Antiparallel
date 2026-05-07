import { generateText } from 'ai';
import { anthropic } from '@ai-sdk/anthropic';
import { createServiceClient } from '@/lib/supabase/service';
import type { ChatMessage, BrandInsight } from '@/types';

const CLAUDE_MODEL = process.env.CLAUDE_MODEL_ID ?? 'claude-sonnet-4-20250514';

export async function extractAndStoreInsights(
  brandId: string,
  messages: ChatMessage[]
): Promise<void> {
  if (!process.env.ANTHROPIC_API_KEY) return;
  if (messages.length < 2) return;

  const conversation = messages
    .map(m => `${m.role === 'user' ? 'Founder' : 'Brain'}: ${m.content}`)
    .join('\n\n');

  let insights: Array<{ insight_type: BrandInsight['insight_type']; content: string }> = [];

  try {
    const { text } = await generateText({
      model: anthropic(CLAUDE_MODEL),
      system: `You extract durable business learnings from conversations between a D2C brand founder and an AI advisor.
Return ONLY a JSON array of {insight_type, content} objects, or [] if nothing worth remembering.
insight_type must be one of: learning, decision, pattern, preference.
Be very selective — only store facts that would change how to advise this brand in 6 months.
Do NOT store: temporary data, current metrics, one-off questions, greetings.
DO store: ROAS thresholds the founder uses, SKU-level learnings, seasonal patterns, explicit preferences.`,
      prompt: `Extract insights from this conversation:\n\n${conversation}`,
      maxTokens: 512,
    });

    const match = text.match(/\[[\s\S]*\]/);
    if (match) {
      insights = JSON.parse(match[0]);
    }
  } catch {
    return; // never fail the main flow
  }

  if (!Array.isArray(insights) || insights.length === 0) return;

  const supabase = createServiceClient();
  const rows = insights
    .filter(i => i.insight_type && i.content && typeof i.content === 'string' && i.content.length > 10)
    .map(i => ({
      brand_id: brandId,
      insight_type: i.insight_type,
      content: i.content.slice(0, 500),
      source: 'chat_conversation' as const,
    }));

  if (rows.length > 0) {
    await supabase.from('brand_insights').insert(rows);
  }
}

export async function loadBrandMemory(brandId: string): Promise<string> {
  const supabase = createServiceClient();

  const { data } = await supabase
    .from('brand_insights')
    .select('insight_type, content, created_at')
    .eq('brand_id', brandId)
    .order('created_at', { ascending: false })
    .limit(50);

  if (!data || data.length === 0) return '';

  const lines = data.map(i => {
    const date = new Date(i.created_at).toLocaleDateString('en-IN', { day: 'numeric', month: 'short', year: '2-digit' });
    return `- [${i.insight_type}] ${i.content} (${date})`;
  });

  return `## BRAND MEMORY (accumulated learnings)\n${lines.join('\n')}`;
}
