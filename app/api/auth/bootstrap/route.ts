import { z } from 'zod';
import { createClient } from '@/lib/supabase/server';
import { createServiceClient } from '@/lib/supabase/service';

const bodySchema = z.object({}).passthrough();

export async function POST(request: Request) {
  try {
    const json = await request.json().catch(() => ({}));
    const parsed = bodySchema.safeParse(json);
    if (!parsed.success) {
      return Response.json({ error: 'Invalid request body' }, { status: 400 });
    }

    // Accept token from Authorization header (set immediately after signUp)
    // or fall back to session cookie (set on subsequent requests)
    const authHeader = request.headers.get('authorization');
    const bearerToken = authHeader?.startsWith('Bearer ') ? authHeader.slice(7) : null;

    const supabase = createClient();
    const service = createServiceClient();

    let userEmail: string | null = null;
    if (bearerToken) {
      const { data: { user } } = await service.auth.getUser(bearerToken);
      userEmail = user?.email ?? null;
    } else {
      const { data: { user } } = await supabase.auth.getUser();
      userEmail = user?.email ?? null;
    }

    if (!userEmail) {
      return Response.json({ error: 'Unauthorized' }, { status: 401 });
    }

    const { data: brand } = await service
      .from('brands')
      .select('id')
      .eq('founder_email', userEmail)
      .single();

    if (!brand) {
      await service.from('brands').insert({
        name: 'My Brand',
        founder_email: userEmail,
        founder_name: null,
        founder_phone: null,
        plan: 'trial',
      });
    }

    return Response.json({ ok: true });
  } catch {
    return Response.json({ error: 'Internal server error' }, { status: 500 });
  }
}
