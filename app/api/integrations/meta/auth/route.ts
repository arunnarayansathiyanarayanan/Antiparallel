import { NextRequest, NextResponse } from 'next/server';
import { z } from 'zod';
import { exchangeMetaCode, syncMetaAdsData } from '@/lib/integrations/meta';
import { createClient } from '@/lib/supabase/server';

const querySchema = z.object({
  code: z.string().min(1),
  error: z.string().optional(),
});

export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url);
    const parsed = querySchema.safeParse({
      code: searchParams.get('code'),
      error: searchParams.get('error') ?? undefined,
    });
    if (!parsed.success || parsed.data.error || !parsed.data.code) {
      return NextResponse.redirect(
        new URL('/dashboard/sources?error=meta_auth_denied', request.url)
      );
    }
    const { code } = parsed.data;

    const accessToken = await exchangeMetaCode(code);
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

    // Fetch ad accounts for this user to get the account ID
    const adAccountsRes = await fetch(
      `https://graph.facebook.com/v19.0/me/adaccounts?fields=id,name&access_token=${accessToken}`
    );
    const adAccountsData = await adAccountsRes.json() as {
      data?: Array<{ id: string; name: string }>;
    };
    const adAccountId = adAccountsData.data?.[0]?.id?.replace('act_', '') ?? '';

    await supabase
      .from('integrations')
      .upsert(
        {
          brand_id: brand.id,
          source: 'meta',
          access_token: accessToken,
          account_id: adAccountId,
          sync_status: 'pending',
        },
        { onConflict: 'brand_id,source' }
      );

    if (adAccountId) {
      syncMetaAdsData(brand.id, adAccountId, accessToken).catch(() => {});
    }

    return NextResponse.redirect(
      new URL('/dashboard/sources?connected=meta', request.url)
    );
  } catch {
    return NextResponse.redirect(
      new URL('/dashboard/sources?error=meta_auth_failed', request.url)
    );
  }
}
