import Anthropic from '@anthropic-ai/sdk';
import { createServiceClient } from '@/lib/supabase/service';

const anthropic = new Anthropic();

function inr(n: number): string {
  if (n >= 10_000_000) return `₹${(n / 10_000_000).toFixed(1)}Cr`;
  if (n >= 100_000) return `₹${(n / 100_000).toFixed(1)}L`;
  if (n >= 1_000) return `₹${(n / 1_000).toFixed(0)}K`;
  return `₹${Math.round(n)}`;
}

export async function generateMorningBrief(brandId: string): Promise<string> {
  const supabase = createServiceClient();

  const sevenDaysAgo = new Date(Date.now() - 7 * 86400_000).toISOString().slice(0, 10);
  const fourteenDaysAgo = new Date(Date.now() - 14 * 86400_000).toISOString().slice(0, 10);

  const [brandRes, metricsRes, alertRes] = await Promise.all([
    supabase.from('brands').select('name, founder_name').eq('id', brandId).single(),
    supabase
      .from('metrics_daily')
      .select('source, metric_key, metric_value, date')
      .eq('brand_id', brandId)
      .gte('date', fourteenDaysAgo),
    supabase
      .from('alerts')
      .select('message, severity')
      .eq('brand_id', brandId)
      .is('resolved_at', null)
      .order('triggered_at', { ascending: false })
      .limit(1)
      .single(),
  ]);

  const brand = brandRes.data;
  const metrics = metricsRes.data ?? [];
  const topAlert = alertRes.data;

  let rev7d = 0, revPrev7d = 0, adSpend7d = 0, adRev7d = 0;

  for (const m of metrics) {
    const val = m.metric_value ?? 0;
    const isRecent = m.date >= sevenDaysAgo;
    const isPrev = m.date >= fourteenDaysAgo && m.date < sevenDaysAgo;

    if (m.source === 'shopify' && m.metric_key === 'revenue') {
      if (isRecent) rev7d += val;
      if (isPrev) revPrev7d += val;
    }
    if ((m.source === 'meta' || m.source === 'google') && isRecent) {
      if (m.metric_key === 'spend') adSpend7d += val;
      if (m.metric_key === 'revenue') adRev7d += val;
    }
  }

  const revChange = revPrev7d > 0
    ? `${rev7d >= revPrev7d ? '+' : ''}${((rev7d - revPrev7d) / revPrev7d * 100).toFixed(0)}%`
    : 'first week';
  const blendedRoas = adSpend7d > 0 ? (adRev7d / adSpend7d).toFixed(1) : null;
  const roasWarn = blendedRoas && parseFloat(blendedRoas) < 2.5;
  const founderName = brand?.founder_name ?? brand?.name ?? 'there';

  const prompt = `Write a WhatsApp morning brief for an Indian D2C brand founder.
STRICT limit: 280 characters total including spaces and line breaks.

Facts to include:
- Founder first name: ${founderName.split(' ')[0]}
- Revenue last 7 days: ${inr(rev7d)} (${revChange} vs prev week)
- Blended ROAS: ${blendedRoas ? `${blendedRoas}x` : 'not tracked'}
${topAlert ? `- Top alert: ${topAlert.message}` : ''}
${roasWarn ? '- ROAS is below 2.5x threshold — flag this' : ''}

Format (stick to this exactly):
Good morning [name]! 🧠
📊 [revenue] ([change] wow)
${roasWarn ? '⚠️ [short ROAS action]' : topAlert ? '⚠️ [short alert summary]' : ''}
Reply with any question.`;

  const response = await anthropic.messages.create({
    model: 'claude-sonnet-4-20250514',
    max_tokens: 150,
    messages: [{ role: 'user', content: prompt }],
  });

  const text = response.content[0].type === 'text' ? response.content[0].text.trim() : '';
  // Hard-truncate to 280 chars as a safety net
  return text.slice(0, 280);
}
