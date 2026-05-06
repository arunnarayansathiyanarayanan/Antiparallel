import { createClient } from '@/lib/supabase/server';
import type { SkuMetric } from '@/types';

const API_VERSION = '2024-01';
const SCOPES = 'read_orders,read_products,read_inventory';

export function getShopifyOAuthUrl(shop: string): string {
  const redirectUri = `${process.env.NEXT_PUBLIC_APP_URL}/api/integrations/shopify/auth`;
  const params = new URLSearchParams({
    client_id: process.env.SHOPIFY_API_KEY!,
    scope: SCOPES,
    redirect_uri: redirectUri,
    state: crypto.randomUUID(),
  });
  return `https://${shop}/admin/oauth/authorize?${params}`;
}

export async function exchangeShopifyCode(shop: string, code: string): Promise<string> {
  const res = await fetch(`https://${shop}/admin/oauth/access_token`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
      client_id: process.env.SHOPIFY_API_KEY,
      client_secret: process.env.SHOPIFY_API_SECRET,
      code,
    }),
  });
  if (!res.ok) throw new Error(`Shopify token exchange failed: ${res.status} ${res.statusText}`);
  const data = await res.json() as { access_token: string };
  return data.access_token;
}

async function shopifyGet(shopDomain: string, accessToken: string, path: string): Promise<Response> {
  const url = `https://${shopDomain}/admin/api/${API_VERSION}/${path}`;
  let delay = 500;
  for (let attempt = 0; attempt < 6; attempt++) {
    const res = await fetch(url, {
      headers: { 'X-Shopify-Access-Token': accessToken },
    });
    if (res.status !== 429) return res;
    await new Promise(r => setTimeout(r, delay));
    delay = Math.min(delay * 2, 16000);
  }
  throw new Error('Shopify rate limit: too many retries');
}

