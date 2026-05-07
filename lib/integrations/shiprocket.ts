import { createServiceClient } from '@/lib/supabase/service';

const SHIPROCKET_API = 'https://apiv2.shiprocket.in/v1/external';

// ── Auth ──────────────────────────────────────────────────────────────────
async function getShiprocketToken(email: string, password: string): Promise<string> {
  const res = await fetch(`${SHIPROCKET_API}/auth/login`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ email, password }),
  });
  if (!res.ok) throw new Error(`Shiprocket auth failed: ${res.status}`);
  const data = await res.json() as { token: string };
  if (!data.token) throw new Error('Shiprocket: no token in response');
  return data.token;
}

// ── Shipment sync ─────────────────────────────────────────────────────────
interface ShiprocketShipment {
  awb_code: string;
  courier_name: string;
  pickup_date: string | null;
  delivered_date: string | null;
  status: string;
  city: string;
  state: string;
  is_return: boolean;
}

interface ShiprocketShipmentsResponse {
  data: {
    data: ShiprocketShipment[];
    meta: { pagination: { total: number; current_page: number; last_page: number } };
  };
}

export async function syncShiprocketData(
  brandId: string,
  email: string,
  password: string
): Promise<void> {
  const supabase = createServiceClient();

  await supabase
    .from('integrations')
    .update({ sync_status: 'syncing' })
    .eq('brand_id', brandId)
    .eq('source', 'shiprocket');

  try {
    const token = await getShiprocketToken(email, password);

    // Store refreshed token
    await supabase
      .from('integrations')
      .update({ access_token: token })
      .eq('brand_id', brandId)
      .eq('source', 'shiprocket');

    type CourierAgg = {
      total: number;
      delivered: number;
      rto: number;
      totalDeliveryDays: number;
      deliveredCount: number;
    };
    const courierMap: Record<string, CourierAgg> = {};
    const cityRtoMap: Record<string, { rto: number; total: number }> = {};

    let page = 1;
    let lastPage = 1;

    while (page <= lastPage && page <= 20) { // cap at 20 pages
      const res = await fetch(
        `${SHIPROCKET_API}/shipments?per_page=50&page=${page}`,
        { headers: { Authorization: `Bearer ${token}`, 'Content-Type': 'application/json' } }
      );
      if (!res.ok) break;

      const body = await res.json() as ShiprocketShipmentsResponse;
      const shipments = body?.data?.data ?? [];
      lastPage = body?.data?.meta?.pagination?.last_page ?? 1;

      for (const s of shipments) {
        const courier = s.courier_name ?? 'Unknown';
        const c = courierMap[courier] ?? { total: 0, delivered: 0, rto: 0, totalDeliveryDays: 0, deliveredCount: 0 };
        c.total++;

        if (s.status === 'DELIVERED' && s.pickup_date && s.delivered_date) {
          c.delivered++;
          const pickup    = new Date(s.pickup_date).getTime();
          const delivered = new Date(s.delivered_date).getTime();
          const days = Math.max(0, Math.round((delivered - pickup) / 86400_000));
          c.totalDeliveryDays += days;
          c.deliveredCount++;
        }

        if (s.is_return || ['RTO', 'RTO_INITIATED', 'RETURNED_TO_ORIGIN'].includes(s.status ?? '')) {
          c.rto++;
          const city = s.city ?? 'Unknown';
          cityRtoMap[city] = {
            rto: (cityRtoMap[city]?.rto ?? 0) + 1,
            total: (cityRtoMap[city]?.total ?? 0) + 1,
          };
        } else if (s.city) {
          cityRtoMap[s.city] = {
            rto: cityRtoMap[s.city]?.rto ?? 0,
            total: (cityRtoMap[s.city]?.total ?? 0) + 1,
          };
        }

        courierMap[courier] = c;
      }

      page++;
    }

    const today = new Date().toISOString().slice(0, 10);
    type MetricRow = {
      brand_id: string;
      date: string;
      source: string;
      metric_key: string;
      metric_value: number;
      metadata: Record<string, unknown>;
    };
    const rows: MetricRow[] = [];

    for (const [courier, c] of Object.entries(courierMap)) {
      if (c.total === 0) continue;
      const rtoRate = c.rto / c.total;
      const slaBreachRate = c.delivered > 0 ? 0 : 0; // improve when SLA data available
      const avgDeliveryDays = c.deliveredCount > 0 ? c.totalDeliveryDays / c.deliveredCount : 0;
      const safeCourier = courier.toLowerCase().replace(/[^a-z0-9]/g, '_');

      rows.push(
        { brand_id: brandId, date: today, source: 'shiprocket', metric_key: `rto_rate_${safeCourier}`, metric_value: rtoRate, metadata: { courier, total: c.total } },
        { brand_id: brandId, date: today, source: 'shiprocket', metric_key: `avg_delivery_days_${safeCourier}`, metric_value: avgDeliveryDays, metadata: { courier } },
        { brand_id: brandId, date: today, source: 'shiprocket', metric_key: `sla_breach_rate_${safeCourier}`, metric_value: slaBreachRate, metadata: { courier } },
      );
    }

    // Top 5 cities by RTO rate
    const cityRtoRates = Object.entries(cityRtoMap)
      .filter(([, v]) => v.total >= 5)
      .map(([city, v]) => ({ city, rate: v.rto / v.total }))
      .sort((a, b) => b.rate - a.rate)
      .slice(0, 5);

    for (const { city, rate } of cityRtoRates) {
      const safeCity = city.toLowerCase().replace(/[^a-z0-9]/g, '_');
      rows.push({
        brand_id: brandId, date: today, source: 'shiprocket',
        metric_key: `city_rto_${safeCity}`, metric_value: rate,
        metadata: { city },
      });
    }

    if (rows.length > 0) {
      await supabase
        .from('metrics_daily')
        .upsert(rows, { onConflict: 'brand_id,date,source,metric_key' });
    }

    await supabase
      .from('integrations')
      .update({ sync_status: 'success', last_synced_at: new Date().toISOString(), error_message: null })
      .eq('brand_id', brandId)
      .eq('source', 'shiprocket');

  } catch (err) {
    await supabase
      .from('integrations')
      .update({ sync_status: 'error', error_message: (err as Error).message })
      .eq('brand_id', brandId)
      .eq('source', 'shiprocket');
    throw err;
  }
}
