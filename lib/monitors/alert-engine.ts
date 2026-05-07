import { createServiceClient } from '@/lib/supabase/service';
import type { Alert, AlertSeverity } from '@/types';

type NewAlert = Omit<Alert, 'id' | 'triggered_at'>;

// ── Deduplication: skip if same alert_type fired in last 24 h ──────────────
async function recentlyFired(brandId: string, alertType: string): Promise<boolean> {
  const supabase = createServiceClient();
  const since = new Date(Date.now() - 24 * 3600_000).toISOString();
  const { data } = await supabase
    .from('alerts')
    .select('id')
    .eq('brand_id', brandId)
    .eq('alert_type', alertType)
    .gte('triggered_at', since)
    .limit(1);
  return (data?.length ?? 0) > 0;
}

function make(
  brandId: string,
  alertType: string,
  severity: AlertSeverity,
  message: string,
  data: Record<string, unknown>
): NewAlert {
  return {
    brand_id: brandId,
    alert_type: alertType,
    severity,
    message,
    data,
    resolved_at: null,
    notified_whatsapp: false,
  };
}

// ── 1. ROAS DROP ──────────────────────────────────────────────────────────
export async function checkRoasDrop(brandId: string): Promise<NewAlert | null> {
  if (await recentlyFired(brandId, 'roas_drop')) return null;

  const supabase = createServiceClient();
  const eightDaysAgo = new Date(Date.now() - 8 * 86400_000).toISOString().slice(0, 10);
  const twoDaysAgo  = new Date(Date.now() - 2 * 86400_000).toISOString().slice(0, 10);
  const yesterday   = new Date(Date.now() - 1 * 86400_000).toISOString().slice(0, 10);

  // Fetch ad spend + ad revenue and Shopify revenue for last 8 days
  const [adsRes, revRes] = await Promise.all([
    supabase
      .from('metrics_daily')
      .select('date, source, metric_key, metric_value')
      .eq('brand_id', brandId)
      .in('source', ['meta', 'google'])
      .in('metric_key', ['spend', 'revenue'])
      .gte('date', eightDaysAgo),
    supabase
      .from('metrics_daily')
      .select('date, metric_value')
      .eq('brand_id', brandId)
      .eq('source', 'shopify')
      .eq('metric_key', 'revenue')
      .gte('date', eightDaysAgo),
  ]);

  const ads = adsRes.data ?? [];
  const shopifyRev = revRes.data ?? [];

  if (ads.length === 0) return null;

  // Build daily spend and ad revenue maps
  const spendByDay: Record<string, number> = {};
  const adRevByDay: Record<string, number> = {};
  for (const row of ads) {
    if (row.metric_key === 'spend') spendByDay[row.date] = (spendByDay[row.date] ?? 0) + (row.metric_value ?? 0);
    if (row.metric_key === 'revenue') adRevByDay[row.date] = (adRevByDay[row.date] ?? 0) + (row.metric_value ?? 0);
  }
  const shopifyRevByDay: Record<string, number> = {};
  for (const row of shopifyRev) shopifyRevByDay[row.date] = (row.metric_value ?? 0);

  // Compute blended ROAS per day (use ad revenue if available, else Shopify revenue as proxy)
  function roasForDate(date: string): number | null {
    const spend = spendByDay[date] ?? 0;
    if (spend <= 0) return null;
    const rev = adRevByDay[date] ?? shopifyRevByDay[date] ?? 0;
    return rev / spend;
  }

  // Current: last 2 days (yesterday + today)
  const currentDays = [yesterday];
  const currentRoasValues = currentDays.map(roasForDate).filter((v): v is number => v !== null);
  if (currentRoasValues.length === 0) return null;
  const currentRoas = currentRoasValues.reduce((a, b) => a + b, 0) / currentRoasValues.length;

  // Baseline: days 2-8 ago
  const baselineDays: string[] = [];
  for (let i = 2; i <= 8; i++) {
    baselineDays.push(new Date(Date.now() - i * 86400_000).toISOString().slice(0, 10));
  }
  const baselineValues = baselineDays.map(roasForDate).filter((v): v is number => v !== null);
  if (baselineValues.length < 2) return null;
  const baselineRoas = baselineValues.reduce((a, b) => a + b, 0) / baselineValues.length;

  if (baselineRoas <= 0) return null;
  const dropPct = (baselineRoas - currentRoas) / baselineRoas;
  if (dropPct < 0.25) return null;

  const severity: AlertSeverity = dropPct > 0.4 ? 'critical' : 'warning';
  const drop = (dropPct * 100).toFixed(0);

  return make(brandId, 'roas_drop', severity,
    `ROAS dropped ${drop}% — ${currentRoas.toFixed(2)}x yesterday vs ${baselineRoas.toFixed(2)}x baseline`,
    {
      current_roas: currentRoas,
      baseline_roas: baselineRoas,
      drop_pct: dropPct * 100,
      pending_action: 'pause_low_roas_campaigns',
      action_description: 'Reply YES to pause all campaigns below 2× ROAS',
    }
  );
}