export async function syncShopifyData(
  brandId: string,
  shopDomain: string,
  accessToken: string
): Promise<void> {
  const supabase = createClient();

  const since = new Date();
  since.setDate(since.getDate() - 90);
  const sinceIso = since.toISOString();

  await supabase
    .from('integrations')
    .update({ sync_status: 'syncing' })
    .eq('brand_id', brandId)
    .eq('source', 'shopify');

  try {
    const orders: ShopifyOrder[] = [];
    let nextPath: string | null =
      `orders.json?status=any&created_at_min=${encodeURIComponent(sinceIso)}&limit=250` +
      `&fields=id,created_at,total_price,financial_status,fulfillment_status,line_items`;

    while (nextPath) {
      const res = await shopifyGet(shopDomain, accessToken, nextPath);
      if (!res.ok) throw new Error(`Orders fetch failed: ${res.status}`);
      const body = await res.json() as { orders: ShopifyOrder[] };
      orders.push(...body.orders);

      const link = res.headers.get('Link') ?? '';
      const match = link.match(/<([^>]+)>;\s*rel="next"/);
      if (match) {
        const next = new URL(match[1]);
        nextPath = next.pathname.replace(`/admin/api/${API_VERSION}/`, '') + next.search;
      } else {
        nextPath = null;
      }
    }

    // Aggregate daily metrics and SKU revenue
    const daily = new Map<string, DailyAgg>();
    const skuMap = new Map<string, SkuAgg>();

    for (const order of orders) {
      const date = order.created_at.slice(0, 10);
      const d = daily.get(date) ?? { revenue: 0, orders: 0, returns: 0 };
      const total = parseFloat(order.total_price ?? '0');
      const isReturn =
        order.financial_status === 'refunded' ||
        order.financial_status === 'partially_refunded';

      if (isReturn) {
        d.returns++;
      } else {
        d.revenue += total;
        d.orders++;
        for (const item of order.line_items ?? []) {
          const key = item.sku ?? item.title;
          const s = skuMap.get(key) ?? { title: item.title, sku: item.sku ?? '', revenue: 0, units: 0, orders: 0 };
          s.revenue += parseFloat(item.price) * item.quantity;
          s.units += item.quantity;
          s.orders++;
          skuMap.set(key, s);
        }
      }
      daily.set(date, d);
    }

    // Build upsert rows for metrics_daily
    type MetricRow = {
      brand_id: string;
      date: string;
      source: string;
      metric_key: string;
      metric_value: number;
      metadata: Record<string, unknown>;
    };
    const rows: MetricRow[] = [];

    Array.from(daily.entries()).forEach(([date, d]) => {
      const total = d.orders + d.returns;
      const aov = d.orders > 0 ? d.revenue / d.orders : 0;
      const rtoRate = total > 0 ? (d.returns / total) * 100 : 0;
      rows.push(
        { brand_id: brandId, date, source: 'shopify', metric_key: 'revenue', metric_value: d.revenue, metadata: {} },
        { brand_id: brandId, date, source: 'shopify', metric_key: 'orders', metric_value: d.orders, metadata: {} },
        { brand_id: brandId, date, source: 'shopify', metric_key: 'aov', metric_value: aov, metadata: {} },
        { brand_id: brandId, date, source: 'shopify', metric_key: 'rto_rate', metric_value: rtoRate, metadata: {} },
        { brand_id: brandId, date, source: 'shopify', metric_key: 'return_count', metric_value: d.returns, metadata: {} },
      );
    });

    // SKU revenue rows — keyed by sku so one row per SKU, summed across dates
    const today = new Date().toISOString().slice(0, 10);
    Array.from(skuMap.values()).forEach(s => {
      rows.push({
        brand_id: brandId,
        date: today,
        source: 'shopify',
        metric_key: 'sku_revenue',
        metric_value: s.revenue,
        metadata: { sku: s.sku, title: s.title, units_sold: s.units, orders: s.orders },
      });
    });

    if (rows.length > 0) {
      const BATCH = 500;
      for (let i = 0; i < rows.length; i += BATCH) {
        await supabase
          .from('metrics_daily')
          .upsert(rows.slice(i, i + BATCH), { onConflict: 'brand_id,date,source,metric_key' });
      }
    }

    await supabase
      .from('integrations')
      .update({
        sync_status: 'success',
        last_synced_at: new Date().toISOString(),
        error_message: null,
      })
      .eq('brand_id', brandId)
      .eq('source', 'shopify');
  } catch (err) {
    await supabase
      .from('integrations')
      .update({ sync_status: 'error', error_message: (err as Error).message })
      .eq('brand_id', brandId)
      .eq('source', 'shopify');
    throw err;
  }
}

export async function getTopSkus(brandId: string, days: number): Promise<SkuMetric[]> {
  const supabase = createClient();
  const since = new Date();
  since.setDate(since.getDate() - days);

  const { data } = await supabase
    .from('metrics_daily')
    .select('metric_value, metadata')
    .eq('brand_id', brandId)
    .eq('source', 'shopify')
    .eq('metric_key', 'sku_revenue')
    .gte('date', since.toISOString().slice(0, 10))
    .order('metric_value', { ascending: false })
    .limit(10);

  return (data ?? []).map(row => {
    const m = row.metadata as Record<string, unknown>;
    return {
      sku: (m.sku as string) ?? '',
      title: (m.title as string) ?? '',
      revenue: row.metric_value ?? 0,
      units_sold: (m.units_sold as number) ?? 0,
      orders: (m.orders as number) ?? 0,
    };
  });
}

// Internal types
interface ShopifyOrder {
  id: number;
  created_at: string;
  total_price: string;
  financial_status: string;
  fulfillment_status: string | null;
  line_items: ShopifyLineItem[];
}

interface ShopifyLineItem {
  sku: string | null;
  title: string;
  quantity: number;
  price: string;
}

interface DailyAgg {
  revenue: number;
  orders: number;
  returns: number;
}

interface SkuAgg {
  sku: string;
  title: string;
  revenue: number;
  units: number;
  orders: number;
}
