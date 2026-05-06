import { NextRequest, NextResponse } from 'next/server';
import { z } from 'zod';
import { exchangeShopifyCode, syncShopifyData } from '@/lib/integrations/shopify';
import { createClient } from '@/lib/supabase/server';

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
      return NextResponse.json({ error: 'Missing shop or code' }, { status: 400 });
    }
    const { shop, code } = parsed.data;

    const accessToken = await exchangeShopifyCode(shop, code);
    const supabase = createClient();

    const { data: { user } } = await supabase.auth.getUser();
    if (!user) {
      return NextResponse.redirect(new URL('/login', request.url));
    }

    const { data: brand } = await supabase
      .from('brands')
      .select('id')
      .eq('founder_email', user.email)
      .single();

    if (!brand) {
      return NextResponse.json({ error: 'Brand not found' }, { status: 404 });
    }

    await supabase
      .from('integrations')
      .upsert(
        {
          brand_id: brand.id,
          source: 'shopify',
          access_token: accessToken,
          shop_domain: shop,
          sync_status: 'pending',
        },
        { onConflict: 'brand_id,source' }
      );

    // Fire-and-forget background sync
    syncShopifyData(brand.id, shop, accessToken).catch(() => {});

    return NextResponse.redirect(
      new URL('/dashboard/sources?connected=shopify', request.url)
    );
  } catch {
    return NextResponse.redirect(
      new URL('/dashboard/sources?error=shopify_auth_failed', request.url)
    );
  }
}