// ── 2. CREATIVE FATIGUE ───────────────────────────────────────────────────
export async function checkCreativeFatigue(brandId: string): Promise<NewAlert | null> {
  if (await recentlyFired(brandId, 'creative_fatigue')) return null;

  const supabase = createServiceClient();
  const sevenDaysAgo = new Date(Date.now() - 7 * 86400_000).toISOString().slice(0, 10);

  const { data: metrics } = await supabase
    .from('metrics_daily')
    .select('date, metric_key, metric_value, metadata')
    .eq('brand_id', brandId)
    .eq('source', 'meta')
    .in('metric_key', ['ctr', 'spend'])
    .gte('date', sevenDaysAgo);

  if (!metrics || metrics.length === 0) return null;

  const twoDaysAgo = new Date(Date.now() - 2 * 86400_000).toISOString().slice(0, 10);

  const recentCtr = metrics
    .filter(m => m.metric_key === 'ctr' && m.date >= twoDaysAgo)
    .map(m => m.metric_value ?? 0);
  const prevCtr = metrics
    .filter(m => m.metric_key === 'ctr' && m.date < twoDaysAgo)
    .map(m => m.metric_value ?? 0);
  const recentSpend = metrics
    .filter(m => m.metric_key === 'spend' && m.date >= twoDaysAgo)
    .reduce((s, m) => s + (m.metric_value ?? 0), 0);

  if (recentCtr.length === 0 || prevCtr.length === 0) return null;
  if (recentSpend < 2000) return null; // under ₹2K spend — not worth alerting

  const avgRecent = recentCtr.reduce((a, b) => a + b, 0) / recentCtr.length;
  const avgPrev   = prevCtr.reduce((a, b) => a + b, 0) / prevCtr.length;
  if (avgPrev <= 0) return null;

  const drop = (avgPrev - avgRecent) / avgPrev;
  if (drop < 0.4) return null;

  return make(brandId, 'creative_fatigue', 'warning',
    `Meta CTR dropped ${(drop * 100).toFixed(0)}% — ${avgRecent.toFixed(2)}% vs ${avgPrev.toFixed(2)}% (spend ₹${Math.round(recentSpend).toLocaleString('en-IN')} last 48h)`,
    {
      recent_ctr: avgRecent,
      prev_ctr: avgPrev,
      drop_pct: drop * 100,
      recent_spend: recentSpend,
      pending_action: 'pause_fatigued_campaigns',
      action_description: 'Reply YES to pause campaigns with CTR below fatigue threshold',
    }
  );
}

