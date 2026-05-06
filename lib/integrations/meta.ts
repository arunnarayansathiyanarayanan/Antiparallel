import { createClient } from '@/lib/supabase/server';
import type { CreativeMetric } from '@/types';

const GRAPH_API = 'https://graph.facebook.com/v19.0';
const SCOPES = 'ads_read,ads_management,read_insights';

export function getMetaOAuthUrl(): string {
  const redirectUri = `${process.env.NEXT_PUBLIC_APP_URL}/api/integrations/meta/auth`;
  const params = new URLSearchParams({
    client_id: process.env.META_APP_ID!,
    redirect_uri: redirectUri,
    scope: SCOPES,
    response_type: 'code',
  });
  return `https://www.facebook.com/v19.0/dialog/oauth?${params}`;
}

export async function exchangeMetaCode(code: string): Promise<string> {
  const redirectUri = `${process.env.NEXT_PUBLIC_APP_URL}/api/integrations/meta/auth`;

  // Step 1: exchange code for short-lived token
  const shortRes = await fetch(
    `${GRAPH_API}/oauth/access_token?` +
      new URLSearchParams({
        client_id: process.env.META_APP_ID!,
        client_secret: process.env.META_APP_SECRET!,
        redirect_uri: redirectUri,
        code,
      })
  );
  if (!shortRes.ok) throw new Error(`Meta code exchange failed: ${shortRes.status}`);
  const { access_token: shortToken } = await shortRes.json() as { access_token: string };

  // Step 2: exchange short-lived for long-lived token (60-day expiry)
  const longRes = await fetch(
    `${GRAPH_API}/oauth/access_token?` +
      new URLSearchParams({
        grant_type: 'fb_exchange_token',
        client_id: process.env.META_APP_ID!,
        client_secret: process.env.META_APP_SECRET!,
        fb_exchange_token: shortToken,
      })
  );
  if (!longRes.ok) throw new Error(`Meta long-lived token exchange failed: ${longRes.status}`);
  const { access_token: longToken } = await longRes.json() as { access_token: string };
  return longToken;
}

