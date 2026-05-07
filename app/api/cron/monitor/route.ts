import { NextRequest } from 'next/server';
import { createServiceClient } from '@/lib/supabase/service';
import { runAllAlertChecks } from '@/lib/monitors/alert-engine';
import { sendWhatsAppMessage } from '@/lib/whatsapp';

function authorized(req: NextRequest): boolean {
  const header = req.headers.get('authorization');
  return header === `Bearer ${process.env.CRON_SECRET}`;
}

export async function GET(request: NextRequest) {
  if (!authorized(request)) {
    return Response.json({ error: 'Unauthorized' }, { status: 401 });
  }

  const supabase = createServiceClient();

  const { data: brands, error } = await supabase
    .from('brands')
    .select('id, name, founder_name, founder_phone, plan, plan_status')
    .eq('plan_status', 'active');

  if (error || !brands) {
    return Response.json({ error: 'Failed to fetch brands' }, { status: 500 });
  }

  let totalChecked = 0;
  let totalAlertsFired = 0;
  const results: Array<{ brand_id: string; alerts: number; error?: string }> = [];

  for (const brand of brands) {
    try {
      const newAlerts = await runAllAlertChecks(brand.id);
      totalAlertsFired += newAlerts.length;
      totalChecked++;

      // Send WhatsApp for each new critical or warning alert if phone configured
      if (brand.founder_phone && newAlerts.length > 0) {
        for (const alert of newAlerts) {
          const actionHint = (alert.data as Record<string, unknown>)?.action_description as string | undefined;
          const msg = [
            `⚠️ *Brain Alert — ${brand.name}*`,
            alert.message,
            actionHint ? `\n${actionHint}` : '',
          ].filter(Boolean).join('\n');

          await sendWhatsAppMessage(brand.founder_phone, msg).catch(() => {/* silent */});
        }
      }

      results.push({ brand_id: brand.id, alerts: newAlerts.length });
    } catch (err) {
      results.push({ brand_id: brand.id, alerts: 0, error: (err as Error).message });
    }
  }

  return Response.json({
    checked: totalChecked,
    alerts_fired: totalAlertsFired,
    timestamp: new Date().toISOString(),
    results,
  });
}
