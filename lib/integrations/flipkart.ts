import { createServiceClient } from '@/lib/supabase/service';

const FLIPKART_API = 'https://api.flipkart.net/sellers';

// ── Auth helper ───────────────────────────────────────────────────────────
export function getFlipkartOAuthUrl(sellerId: string): string {
  const redirectUri = `${process.env.NEXT_PUBLIC_APP_URL}/api/integrations/flipkart/auth`;
  const params = new URLSearchParams({
    client_id: process.env.FLIPKART_APP_ID ?? '',
    redirect_uri: redirectUri,
    response_type: 'code',
    state: sellerId,
  });
  return `https://api.flipkart.net/oauth-service/oauth/authorize?${params}`;
}

export async function exchangeFlipkartCode(code: string): Promise<{ accessToken: string; refreshToken: string }> {
  const redirectUri = `${process.env.NEXT_PUBLIC_APP_URL}/api/integrations/flipkart/auth`;
  const res = await fetch('https://api.flipkart.net/oauth-service/oauth/token', {
    method: 'POST',
    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
    body: new URLSearchParams({
      grant_type: 'authorization_code',
      client_id: process.env.FLIPKART_APP_ID ?? '',
      client_secret: process.env.FLIPKART_APP_SECRET ?? '',
      code,
      redirect_uri: redirectUri,
    }),
  });
  if (!res.ok) throw new Error(`Flipkart token exchange failed: ${res.status}`);
  const json = await res.json() as { access_token: string; refresh_token: string };
  return { accessToken: json.access_token, refreshToken: json.refresh_token };
}

// ── Order sync ────────────────────────────────────────────────────────────
interface FlipkartOrder {
  orderId: string;
  orderDate: string;
  orderItems: Array<{
    skuId: string;
    title: string;
    sellingPrice: { amount: number };
    quantity: number;
    subStatus: string;
    cancellationReason?: string;
  }>;
  shipmentDetails?: { cityName: string; stateName: string };
}

interface FlipkartOrdersResponse {
  orderItems: FlipkartOrder[];
  hasMore: boolean;
  nextPageToken?: string;
}

export async function syncFlipkartOrders(
  brandId: string,
  accessToken: string
): Promise<void> {
  const supabase = createServiceClient();

  await supabase
    .from('integrations')
    .update({ sync_status: 'syncing' })
    .eq('brand_id', brandId)
    .eq('source', 'flipkart');

  try {
    const since = new Date();
    since.setDate(since.getDate() - 90);
    const sinceStr = since.toISOString().slice(0, 10);

    type DailyAgg = {
      revenue: number;
      orders: number;
      cancellations: number;
      units: number;
    };
    const dailyMap: Record<string, DailyAgg> = {};
    const skuRevMap: Record<string, Record<string, number>> = {}; // sku -> date -> revenue

    let pageToken: string | undefined;
    let hasMore = true;

    while (hasMore) {
      const params = new URLSearchParams({
        orderDate: sinceStr,
        ...(pageToken ? { pageToken } : {}),
      });

      const res = await fetch(`${FLIPKART_API}/orders/list?${params}`, {
        headers: {
          Authorization: `Bearer ${accessToken}`,
          'Content-Type': 'application/json',
        },
      });

      if (!res.ok) {
        const msg = await res.text();
        throw new Error(`Flipkart orders API error ${res.status}: ${msg}`);
      }

      const data = await res.json() as FlipkartOrdersResponse;

      for (const order of data.orderItems ?? []) {
        const date = order.orderDate.slice(0, 10);
        if (date < sinceStr) continue;

        const d = dailyMap[date] ?? { revenue: 0, orders: 0, cancellations: 0, units: 0 };

        for (const item of order.orderItems ?? []) {
          const isCancelled = ['CANCELLED', 'RETURN_REQUESTED', 'RETURNED'].includes(item.subStatus ?? '');
          const price = item.sellingPrice?.amount ?? 0;
          const qty   = item.quantity ?? 1;

          if (!isCancelled) {
            d.revenue += price * qty;
            d.orders++;
            d.units += qty;

            // SKU revenue tracking
            if (!skuRevMap[item.skuId]) skuRevMap[item.skuId] = {};
            skuRevMap[item.skuId][date] = (skuRevMap[item.skuId][date] ?? 0) + price * qty;
          } else {
            d.cancellations++;
          }
        }

        dailyMap[date] = d;
      }

      hasMore = data.hasMore ?? false;
      pageToken = data.nextPageToken;
    }

    type MetricRow = {
      brand_id: string;
      date: string;
      source: string;
      metric_key: string;
      metric_value: number;
      metadata: Record<string, unknown>;
    };
    const rows: MetricRow[] = [];

    for (const [date, d] of Object.entries(dailyMap)) {
      const cancelRate = d.orders + d.cancellations > 0
        ? d.cancellations / (d.orders + d.cancellations)
        : 0;
      rows.push(
        { brand_id: brandId, date, source: 'flipkart', metric_key: 'revenue',    metric_value: d.revenue,      metadata: {} },
        { brand_id: brandId, date, source: 'flipkart', metric_key: 'orders',     metric_value: d.orders,       metadata: {} },
        { brand_id: brandId, date, source: 'flipkart', metric_key: 'units',      metric_value: d.units,        metadata: {} },
        { brand_id: brandId, date, source: 'flipkart', metric_key: 'cancel_rate', metric_value: cancelRate,    metadata: {} },
      );
    }

    // Top SKU revenue rows
    for (const [sku, dateMap] of Object.entries(skuRevMap)) {
      for (const [date, rev] of Object.entries(dateMap)) {
        rows.push({
          brand_id: brandId, date, source: 'flipkart',
          metric_key: `sku_revenue_${sku}`, metric_value: rev, metadata: { sku },
        });
      }
    }

    const BATCH = 500;
    for (let i = 0; i < rows.length; i += BATCH) {
      await supabase
        .from('metrics_daily')
        .upsert(rows.slice(i, i + BATCH), { onConflict: 'brand_id,date,source,metric_key' });
    }

    await supabase
      .from('integrations')
      .update({ sync_status: 'success', last_synced_at: new Date().toISOString(), error_message: null })
      .eq('brand_id', brandId)
      .eq('source', 'flipkart');

  } catch (err) {
    await supabase
      .from('integrations')
      .update({ sync_status: 'error', error_message: (err as Error).message })
      .eq('brand_id', brandId)
      .eq('source', 'flipkart');
    throw err;
  }
}

// ── Competitor pricing (uses Flipkart product search) ─────────────────────
export interface CompetitorPrice {
  competitor: string;
  their_price: number;
  our_sku: string;
  price_gap_pct: number;
}

export async function getFlipkartCompetitorPricing(
  skuSearchTerms: string[],
  accessToken: string
): Promise<CompetitorPrice[]> {
  const results: CompetitorPrice[] = [];

  for (const term of skuSearchTerms.slice(0, 5)) {
    try {
      const res = await fetch(
        `${FLIPKART_API}/catalog/search?q=${encodeURIComponent(term)}&limit=5`,
        { headers: { Authorization: `Bearer ${accessToken}` } }
      );
      if (!res.ok) continue;
      const data = await res.json() as { products?: Array<{ title: string; price: number; sellerName: string }> };

      for (const product of data.products ?? []) {
        if (product.sellerName && product.price) {
          results.push({
            competitor: product.sellerName,
            their_price: product.price,
            our_sku: term,
            price_gap_pct: 0, // caller can compute with their own price
          });
        }
      }
    } catch {
      // skip on error
    }
  }

  return results;
}
