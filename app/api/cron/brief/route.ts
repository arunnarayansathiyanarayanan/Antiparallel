import { NextRequest } from 'next/server';
import { z } from 'zod';
import { createServiceClient } from '@/lib/supabase/service';
import { generateMorningBrief } from '@/lib/ai/brief-generator';
import { sendWhatsAppMessage } from '@/lib/whatsapp';

const authHeaderSchema = z.string().min(1);

function authorized(req: NextRequest): boolean {
  const parsed = authHeaderSchema.safeParse(req.headers.get('authorization'));
  if (!parsed.success) return false;
  return parsed.data === `Bearer ${process.env.CRON_SECRET}`;
}

interface BriefResult {
  brand_id: string;
  founder_name: string | null;
  status: 'sent' | 'error';
  error?: string;
}

export async function GET(request: NextRequest) {
  try {
    if (!authorized(request)) {
      return Response.json({ error: 'Unauthorized' }, { status: 401 });
    }

    const supabase = createServiceClient();

    const { data: brands, error } = await supabase
      .from('brands')
      .select('id, name, founder_name, founder_phone, plan')
      .eq('plan_status', 'active')
      .not('founder_phone', 'is', null)
      .in('plan', ['growth', 'scale']);

    if (error || !brands) {
      return Response.json({ error: 'Failed to fetch brands' }, { status: 500 });
    }

    const results: BriefResult[] = [];

    for (const brand of brands) {
      try {
        const brief = await generateMorningBrief(brand.id);
        await sendWhatsAppMessage(brand.founder_phone!, brief);

        await supabase
          .from('alerts')
          .update({ notified_whatsapp: true })
          .eq('brand_id', brand.id)
          .is('resolved_at', null)
          .eq('notified_whatsapp', false);

        results.push({ brand_id: brand.id, founder_name: brand.founder_name, status: 'sent' });
      } catch (err) {
        const message = (err as Error).message;
        await supabase.from('alerts').insert({
          brand_id: brand.id,
          alert_type: 'brief_failed',
          severity: 'info',
          message: `Morning brief failed to send: ${message}`,
          data: { error: message },
        });
        results.push({
          brand_id: brand.id,
          founder_name: brand.founder_name,
          status: 'error',
          error: message,
        });
      }
    }

    return Response.json({
      sent: results.filter(r => r.status === 'sent').length,
      failed: results.filter(r => r.status === 'error').length,
      results,
    });
  } catch {
    return Response.json({ error: 'Internal server error' }, { status: 500 });
  }
}
