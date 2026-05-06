import { type NextRequest } from 'next/server';
import { NextResponse } from 'next/server';
import { createServerClient } from '@supabase/ssr';
import { updateSession } from '@/lib/supabase/middleware';

export async function middleware(request: NextRequest) {
  const sessionResponse = await updateSession(request);

  const protectedPaths = ['/chat', '/sources', '/alerts', '/settings'];
  const pathname = request.nextUrl.pathname;
  const isProtected = protectedPaths.some(
    p => pathname === p || pathname.startsWith(`${p}/`)
  );

  if (!isProtected) {
    return sessionResponse;
  }

  const supabase = createServerClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!,
    {
      cookies: {
        getAll() {
          return request.cookies.getAll();
        },
        setAll() {},
      },
    }
  );

  const { data: { user } } = await supabase.auth.getUser();
  if (user) {
    return sessionResponse;
  }

  const loginUrl = new URL('/login', request.url);
  loginUrl.searchParams.set('next', pathname);
  return NextResponse.redirect(loginUrl);
}

export const config = {
  matcher: [
    '/((?!_next/static|_next/image|favicon.ico|.*\\.(?:svg|png|jpg|jpeg|gif|webp)$).*)',
  ],
};
