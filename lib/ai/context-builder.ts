import { createServiceClient } from '@/lib/supabase/service';
import { loadBrandMemory } from './memory';
import type { Brand, BrandContext, Alert, ChatMessage, CourierMetric } from '@/types';

export interface RichBrandContext {
  brand: Brand;
  brandContext: BrandContext | null;
  connectedSources: string[];

  // Revenue by channel (last 30 days)
  revenueByChannel: Record<string, number>;
  channelBreakdownPct: Record<string, number>;

  // 7-day window
  revenueByDay: Record<string, number>;
  revenue7d: number;
  revenuePrev7d: number;
  orders7d: number;

  // Ad performance (last 7 days)
  adSpendByPlatform: Record<string, number>;
  adRevenueByPlatform: Record<string, number>;
  roas7dByPlatform: Record<string, number>;
  blendedRoas7d: number | null;

  // Logistics
  rtoRate7d: number | null;
  rtoRate30d: number | null;
  courierPerformance: CourierMetric[];
  topRtoCities: Array<{ city: string; rate: number }>;

  // Cash
  cashPosition: number | null;
  dailyBurn30d: number | null;
  runwayDays: number | null;

  // Alerts
  recentAlerts: Alert[];

  // Conversation continuity
  recentMessages: ChatMessage[];

  // Memory
  brandMemory: string;

  // India context
  upcomingFestivals: string[];
  gstWarning: string | null;
}

// ── India context helpers ─────────────────────────────────────────────────

const FESTIVALS = [
  { name: 'Republic Day Sale', month: 1, day: 26 },
  { name: "Valentine's Day", month: 2, day: 14 },
  { name: 'Holi', month: 3, day: 25 },
  { name: "Mother's Day", month: 5, day: 11 },
  { name: 'Raksha Bandhan', month: 8, day: 9 },
  { name: 'Independence Day Sale', month: 8, day: 15 },
  { name: 'Onam', month: 9, day: 5 },
  { name: 'Navratri/Durga Puja', month: 10, day: 2 },
  { name: 'Diwali / Great Indian Festival', month: 10, day: 20 },
  { name: 'Christmas / Year-End Sale', month: 12, day: 25 },
];

function getUpcomingFestivals(today: Date): string[] {
  const year = today.getFullYear();
  const upcoming: string[] = [];

  for (const f of FESTIVALS) {
    let festDate = new Date(year, f.month - 1, f.day);
    if (festDate < today) festDate = new Date(year + 1, f.month - 1, f.day);
    const daysUntil = Math.floor((festDate.getTime() - today.getTime()) / 86400_000);
    if (daysUntil >= 0 && daysUntil <= 60) {
      upcoming.push(`${f.name} in ${daysUntil} days`);
    }
  }

  return upcoming;
}

function getGstWarning(today: Date): string | null {
  const day = today.getDate();
  // GSTR-1 due 11th, GSTR-3B due 20th
  if (day >= 8 && day <= 11) return 'GSTR-1 filing due by the 11th — verify outward supply data';
  if (day >= 15 && day <= 20) return 'GSTR-3B filing due by the 20th — ensure tax payments are ready';
  // Quarterly GSTR-3B (QRMP): due 22nd/24th of month after quarter end
  const month = today.getMonth() + 1;
  const isQuarterEnd = [1, 4, 7, 10].includes(month) && day >= 18 && day <= 24;
  if (isQuarterEnd) return 'Quarterly GSTR-3B deadline this week for QRMP filers';
  return null;
}

