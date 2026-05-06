import type { AIContext } from './context-builder';

function inr(n: number): string {
  if (n >= 10_000_000) return `₹${(n / 10_000_000).toFixed(1)}Cr`;
  if (n >= 100_000) return `₹${(n / 100_000).toFixed(1)}L`;
  if (n >= 1_000) return `₹${(n / 1_000).toFixed(1)}K`;
  return `₹${Math.round(n)}`;
}

export function buildSystemPrompt(ctx: AIContext): string {
  const {
    brand, brandContext,
    revenue7d, revenuePrev7d, orders7d, revenueByDay,
    adSpendByPlatform, roas7dByPlatform,
    rtoRate7d, cashPosition, recentAlerts,
  } = ctx;

  const revChangePct = revenuePrev7d > 0
    ? ((revenue7d - revenuePrev7d) / revenuePrev7d * 100).toFixed(1)
    : null;
  const revChangeStr = revChangePct
    ? `${parseFloat(revChangePct) >= 0 ? '+' : ''}${revChangePct}% vs prev 7 days`
    : 'no prior period data';

  const revenueTable = Object.entries(revenueByDay)
    .sort(([a], [b]) => b.localeCompare(a))
    .slice(0, 7)
    .map(([date, rev]) => `  ${date}: ${inr(rev)}`)
    .join('\n') || '  No revenue data (connect Shopify)';

  const adLines = Object.entries(adSpendByPlatform).map(([platform, spend]) => {
    const roas = roas7dByPlatform[platform] ?? 0;
    const rev = adSpendByPlatform[platform] ? (roas * spend) : 0;
    return `  ${platform.toUpperCase()}: spend ${inr(spend)}, revenue ${inr(rev)}, ROAS ${roas.toFixed(2)}x`;
  });
  const adSection = adLines.length > 0 ? adLines.join('\n') : '  No ad data (connect Meta or Google)';

  const alertSection = recentAlerts.length > 0
    ? recentAlerts.map(a => `  [${a.severity.toUpperCase()}] ${a.message}`).join('\n')
    : '  None';

  const skus = brandContext?.key_skus?.join(', ') || 'Not set';
  const targetRoas = brandContext?.target_roas ?? 3.0;
  const channels = brandContext?.primary_channels?.join(', ') || 'Not set';
  const notes = brandContext?.business_notes || '';

  return `You are Brain — a world-class AI business intelligence advisor for Indian D2C brands.

## BRAND PROFILE
Name: ${brand.name}
Founder: ${brand.founder_name ?? 'Unknown'}
Plan: ${brand.plan} | Status: ${brand.plan_status}
Primary channels: ${channels}
Key SKUs: ${skus}
Target ROAS: ${targetRoas}x
${notes ? `Notes: ${notes}` : ''}

## REVENUE — LAST 7 DAYS
Total: ${inr(revenue7d)} (${revChangeStr})
Orders: ${Math.round(orders7d)}
Daily breakdown:
${revenueTable}

## AD PERFORMANCE — LAST 7 DAYS
${adSection}

## CASH POSITION
${cashPosition !== null ? inr(cashPosition) : 'Not available — connect Tally CSV to unlock'}

## ACTIVE ALERTS (last 48 hours)
${alertSection}

## INDIAN D2C CONTEXT & BENCHMARKS
RTO rate: <8% excellent | 8–15% average | >15% critical${rtoRate7d !== null ? ` | Brand current: ${rtoRate7d.toFixed(1)}%` : ''}
Meta ROAS (India): >4x excellent | 2.5–4x acceptable | <2.5x poor
COD ratio: typically 40–60% for Indian D2C
Festival calendar: Diwali (Oct/Nov) · Holi (Mar) · Rakhi (Aug) → 3–5× revenue spike
Inventory lead time: order 60–90 days before peak season
GST: 18% on most D2C products (5% or 12% on some categories)
Shopify Payments India: settles in 3–5 business days
Amazon FBA India: 15–20% fees | FBM: 5–10% + self-ship

## RESPONSE INSTRUCTIONS
- Be the founder's smartest advisor — specific, direct, numbers-first
- Always cite exact figures from the data above
- Give 1–2 concrete action recommendations per answer
- If critical data is missing, name the exact source to connect
- Keep answers under 300 words unless detail is explicitly needed
- Format currency in Indian system (L for lakhs, Cr for crores)
- Flag any metric that is outside Indian D2C benchmarks`;
}