// ── 3. RTO SPIKE ──────────────────────────────────────────────────────────
export async function checkRtoSpike(brandId: string): Promise<NewAlert | null> {
  if (await recentlyFired(brandId, 'rto_spike')) return null;

  const supabase = createServiceClient();
  const thirtyDaysAgo = new Date(Date.now() - 30 * 86400_000).toISOString().slice(0, 10);
  const sevenDaysAgo  = new Date(Date.now() - 7 * 86400_000).toISOString().slice(0, 10);

  const { data: metrics } = await supabase
    .from('metrics_daily')
    .select('date, metric_value, metadata')
    .eq('brand_id', brandId)
    .eq('source', 'shopify')
    .eq('metric_key', 'rto_rate')
    .gte('date', thirtyDaysAgo);

  if (!metrics || metrics.length < 5) return null;

  const avg30d = metrics.reduce((s, m) => s + (m.metric_value ?? 0), 0) / metrics.length;
  const recent7d = metrics.filter(m => m.date >= sevenDaysAgo);
  if (recent7d.length === 0) return null;

  const avg7d = recent7d.reduce((s, m) => s + (m.metric_value ?? 0), 0) / recent7d.length;
  const spikePp = avg7d - avg30d;
  if (spikePp < 5) return null;

  // Extract top RTO city from metadata if present
  const topCityEntry = recent7d
    .map(m => (m.metadata as Record<string, unknown>)?.top_rto_city as string | undefined)
    .find(Boolean);

  const cityMsg = topCityEntry ? ` (highest: ${topCityEntry})` : '';

  return make(brandId, 'rto_spike', avg7d > 20 ? 'critical' : 'warning',
    `RTO spiked to ${avg7d.toFixed(1)}%${cityMsg} — ${spikePp.toFixed(1)}pp above 30-day avg (${avg30d.toFixed(1)}%)`,
    {
      current_rto: avg7d,
      avg_30d: avg30d,
      spike_pp: spikePp,
      top_rto_city: topCityEntry ?? null,
      pending_action: topCityEntry ? 'restrict_cod_city' : null,
      action_city: topCityEntry ?? null,
      action_description: topCityEntry
        ? `Reply YES to restrict COD for ${topCityEntry} for 7 days`
        : null,
    }
  );
}

// ── 4. CASH RUNWAY ────────────────────────────────────────────────────────
export async function checkCashRunway(brandId: string): Promise<NewAlert | null> {
  if (await recentlyFired(brandId, 'cash_low')) return null;

  const supabase = createServiceClient();
  const thirtyDaysAgo = new Date(Date.now() - 30 * 86400_000).toISOString().slice(0, 10);

  const [cashRes, spendRes] = await Promise.all([
    supabase
      .from('metrics_daily')
      .select('metric_value')
      .eq('brand_id', brandId)
      .eq('source', 'tally_csv')
      .eq('metric_key', 'cash_position')
      .order('date', { ascending: false })
      .limit(1)
      .single(),
    supabase
      .from('metrics_daily')
      .select('metric_value')
      .eq('brand_id', brandId)
      .in('source', ['meta', 'google'])
      .eq('metric_key', 'spend')
      .gte('date', thirtyDaysAgo),
  ]);

  const cash = cashRes.data?.metric_value ?? null;
  if (cash === null || cash <= 0) return null;

  const totalSpend30d = (spendRes.data ?? []).reduce((s, m) => s + (m.metric_value ?? 0), 0);
  const dailyBurn = totalSpend30d > 0 ? totalSpend30d / 30 : null;

  if (!dailyBurn || dailyBurn <= 0) return null;
  const runwayDays = Math.floor(cash / dailyBurn);

  if (runwayDays >= 45) return null;

  const severity: AlertSeverity = runwayDays < 30 ? 'critical' : 'warning';

  return make(brandId, 'cash_low', severity,
    `Cash runway: ~${runwayDays} days (₹${(cash / 100000).toFixed(1)}L cash, ₹${Math.round(dailyBurn).toLocaleString('en-IN')}/day burn). Review with your CA.`,
    {
      cash_balance: cash,
      daily_burn: dailyBurn,
      runway_days: runwayDays,
      pending_action: null, // info only
    }
  );
}

