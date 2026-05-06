import { NextRequest } from 'next/server';
import { z } from 'zod';
import { createServiceClient } from '@/lib/supabase/service';
import { syncMetaAdsData } from '@/lib/integrations/meta';

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
      .select('account_id, access_token')
      .eq('brand_id', brandId)
      .eq('source', 'meta')
      .not('access_token', 'is', null)
      .single();

    if (!integration?.account_id || !integration?.access_token) {
      return Response.json({ error: 'Meta Ads not connected' }, { status: 404 });
    }

    await syncMetaAdsData(brandId, integration.account_id, integration.access_token);
    return Response.json({ ok: true });
  } catch (err) {
    return Response.json({ error: (err as Error).message }, { status: 500 });
  }
}
