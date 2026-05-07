import { NextRequest } from 'next/server';
import { createClient } from '@/lib/supabase/server';
import { createServiceClient } from '@/lib/supabase/service';

export async function POST(request: NextRequest) {
  try {
    const supabase = createClient();
    const { data: { user } } = await supabase.auth.getUser();
    if (!user?.email) return Response.json({ error: 'Unauthorized' }, { status: 401 });

    const service = createServiceClient();
    const { data: brand } = await service
      .from('brands')
      .select('id')
      .eq('founder_email', user.email)
      .single();
    if (!brand) return Response.json({ error: 'Brand not found' }, { status: 404 });

    const formData = await request.formData();
    const file = formData.get('file') as File | null;
    if (!file) return Response.json({ error: 'No file uploaded' }, { status: 400 });

    const text = await file.text();
    const lines = text.trim().split('\n');
    const header = lines[0].split(',').map(h => h.trim().toLowerCase());

    const dateIdx = header.indexOf('date');
    const ebitdaIdx = header.indexOf('ebitda');
    const cashIdx = header.indexOf('cash_balance');

    if (dateIdx === -1 || (ebitdaIdx === -1 && cashIdx === -1)) {
      return Response.json(
        { error: 'CSV must have columns: date, and either cash_balance or ebitda' },
        { status: 422 }
      );
    }

    type MetricRow = { brand_id: string; date: string; source: string; metric_key: string; metric_value: number; metadata: Record<string, unknown> };
    const rows: MetricRow[] = [];
    let runningCash = 0;

    for (let i = 1; i < lines.length; i++) {
      const cols = lines[i].split(',').map(c => c.trim());
      const date = cols[dateIdx];
      if (!date) continue;

      if (cashIdx !== -1) {
        const cash = parseFloat(cols[cashIdx] ?? '0');
        if (!isNaN(cash)) {
          rows.push({ brand_id: brand.id, date, source: 'tally_csv', metric_key: 'cash_position', metric_value: cash, metadata: {} });
        }
      } else {
        const ebitda = parseFloat(cols[ebitdaIdx] ?? '0');
        if (!isNaN(ebitda)) {
          runningCash += ebitda;
          rows.push({ brand_id: brand.id, date, source: 'tally_csv', metric_key: 'cash_position', metric_value: runningCash, metadata: {} });
        }
      }
    }

    if (rows.length === 0) return Response.json({ error: 'No valid rows found in CSV' }, { status: 422 });

    await service.from('integrations').upsert(
      { brand_id: brand.id, source: 'tally_csv', sync_status: 'success', last_synced_at: new Date().toISOString() },
      { onConflict: 'brand_id,source' }
    );

    const BATCH = 500;
    for (let i = 0; i < rows.length; i += BATCH) {
      await service.from('metrics_daily').upsert(rows.slice(i, i + BATCH), { onConflict: 'brand_id,date,source,metric_key' });
    }

    return Response.json({ ok: true, rows: rows.length });
  } catch {
    return Response.json({ error: 'Internal server error' }, { status: 500 });
  }
}
