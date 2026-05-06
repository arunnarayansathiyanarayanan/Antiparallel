import { NextRequest } from 'next/server';
import { z } from 'zod';
import { createServiceClient } from '@/lib/supabase/service';
import { syncShopifyData } from '@/lib/integrations/shopify';

const bodySchema = z.object({ brandId: z.string().uuid() });

export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    const parsed = bodySchema.safeParse(body);
    if (!parsed.success) {
      return Response.json({ error: 'Invalid request body' }, { status: 400 });
    }
    const { brandId } = parsed.data;

    const supabase = createServiceClient();
    const { data: integration } = await supabase
      .from('integrations')
      .select('shop_domain, access_token')
      .eq('brand_id', brandId)
      .eq('source', 'shopify')
      .not('access_token', 'is', null)
      .single();

    if (!integration?.shop_domain || !integration?.access_token) {
      return Response.json({ error: 'Shopify not connected' }, { status: 404 });
    }

    await syncShopifyData(brandId, integration.shop_domain, integration.access_token);
    return Response.json({ ok: true });
  } catch (err) {
    return Response.json({ error: (err as Error).message }, { status: 500 });
  }
}
