import { NextRequest, NextResponse } from 'next/server';
import { createClient } from '@/lib/supabase/server';
import { createServiceClient } from '@/lib/supabase/service';
import { exchangeFlipkartCode, syncFlipkartOrders } from '@/lib/integrations/flipkart';

export async function GET(request: NextRequest) {
  const params = request.nextUrl.searchParams;
  const code  = params.get('code');
  const error = params.get('error');

  if (error || !code) {
    return NextResponse.redirect(`${process.env.NEXT_PUBLIC_APP_URL}/sources?error=flipkart_denied`);
  }

  try {
    const supabase = createClient();
    const serviceClient = createServiceClient();

    const { data: { user } } = await supabase.auth.getUser();
    if (!user) return NextResponse.redirect(`${process.env.NEXT_PUBLIC_APP_URL}/login`);

    const { data: brand } = await serviceClient
      .from('brands')
      .select('id')
      .eq('founder_email', user.email)
      .single();

    if (!brand) {
      return NextResponse.redirect(`${process.env.NEXT_PUBLIC_APP_URL}/onboarding/brand`);
    }

    const { accessToken, refreshToken } = await exchangeFlipkartCode(code);

    await serviceClient
      .from('integrations')
      .upsert({
        brand_id: brand.id,
        source: 'flipkart',
        access_token: accessToken,
        refresh_token: refreshToken,
        sync_status: 'pending',
      }, { onConflict: 'brand_id,source' });

    // Fire initial sync in background
    syncFlipkartOrders(brand.id, accessToken).catch(err =>
      console.error('[flipkart-sync] initial sync failed:', (err as Error).message)
    );

    return NextResponse.redirect(`${process.env.NEXT_PUBLIC_APP_URL}/sources?connected=flipkart`);
  } catch (err) {
    console.error('[flipkart-auth]', err);
    return NextResponse.redirect(`${process.env.NEXT_PUBLIC_APP_URL}/sources?error=flipkart_failed`);
  }
}
