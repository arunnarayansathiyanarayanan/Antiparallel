import { NextRequest, NextResponse } from 'next/server';
import { z } from 'zod';
import { getShopifyOAuthUrl } from '@/lib/integrations/shopify';

const querySchema = z.object({ shop: z.string().min(3) });

export async function GET(request: NextRequest) {
  const { searchParams } = new URL(request.url);
  const parsed = querySchema.safeParse({ shop: searchParams.get('shop') });
  if (!parsed.success) {
    return Response.json({ error: 'Missing shop domain' }, { status: 400 });
  }
  const shop = parsed.data.shop.includes('.')
    ? parsed.data.shop
    : `${parsed.data.shop}.myshopify.com`;

  return NextResponse.redirect(getShopifyOAuthUrl(shop));
}