// ── Main builder ──────────────────────────────────────────────────────────
export async function buildBrandContext(brandId: string): Promise<RichBrandContext> {
  const supabase = createServiceClient();

  const thirtyDaysAgo   = new Date(Date.now() - 30 * 86400_000).toISOString().slice(0, 10);
  const seventyTwoHoursAgo = new Date(Date.now() - 72 * 3600_000).toISOString();

  const [brandRes, contextRes, metricsRes, alertsRes, convRes, integrationsRes, memoryStr] =
    await Promise.all([
      supabase.from('brands').select('*').eq('id', brandId).single(),
      supabase.from('brand_context').select('*').eq('brand_id', brandId).single(),
      supabase
        .from('metrics_daily')
        .select('date, source, metric_key, metric_value, metadata')
        .eq('brand_id', brandId)
        .gte('date', thirtyDaysAgo)
        .order('date', { ascending: false }),
      supabase
        .from('alerts')
        .select('*')
        .eq('brand_id', brandId)
        .is('resolved_at', null)
        .gte('triggered_at', seventyTwoHoursAgo)
        .order('triggered_at', { ascending: false }),
      supabase
        .from('conversations')
        .select('messages')
        .eq('brand_id', brandId)
        .order('updated_at', { ascending: false })
        .limit(1)
        .single(),
      supabase
        .from('integrations')
        .select('source, sync_status, last_synced_at')
        .eq('brand_id', brandId),
      loadBrandMemory(brandId),
    ]);

  const brand        = brandRes.data as Brand;
  const brandContext = contextRes.data as BrandContext | null;
  const metrics      = metricsRes.data ?? [];
  const recentAlerts = (alertsRes.data ?? []) as Alert[];
  const recentMessages: ChatMessage[] = convRes.data
    ? (convRes.data.messages as ChatMessage[]).slice(-5)
    : [];
  const connectedSources = (integrationsRes.data ?? [])
    .filter(i => i.sync_status === 'success' || i.sync_status === 'pending')
    .map(i => i.source);

  // ── Date windows ──
  const sevenDaysAgo    = new Date(Date.now() - 7 * 86400_000);
  const fourteenDaysAgo = new Date(Date.now() - 14 * 86400_000);

  // ── Aggregation ──
  const revenueByDay: Record<string, number>      = {};
  const revenueByChannel: Record<string, number>  = {};
  const adSpendByPlatform: Record<string, number> = {};
  const adRevenueByPlatform: Record<string, number> = {};

  let revenue7d     = 0;
  let revenuePrev7d = 0;
  let orders7d      = 0;
  let rtoSum7d = 0; let rtoCount7d = 0;
  let rtoSum30d = 0; let rtoCount30d = 0;
  let cashPosition: number | null = null;
  let totalAdSpend30d = 0;

  const courierMap: Record<string, { rtoRate: number; avgDeliveryDays: number; slaBreachRate: number }> = {};
  const cityRtoList: Array<{ city: string; rate: number }> = [];

  for (const m of metrics) {
    const date = new Date(m.date + 'T00:00:00');
    const val  = m.metric_value ?? 0;
    const isLast7  = date >= sevenDaysAgo;
    const isPrev7  = date >= fourteenDaysAgo && date < sevenDaysAgo;

    // Revenue channels: shopify, flipkart, amazon, meesho
    const revSources = ['shopify', 'flipkart', 'amazon', 'meesho'];
    if (revSources.includes(m.source) && m.metric_key === 'revenue') {
      revenueByChannel[m.source] = (revenueByChannel[m.source] ?? 0) + val;
      if (isLast7) {
        revenueByDay[m.date] = (revenueByDay[m.date] ?? 0) + val;
        revenue7d += val;
      }
      if (isPrev7) revenuePrev7d += val;
    }

    // Shopify-specific
    if (m.source === 'shopify') {
      if (m.metric_key === 'orders' && isLast7)   orders7d += val;
      if (m.metric_key === 'rto_rate') {
        rtoSum30d += val; rtoCount30d++;
        if (isLast7) { rtoSum7d += val; rtoCount7d++; }
      }
    }

    // Ad platforms
    if (['meta', 'google'].includes(m.source)) {
      if (m.metric_key === 'spend') {
        totalAdSpend30d += val;
        if (isLast7) adSpendByPlatform[m.source] = (adSpendByPlatform[m.source] ?? 0) + val;
      }
      if (m.metric_key === 'revenue' && isLast7) {
        adRevenueByPlatform[m.source] = (adRevenueByPlatform[m.source] ?? 0) + val;
      }
    }

    // Cash position (latest tally row)
    if (m.source === 'tally_csv' && m.metric_key === 'cash_position' && cashPosition === null) {
      cashPosition = val;
    }

    // Courier performance from shiprocket
    if (m.source === 'shiprocket') {
      const courierMatch = m.metric_key.match(/^(rto_rate|avg_delivery_days|sla_breach_rate)_(.+)$/);
      if (courierMatch) {
        const [, metricType, courierKey] = courierMatch;
        const courierName = (m.metadata as Record<string, unknown>)?.courier as string ?? courierKey;
        if (!courierMap[courierName]) courierMap[courierName] = { rtoRate: 0, avgDeliveryDays: 0, slaBreachRate: 0 };
        if (metricType === 'rto_rate')         courierMap[courierName].rtoRate = val;
        if (metricType === 'avg_delivery_days') courierMap[courierName].avgDeliveryDays = val;
        if (metricType === 'sla_breach_rate')   courierMap[courierName].slaBreachRate = val;
      }

      const cityMatch = m.metric_key.match(/^city_rto_(.+)$/);
      if (cityMatch) {
        const city = (m.metadata as Record<string, unknown>)?.city as string ?? cityMatch[1];
        cityRtoList.push({ city, rate: val });
      }
    }
  }

  // ── Derived metrics ──
  const roas7dByPlatform: Record<string, number> = {};
  let totalAdSpend7d = 0;
  let totalAdRevenue7d = 0;
  for (const platform of Object.keys(adSpendByPlatform)) {
    const spend = adSpendByPlatform[platform];
    const rev   = adRevenueByPlatform[platform] ?? 0;
    roas7dByPlatform[platform] = spend > 0 ? rev / spend : 0;
    totalAdSpend7d   += spend;
    totalAdRevenue7d += rev;
  }
  const blendedRoas7d = totalAdSpend7d > 0 ? totalAdRevenue7d / totalAdSpend7d : null;

  // Channel breakdown %
  const totalRevenue30d = Object.values(revenueByChannel).reduce((a, b) => a + b, 0);
  const channelBreakdownPct: Record<string, number> = {};
  if (totalRevenue30d > 0) {
    for (const [ch, rev] of Object.entries(revenueByChannel)) {
      channelBreakdownPct[ch] = Math.round((rev / totalRevenue30d) * 100);
    }
  }

  // Courier metrics list
  const courierPerformance: CourierMetric[] = Object.entries(courierMap).map(([courier, c]) => ({
    courier,
    ...c,
  }));

  // Top RTO cities
  const topRtoCities = cityRtoList.sort((a, b) => b.rate - a.rate).slice(0, 5);

  // Daily burn & runway
  const dailyBurn30d = totalAdSpend30d > 0 ? totalAdSpend30d / 30 : null;
  const runwayDays = cashPosition !== null && dailyBurn30d && dailyBurn30d > 0
    ? Math.floor(cashPosition / dailyBurn30d)
    : null;

  const today = new Date();

  return {
    brand,
    brandContext,
    connectedSources,
    revenueByChannel,
    channelBreakdownPct,
    revenueByDay,
    revenue7d,
    revenuePrev7d,
    orders7d,
    adSpendByPlatform,
    adRevenueByPlatform,
    roas7dByPlatform,
    blendedRoas7d,
    rtoRate7d:  rtoCount7d  > 0 ? rtoSum7d  / rtoCount7d  : null,
    rtoRate30d: rtoCount30d > 0 ? rtoSum30d / rtoCount30d : null,
    courierPerformance,
    topRtoCities,
    cashPosition,
    dailyBurn30d,
    runwayDays,
    recentAlerts,
    recentMessages,
    brandMemory: memoryStr,
    upcomingFestivals: getUpcomingFestivals(today),
    gstWarning: getGstWarning(today),
  };
}
