import { createServiceClient } from '@/lib/supabase/service';
import type { Alert } from '@/types';

type AlertInput = Omit<Alert, 'id' | 'triggered_at'>;

// Returns null if condition not met, or an unsaved Alert object if it is.
export async function checkRoasAlert(brandId: string): Promise<Alert | null> {
  const supabase = createServiceClient();
  const sevenDaysAgo = new Date(Date.now() - 7 * 86400_000).toISOString().slice(0, 10);
  const oneDayAgo = new Date(Date.now() - 86400_000).toISOString().slice(0, 10);

  const { data: metrics } = await supabase
    .from('metrics_daily')
    .select('date, metric_value')
    .eq('brand_id', brandId)
    .in('source', ['meta', 'google'])
    .eq('metric_key', 'roas')
    .gte('date', sevenDaysAgo);

  if (!metrics || metrics.length === 0) return null;

  const avg7d = metrics.reduce((s, m) => s + (m.metric_value ?? 0), 0) / metrics.length;
  const recent = metrics.filter(m => m.date >= oneDayAgo);
  if (recent.length === 0 || avg7d <= 0) return null;

  const avgRecent = recent.reduce((s, m) => s + (m.metric_value ?? 0), 0) / recent.length;
  const drop = (avg7d - avgRecent) / avg7d;
  if (drop <= 0.2) return null;

  return buildAlert(brandId, {
    alert_type: 'roas_drop',
    severity: 'critical',
    message: `Blended ROAS dropped ${(drop * 100).toFixed(0)}% in last 24h (${avgRecent.toFixed(2)}x vs ${avg7d.toFixed(2)}x 7d avg)`,
    data: { current_roas: avgRecent, avg_7d: avg7d, drop_pct: drop * 100 },
  });
}

export async function checkCreativeFatigueAlert(brandId: string): Promise<Alert | null> {
  const supabase = createServiceClient();
  const fourDaysAgo = new Date(Date.now() - 4 * 86400_000).toISOString().slice(0, 10);
  const twoDaysAgo = new Date(Date.now() - 2 * 86400_000).toISOString().slice(0, 10);

  const { data: metrics } = await supabase
    .from('metrics_daily')
    .select('date, metric_value')
    .eq('brand_id', brandId)
    .eq('source', 'meta')
    .eq('metric_key', 'ctr')
    .gte('date', fourDaysAgo);

  if (!metrics || metrics.length === 0) return null;

  const recentRows = metrics.filter(m => m.date >= twoDaysAgo);
  const prevRows = metrics.filter(m => m.date >= fourDaysAgo && m.date < twoDaysAgo);

  if (recentRows.length === 0 || prevRows.length === 0) return null;

  const recentCtr = recentRows.reduce((s, m) => s + (m.metric_value ?? 0), 0) / recentRows.length;
  const prevCtr = prevRows.reduce((s, m) => s + (m.metric_value ?? 0), 0) / prevRows.length;

  if (prevCtr <= 0) return null;
  const drop = (prevCtr - recentCtr) / prevCtr;
  if (drop <= 0.4) return null;

  return buildAlert(brandId, {
    alert_type: 'creative_fatigue',
    severity: 'warning',
    message: `Meta CTR dropped ${(drop * 100).toFixed(0)}% in last 48h (${recentCtr.toFixed(2)}% vs ${prevCtr.toFixed(2)}% prior period)`,
    data: { recent_ctr: recentCtr, prev_ctr: prevCtr, drop_pct: drop * 100 },
  });
}

export async function checkCashAlert(brandId: string): Promise<Alert | null> {
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
  const monthlySpend = (spendRes.data ?? []).reduce((s, m) => s + (m.metric_value ?? 0), 0);

  if (cash === null || monthlySpend <= 0 || cash >= monthlySpend * 2) return null;

  const weeksRunway = (cash / (monthlySpend / 4)).toFixed(1);

  return buildAlert(brandId, {
    alert_type: 'cash_low',
    severity: 'warning',
    message: `Cash ₹${Math.round(cash / 1000)}K is below 2× monthly ad spend — ~${weeksRunway} weeks of runway`,
    data: { cash, monthly_ad_spend: monthlySpend, weeks_runway: Number(weeksRunway) },
  });
}

export async function checkRtoAlert(brandId: string): Promise<Alert | null> {
  const supabase = createServiceClient();
  const thirtyDaysAgo = new Date(Date.now() - 30 * 86400_000).toISOString().slice(0, 10);
  const sevenDaysAgo = new Date(Date.now() - 7 * 86400_000).toISOString().slice(0, 10);

  const { data: metrics } = await supabase
    .from('metrics_daily')
    .select('date, metric_value')
    .eq('brand_id', brandId)
    .eq('source', 'shopify')
    .eq('metric_key', 'rto_rate')
    .gte('date', thirtyDaysAgo);

  if (!metrics || metrics.length < 3) return null;

  const avg30d = metrics.reduce((s, m) => s + (m.metric_value ?? 0), 0) / metrics.length;
  const recent7d = metrics.filter(m => m.date >= sevenDaysAgo);
  if (recent7d.length === 0) return null;

  const avgRecent = recent7d.reduce((s, m) => s + (m.metric_value ?? 0), 0) / recent7d.length;
  const spikePp = avgRecent - avg30d;
  if (spikePp <= 5) return null;

  return buildAlert(brandId, {
    alert_type: 'rto_spike',
    severity: avgRecent > 20 ? 'critical' : 'warning',
    message: `RTO spiked to ${avgRecent.toFixed(1)}% — ${spikePp.toFixed(1)}pp above 30d average (${avg30d.toFixed(1)}%)`,
    data: { current_rto: avgRecent, avg_30d: avg30d, spike_pp: spikePp },
  });
}

export async function runAllAlertChecks(brandId: string): Promise<Alert[]> {
  const supabase = createServiceClient();

  const candidates = await Promise.all([
    checkRoasAlert(brandId),
    checkCreativeFatigueAlert(brandId),
    checkCashAlert(brandId),
    checkRtoAlert(brandId),
  ]);

  const saved: Alert[] = [];

  for (const candidate of candidates) {
    if (!candidate) continue;

    // Skip if an unresolved alert of the same type already exists
    const { data: existing } = await supabase
      .from('alerts')
      .select('id')
      .eq('brand_id', brandId)
      .eq('alert_type', candidate.alert_type)
      .is('resolved_at', null)
      .limit(1)
      .single();

    if (existing) continue;

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

// Helper to build a full Alert shape without DB-generated fields
function buildAlert(
  brandId: string,
  partial: Pick<AlertInput, 'alert_type' | 'severity' | 'message' | 'data'>
): Alert {
  return {
    id: '',
    brand_id: brandId,
    triggered_at: new Date().toISOString(),
    resolved_at: null,
    notified_whatsapp: false,
    ...partial,
  };
}
