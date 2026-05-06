import { NextRequest } from 'next/server';
import { z } from 'zod';
import { createServiceClient } from '@/lib/supabase/service';
import { syncShopifyData } from '@/lib/integrations/shopify';
import { syncMetaAdsData } from '@/lib/integrations/meta';
import { runAllAlertChecks } from '@/lib/ai/alert-detector';

const authHeaderSchema = z.string().min(1);

function authorized(req: NextRequest): boolean {
  const parsed = authHeaderSchema.safeParse(req.headers.get('authorization'));
  if (!parsed.success) return false;
  return parsed.data === `Bearer ${process.env.CRON_SECRET}`;
}

interface SyncResult {
  brand_id: string;
  source: string;
  status: 'ok' | 'error';
  error?: string;
}

export async function GET(request: NextRequest) {
  try {
    if (!authorized(request)) {
      return Response.json({ error: 'Unauthorized' }, { status: 401 });
    }

    const supabase = createServiceClient();
    const results: SyncResult[] = [];
    let totalAlerts = 0;

    const { data: integrations, error: fetchErr } = await supabase
      .from('integrations')
      .select(`
        brand_id,
        source,
        shop_domain,
        account_id,
        access_token,
        brands!inner ( plan_status )
      `)
      .in('source', ['shopify', 'meta'])
      .not('access_token', 'is', null)
      .eq('brands.plan_status', 'active');

    if (fetchErr || !integrations) {
      return Response.json({ error: 'Failed to fetch integrations' }, { status: 500 });
    }

    for (const integration of integrations) {
      const { brand_id, source, shop_domain, account_id, access_token } =
        integration as unknown as {
          brand_id: string;
          source: string;
          shop_domain: string | null;
          account_id: string | null;
          access_token: string;
        };

      try {
        if (source === 'shopify' && shop_domain) {
          await syncShopifyData(brand_id, shop_domain, access_token);
          results.push({ brand_id, source, status: 'ok' });
        } else if (source === 'meta' && account_id) {
          await syncMetaAdsData(brand_id, account_id, access_token);
          results.push({ brand_id, source, status: 'ok' });
        }
      } catch (err) {
        results.push({ brand_id, source, status: 'error', error: (err as Error).message });
      }
    }

    const syncedBrandIds = [...new Set(
      results.filter(r => r.status === 'ok').map(r => r.brand_id)
    )];

    for (const brandId of syncedBrandIds) {
      try {
        const newAlerts = await runAllAlertChecks(brandId);
        totalAlerts += newAlerts.length;
      } catch {}
    }

    return Response.json({
      synced: results.length,
      succeeded: results.filter(r => r.status === 'ok').length,
      failed: results.filter(r => r.status === 'error').length,
      alerts_created: totalAlerts,
      results,
    });
  } catch {
    return Response.json({ error: 'Internal server error' }, { status: 500 });
  }
}
