import { NextRequest } from 'next/server';
import { createServiceClient } from '@/lib/supabase/service';
import { createClient } from '@/lib/supabase/server';

export async function GET(_request: NextRequest) {
  try {
    const supabase = createClient();
    const { data: { user } } = await supabase.auth.getUser();
    if (!user?.email) {
      return Response.json({ error: 'Unauthorized' }, { status: 401 });
    }

    const service = createServiceClient();
    const { data: brand } = await service
      .from('brands')
      .select('id, name')
      .eq('founder_email', user.email)
      .single();

    if (!brand) return Response.json({ error: 'Brand not found' }, { status: 404 });

    const { data: integrations } = await service
      .from('integrations')
      .select('source, sync_status, last_synced_at, error_message, shop_domain, account_id')
      .eq('brand_id', brand.id);

    return Response.json({ brandId: brand.id, brandName: brand.name, integrations: integrations ?? [] });
  } catch {
    return Response.json({ error: 'Internal server error' }, { status: 500 });
  }
}