export async function syncMetaAdsData(
  brandId: string,
  adAccountId: string,
  accessToken: string
): Promise<void> {
  const supabase = createClient();

  const since = new Date();
  since.setDate(since.getDate() - 90);
  const until = new Date();

  await supabase
    .from('integrations')
    .update({ sync_status: 'syncing' })
    .eq('brand_id', brandId)
    .eq('source', 'meta');

  try {
    // Fetch campaign-level daily insights
    const insightsUrl =
      `${GRAPH_API}/act_${adAccountId}/insights?` +
      new URLSearchParams({
        access_token: accessToken,
        level: 'campaign',
        time_increment: '1',
        time_range: JSON.stringify({
          since: since.toISOString().slice(0, 10),
          until: until.toISOString().slice(0, 10),
        }),
        fields: 'date_start,spend,impressions,clicks,actions,action_values,purchase_roas',
        limit: '500',
      });

    const insightsRes = await fetch(insightsUrl);
    if (!insightsRes.ok) throw new Error(`Meta insights failed: ${insightsRes.status}`);
    const insightsBody = await insightsRes.json() as MetaInsightsResponse;

    // Aggregate by date
    type DailyAgg = {
      spend: number;
      impressions: number;
      clicks: number;
      conversions: number;
      conversionValue: number;
    };
    const dailyMap: Record<string, DailyAgg> = {};

    for (const row of insightsBody.data ?? []) {
      const date = row.date_start;
      const d = dailyMap[date] ?? { spend: 0, impressions: 0, clicks: 0, conversions: 0, conversionValue: 0 };
      d.spend += parseFloat(row.spend ?? '0');
      d.impressions += parseInt(row.impressions ?? '0', 10);
      d.clicks += parseInt(row.clicks ?? '0', 10);

      // Extract purchase conversions
      for (const action of row.actions ?? []) {
        if (action.action_type === 'purchase') {
          d.conversions += parseFloat(action.value ?? '0');
        }
      }
      for (const av of row.action_values ?? []) {
        if (av.action_type === 'purchase') {
          d.conversionValue += parseFloat(av.value ?? '0');
        }
      }
      dailyMap[date] = d;
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
      const roas = d.spend > 0 ? d.conversionValue / d.spend : 0;
      const cpm = d.impressions > 0 ? (d.spend / d.impressions) * 1000 : 0;
      const ctr = d.impressions > 0 ? (d.clicks / d.impressions) * 100 : 0;
      rows.push(
        { brand_id: brandId, date, source: 'meta', metric_key: 'spend', metric_value: d.spend, metadata: {} },
        { brand_id: brandId, date, source: 'meta', metric_key: 'roas', metric_value: roas, metadata: {} },
        { brand_id: brandId, date, source: 'meta', metric_key: 'revenue', metric_value: d.conversionValue, metadata: {} },
        { brand_id: brandId, date, source: 'meta', metric_key: 'impressions', metric_value: d.impressions, metadata: {} },
        { brand_id: brandId, date, source: 'meta', metric_key: 'clicks', metric_value: d.clicks, metadata: {} },
        { brand_id: brandId, date, source: 'meta', metric_key: 'cpm', metric_value: cpm, metadata: {} },
        { brand_id: brandId, date, source: 'meta', metric_key: 'ctr', metric_value: ctr, metadata: {} },
        { brand_id: brandId, date, source: 'meta', metric_key: 'conversions', metric_value: d.conversions, metadata: {} },
      );
    }

    // Fetch ad-level creative performance
    const adUrl =
      `${GRAPH_API}/act_${adAccountId}/insights?` +
      new URLSearchParams({
        access_token: accessToken,
        level: 'ad',
        date_preset: 'last_30d',
        fields: 'ad_id,ad_name,spend,impressions,clicks,actions,action_values',
        limit: '200',
      });

    const adRes = await fetch(adUrl);
    if (adRes.ok) {
      const adBody = await adRes.json() as MetaInsightsResponse;
      const today = new Date().toISOString().slice(0, 10);
      for (const ad of adBody.data ?? []) {
        const spend = parseFloat(ad.spend ?? '0');
        const impressions = parseInt(ad.impressions ?? '0', 10);
        const clicks = parseInt(ad.clicks ?? '0', 10);
        let convValue = 0;
        for (const av of ad.action_values ?? []) {
          if (av.action_type === 'purchase') convValue += parseFloat(av.value ?? '0');
        }
        const adRoas = spend > 0 ? convValue / spend : 0;
        const adCtr = impressions > 0 ? (clicks / impressions) * 100 : 0;
        rows.push({
          brand_id: brandId,
          date: today,
          source: 'meta',
          metric_key: `creative_${ad.ad_id}`,
          metric_value: adRoas,
          metadata: {
            creative_id: ad.ad_id,
            name: ad.ad_name,
            spend,
            impressions,
            clicks,
            ctr: adCtr,
            roas: adRoas,
          },
        });
      }
    }

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
      .eq('source', 'meta');
  } catch (err) {
    await supabase
      .from('integrations')
      .update({ sync_status: 'error', error_message: (err as Error).message })
      .eq('brand_id', brandId)
      .eq('source', 'meta');
    throw err;
  }
}

export async function getAdCreativePerformance(
  brandId: string,
  days: number
): Promise<CreativeMetric[]> {
  const supabase = createClient();
  const since = new Date();
  since.setDate(since.getDate() - days);

  const { data } = await supabase
    .from('metrics_daily')
    .select('metric_value, metadata')
    .eq('brand_id', brandId)
    .eq('source', 'meta')
    .like('metric_key', 'creative_%')
    .gte('date', since.toISOString().slice(0, 10))
    .order('metric_value', { ascending: false })
    .limit(20);

  return (data ?? []).map(row => {
    const m = row.metadata as Record<string, unknown>;
    return {
      creative_id: (m.creative_id as string) ?? '',
      name: (m.name as string) ?? '',
      spend: (m.spend as number) ?? 0,
      roas: (m.roas as number) ?? 0,
      ctr: (m.ctr as number) ?? 0,
      impressions: (m.impressions as number) ?? 0,
      clicks: (m.clicks as number) ?? 0,
    };
  });
}

// Internal types
interface MetaInsightsRow {
  date_start: string;
  spend?: string;
  impressions?: string;
  clicks?: string;
  ad_id?: string;
  ad_name?: string;
  actions?: Array<{ action_type: string; value?: string }>;
  action_values?: Array<{ action_type: string; value?: string }>;
  purchase_roas?: Array<{ action_type: string; value?: string }>;
}

interface MetaInsightsResponse {
  data?: MetaInsightsRow[];
  paging?: { cursors?: { after?: string }; next?: string };
}