// ── 5. STOCKOUT RISK ──────────────────────────────────────────────────────
export async function checkStockoutRisk(brandId: string): Promise<NewAlert | null> {
  if (await recentlyFired(brandId, 'stockout_risk')) return null;

  const supabase = createServiceClient();
  const fourteenDaysAgo = new Date(Date.now() - 14 * 86400_000).toISOString().slice(0, 10);

  // Look for inventory_units metrics (requires updated Shopify sync)
  const [invRes, salesRes] = await Promise.all([
    supabase
      .from('metrics_daily')
      .select('metric_key, metric_value')
      .eq('brand_id', brandId)
      .eq('source', 'shopify')
      .like('metric_key', 'inventory_%')
      .order('date', { ascending: false })
      .limit(20),
    supabase
      .from('metrics_daily')
      .select('metric_key, metric_value')
      .eq('brand_id', brandId)
      .eq('source', 'shopify')
      .like('metric_key', 'sku_units_%')
      .gte('date', fourteenDaysAgo),
  ]);

  const inventory = invRes.data ?? [];
  const sales = salesRes.data ?? [];

  if (inventory.length === 0) return null; // no inventory data yet

  // Map current inventory per SKU
  const invBySku: Record<string, number> = {};
  for (const row of inventory) {
    const sku = row.metric_key.replace('inventory_', '');
    if (!(sku in invBySku)) invBySku[sku] = row.metric_value ?? 0;
  }

  // Map 14-day total units sold per SKU
  const unitsBySku: Record<string, number> = {};
  for (const row of sales) {
    const sku = row.metric_key.replace('sku_units_', '');
    unitsBySku[sku] = (unitsBySku[sku] ?? 0) + (row.metric_value ?? 0);
  }

  const atRisk: Array<{ sku: string; daysLeft: number }> = [];
  for (const [sku, invQty] of Object.entries(invBySku)) {
    const units14d = unitsBySku[sku] ?? 0;
    if (units14d <= 0) continue;
    const avgDailySales = units14d / 14;
    const daysLeft = Math.floor(invQty / avgDailySales);
    if (daysLeft < 14) atRisk.push({ sku, daysLeft });
  }

  if (atRisk.length === 0) return null;

  atRisk.sort((a, b) => a.daysLeft - b.daysLeft);
  const worst = atRisk[0];
  const skuList = atRisk.slice(0, 3).map(s => `${s.sku} (${s.daysLeft}d)`).join(', ');

  return make(brandId, 'stockout_risk', 'warning',
    `${atRisk.length} SKU${atRisk.length > 1 ? 's' : ''} at stockout risk: ${skuList}`,
    {
      at_risk_skus: atRisk,
      pending_action: 'reorder_supplier',
      action_sku: worst.sku,
      action_description: `Reply YES to send reorder WhatsApp to your supplier for ${worst.sku}`,
    }
  );
}

// ── Main runner ───────────────────────────────────────────────────────────
export async function runAllAlertChecks(brandId: string): Promise<Alert[]> {
  const supabase = createServiceClient();

  const results = await Promise.allSettled([
    checkRoasDrop(brandId),
    checkCreativeFatigue(brandId),
    checkRtoSpike(brandId),
    checkCashRunway(brandId),
    checkStockoutRisk(brandId),
  ]);

  const saved: Alert[] = [];

  for (const result of results) {
    if (result.status !== 'fulfilled' || !result.value) continue;
    const candidate = result.value;

    const { data: created } = await supabase
      .from('alerts')
      .insert({
        brand_id: candidate.brand_id,
        alert_type: candidate.alert_type,
        severity: candidate.severity,
        message: candidate.message,
        data: candidate.data,
      })
      .select()
      .single();

    if (created) saved.push(created as Alert);
  }

  return saved;
}
