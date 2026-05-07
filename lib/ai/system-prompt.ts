import type { RichBrandContext } from './context-builder';

function inr(n: number): string {
  if (n >= 10_000_000) return `₹${(n / 10_000_000).toFixed(1)}Cr`;
  if (n >= 100_000)    return `₹${(n / 100_000).toFixed(1)}L`;
  if (n >= 1_000)      return `₹${(n / 1_000).toFixed(0)}K`;
  return `₹${Math.round(n)}`;
}

function pct(n: number): string { return `${n.toFixed(1)}%`; }

export function buildSystemPrompt(ctx: RichBrandContext, channel: 'web' | 'whatsapp' = 'web'): string {
  const {
    brand, brandContext, connectedSources,
    revenue7d, revenuePrev7d, orders7d, revenueByDay,
    revenueByChannel, channelBreakdownPct,
    adSpendByPlatform, adRevenueByPlatform, roas7dByPlatform, blendedRoas7d,
    rtoRate7d, rtoRate30d, courierPerformance, topRtoCities,
    cashPosition, dailyBurn30d, runwayDays,
    recentAlerts, brandMemory,
    upcomingFestivals, gstWarning,
  } = ctx;

  // ── Revenue ──
  const revChangePct = revenuePrev7d > 0
    ? ((revenue7d - revenuePrev7d) / revenuePrev7d * 100)
    : null;
  const revChangeStr = revChangePct !== null
    ? `${revChangePct >= 0 ? '+' : ''}${revChangePct.toFixed(1)}% vs prev week`
    : 'no prior week data';

  const revenueTable = Object.entries(revenueByDay)
    .sort(([a], [b]) => b.localeCompare(a))
    .slice(0, 7)
    .map(([d, r]) => `  ${d}: ${inr(r)}`)
    .join('\n') || '  No data — connect Shopify';

  // ── Channel split ──
  const channelLines = Object.entries(revenueByChannel)
    .sort(([, a], [, b]) => b - a)
    .map(([ch, rev]) => `  ${ch.charAt(0).toUpperCase() + ch.slice(1)}: ${inr(rev)} (${channelBreakdownPct[ch] ?? 0}% of GMV)`)
    .join('\n') || '  No multi-channel data yet';

  // ── Ad performance ──
  const adLines = Object.entries(adSpendByPlatform).map(([platform, spend]) => {
    const roas = roas7dByPlatform[platform] ?? 0;
    const rev  = adRevenueByPlatform[platform] ?? 0;
    const benchmark = platform === 'meta' ? '(India: >4x excellent, <2.5x poor)' : '(India: >5x excellent, <3x poor)';
    return `  ${platform.toUpperCase()}: spend ${inr(spend)}, revenue ${inr(rev)}, ROAS ${roas.toFixed(2)}x ${benchmark}`;
  });
  const adSection = adLines.length > 0
    ? adLines.join('\n') + `\n  Blended ROAS: ${blendedRoas7d !== null ? blendedRoas7d.toFixed(2) + 'x' : 'N/A'}`
    : '  No ad data — connect Meta or Google Ads';

  // ── Logistics ──
  let rtoSection = '  No RTO data — connect Shopify';
  if (rtoRate7d !== null) {
    const benchmark = rtoRate7d < 0.08 ? '✅ excellent' : rtoRate7d < 0.15 ? '⚠ average' : '🚨 critical';
    rtoSection = `  7-day: ${pct(rtoRate7d * 100)} ${benchmark} | 30-day avg: ${rtoRate30d !== null ? pct(rtoRate30d * 100) : 'N/A'}`;
    if (topRtoCities.length > 0) {
      const cities = topRtoCities.slice(0, 3).map(c => `${c.city} ${pct(c.rate * 100)}`).join(', ');
      rtoSection += `\n  Top RTO cities: ${cities}`;
    }
  }

  let courierSection = '';
  if (courierPerformance.length > 0) {
    courierSection = '\n## COURIER PERFORMANCE (Shiprocket)\n' +
      courierPerformance
        .sort((a, b) => a.rtoRate - b.rtoRate)
        .slice(0, 4)
        .map(c => `  ${c.courier}: RTO ${pct(c.rtoRate * 100)}, avg delivery ${c.avgDeliveryDays.toFixed(1)} days`)
        .join('\n');
  }

  // ── Cash ──
  let cashSection = '  Not available — upload Tally CSV to unlock';
  if (cashPosition !== null) {
    cashSection = `  Balance: ${inr(cashPosition)}`;
    if (runwayDays !== null) {
      const runwayWarning = runwayDays < 30 ? ' 🚨 CRITICAL' : runwayDays < 45 ? ' ⚠ WARNING' : '';
      cashSection += `\n  Runway: ~${runwayDays} days${runwayWarning}`;
      if (dailyBurn30d) cashSection += ` (daily burn: ${inr(dailyBurn30d)}/day)`;
    }
  }

  // ── Alerts ──
  const alertSection = recentAlerts.length > 0
    ? recentAlerts.map(a => {
        const actionHint = (a.data as Record<string, unknown>)?.action_description as string | undefined;
        return `  [${a.severity.toUpperCase()}] ${a.message}${actionHint ? ` → ${actionHint}` : ''}`;
      }).join('\n')
    : '  None';

  // ── Missing sources ──
  const allSources = ['shopify', 'meta', 'flipkart', 'shiprocket'];
  const missing = allSources.filter(s => !connectedSources.includes(s));
  const missingSection = missing.length > 0
    ? `  Not connected: ${missing.join(', ')} — connecting these will unlock deeper analysis`
    : '  All primary sources connected';

  // ── Festivals ──
  const festivalSection = upcomingFestivals.length > 0
    ? '  ' + upcomingFestivals.join(' · ')
    : '  No major festivals in next 60 days';

  const skus     = brandContext?.key_skus?.join(', ') || 'Not set';
  const targetRoas = brandContext?.target_roas ?? 3.0;
  const channels = brandContext?.primary_channels?.join(', ') || 'Not set';
  const notes    = brandContext?.business_notes ?? '';

  const responseInstructions = channel === 'whatsapp'
    ? `- Keep reply under 450 chars — this is WhatsApp
- Use plain text, no markdown headers
- Lead with the key number, then 1 action
- End with "Reply with any question."`
    : `- Lead with the key metric or diagnosis
- Give 1–2 concrete actions with exact numbers
- Use markdown: **bold** for critical numbers, bullet lists for actions
- Keep under 300 words unless detail is explicitly needed
- If data is missing, name the exact source to connect`;

  return `You are Brain — the AI business intelligence advisor for Indian D2C brands. You replace a CA firm, analytics agency, and growth consultant in one.

## BRAND PROFILE
Name: ${brand.name}
Founder: ${brand.founder_name ?? 'Unknown'}
Plan: ${brand.plan}
Primary channels: ${channels}
Key SKUs: ${skus}
Target ROAS: ${targetRoas}x
${notes ? `Notes: ${notes}` : ''}

## REVENUE — LAST 7 DAYS
Total: ${inr(revenue7d)} (${revChangeStr})
Orders: ${Math.round(orders7d)}
Daily:
${revenueTable}

## CHANNEL BREAKDOWN — LAST 30 DAYS
${channelLines}

## AD PERFORMANCE — LAST 7 DAYS
${adSection}

## RETURNS & LOGISTICS
${rtoSection}
${courierSection}

## CASH POSITION
${cashSection}

## ACTIVE ALERTS (last 72 hours)
${alertSection}

## DATA SOURCES
${missingSection}

## UPCOMING FESTIVALS (next 60 days)
${festivalSection}
${gstWarning ? `\n⚠ GST: ${gstWarning}` : ''}

${brandMemory ? brandMemory + '\n' : ''}
## INDIAN D2C BENCHMARKS
- RTO: <8% excellent · 8–15% average · >15% critical
- Meta ROAS: >4x excellent · 2.5–4x acceptable · <2.5x poor
- COD ratio: 40–60% typical for Indian D2C
- Flipkart cancellations ≈ Shopify RTO for benchmarking
- Inventory lead time: order 60–90 days before peak season
- Shiprocket avg delivery: tier-1 cities 2–3 days, tier-2/3 3–5 days
- GST: 18% on most D2C products (5% on food/nutraceuticals)
- Amazon FBA India: 15–20% fees | FBM: 5–10% + self-ship
- Razorpay/Shopify Payments: settles 3–5 business days

## RESPONSE INSTRUCTIONS
${responseInstructions}
- Always cite exact figures from the data above
- Diagnose root cause, not just symptom
- Flag any metric outside Indian D2C benchmarks`;
}
