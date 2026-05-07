import { NextRequest, NextResponse } from 'next/server';
import { z } from 'zod';
import { exchangeShopifyCode, syncShopifyData } from '@/lib/integrations/shopify';
import { createClient } from '@/lib/supabase/server';
import { createServiceClient } from '@/lib/supabase/service';

const querySchema = z.object({
  shop: z.string().min(1),
  code: z.string().min(1),
});

export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url);
    const parsed = querySchema.safeParse({
      shop: searchParams.get('shop'),
      code: searchParams.get('code'),
    });
    if (!parsed.success) {
      return NextResponse.redirect(new URL('/sources?error=shopify_invalid_callback', request.url));
    }
    const { shop, code } = parsed.data;

    const supabase = createClient();
    const { data: { user } } = await supabase.auth.getUser();
    if (!user) return NextResponse.redirect(new URL('/login', request.url));

    const service = createServiceClient();
    const { data: brand } = await service
      .from('brands')
      .select('id')
      .eq('founder_email', user.email)
      .single();
    if (!brand) return NextResponse.redirect(new URL('/sources?error=brand_not_found', request.url));

    const accessToken = await exchangeShopifyCode(shop, code);

    await service.from('integrations').upsert(
      { brand_id: brand.id, source: 'shopify', access_token: accessToken, shop_domain: shop, sync_status: 'pending' },
      { onConflict: 'brand_id,source' }
    );

    syncShopifyData(brand.id, shop, accessToken).catch(() => {});

    return NextResponse.redirect(new URL('/sources?connected=shopify', request.url));
  } catch {
    return NextResponse.redirect(new URL('/sources?error=shopify_auth_failed', request.url));
  }
}
