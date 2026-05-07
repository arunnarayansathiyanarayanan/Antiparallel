import { NextResponse } from 'next/server';
import { getMetaOAuthUrl } from '@/lib/integrations/meta';

export async function GET() {
  return NextResponse.redirect(getMetaOAuthUrl());
}
