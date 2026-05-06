import { createClient } from '@/lib/supabase/server';
import type { Brand, BrandContext, Alert, ChatMessage } from '@/types';

export interface AIContext {
  brand: Brand;
  brandContext: BrandContext | null;
  revenueByDay: Record<string, number>;
  revenue7d: number;
  revenuePrev7d: number;
  orders7d: number;
  adSpendByPlatform: Record<string, number>;
  adRevenueByPlatform: Record<string, number>;
  roas7dByPlatform: Record<string, number>;
  rtoRate7d: number | null;
  cashPosition: number | null;
  recentAlerts: Alert[];
  recentMessages: ChatMessage[];
}

export async function buildBrandContext(brandId: string): Promise<AIContext> {
  const supabase = createClient();

  const thirtyDaysAgo = new Date(Date.now() - 30 * 86400_000).toISOString().slice(0, 10);
  const fortyEightHoursAgo = new Date(Date.now() - 48 * 3600_000).toISOString();

  const [brandRes, contextRes, metricsRes, alertsRes, convRes] = await Promise.all([
    supabase.from('brands').select('*').eq('id', brandId).single(),
    supabase.from('brand_context').select('*').eq('brand_id', brandId).single(),
    supabase
      .from('metrics_daily')
      .select('date, source, metric_key, metric_value')
      .eq('brand_id', brandId)
      .gte('date', thirtyDaysAgo)
      .order('date', { ascending: false }),
    supabase
      .from('alerts')
      .select('*')
      .eq('brand_id', brandId)
      .is('resolved_at', null)
      .gte('triggered_at', fortyEightHoursAgo)
      .order('triggered_at', { ascending: false }),
    supabase
      .from('conversations')
      .select('messages')
      .eq('brand_id', brandId)
      .order('updated_at', { ascending: false })
      .limit(1)
      .single(),
  ]);

  const brand = brandRes.data as Brand;
  const brandContext = contextRes.data as BrandContext | null;
  const metrics = metricsRes.data ?? [];
  const recentAlerts = (alertsRes.data ?? []) as Alert[];
  const recentMessages: ChatMessage[] = convRes.data
    ? (convRes.data.messages as ChatMessage[]).slice(-5)
    : [];

  const sevenDaysAgo = new Date(Date.now() - 7 * 86400_000);
  const fourteenDaysAgo = new Date(Date.now() - 14 * 86400_000);

  const revenueByDay: Record<string, number> = {};
  let revenue7d = 0;
  let revenuePrev7d = 0;
  let orders7d = 0;
  let rtoSum = 0;
  let rtoCount = 0;
  let cashPosition: number | null = null;
  const adSpendByPlatform: Record<string, number> = {};
  const adRevenueByPlatform: Record<string, number> = {};

  for (const m of metrics) {
    const date = new Date(m.date);
    const val = m.metric_value ?? 0;
    const isLast7 = date >= sevenDaysAgo;
    const isPrev7 = date >= fourteenDaysAgo && date < sevenDaysAgo;

    if (m.source === 'shopify') {
      if (m.metric_key === 'revenue') {
        revenueByDay[m.date] = (revenueByDay[m.date] ?? 0) + val;
        if (isLast7) revenue7d += val;
        if (isPrev7) revenuePrev7d += val;
      }
      if (m.metric_key === 'orders' && isLast7) orders7d += val;
      if (m.metric_key === 'rto_rate' && isLast7) { rtoSum += val; rtoCount++; }
    }

    if ((m.source === 'meta' || m.source === 'google') && isLast7) {
      if (m.metric_key === 'spend') {
        adSpendByPlatform[m.source] = (adSpendByPlatform[m.source] ?? 0) + val;
      }
      if (m.metric_key === 'revenue') {
        adRevenueByPlatform[m.source] = (adRevenueByPlatform[m.source] ?? 0) + val;
      }
    }

    if (m.source === 'tally_csv' && m.metric_key === 'cash_position' && cashPosition === null) {
      cashPosition = val;
    }
  }

  const roas7dByPlatform: Record<string, number> = {};
  for (const platform of Object.keys(adSpendByPlatform)) {
    const spend = adSpendByPlatform[platform];
    const rev = adRevenueByPlatform[platform] ?? 0;
    roas7dByPlatform[platform] = spend > 0 ? rev / spend : 0;
  }

  return {
    brand,
    brandContext,
    revenueByDay,
    revenue7d,
    revenuePrev7d,
    orders7d,
    adSpendByPlatform,
    adRevenueByPlatform,
    roas7dByPlatform,
    rtoRate7d: rtoCount > 0 ? rtoSum / rtoCount : null,
    cashPosition,
    recentAlerts,
    recentMessages,
  };
}
