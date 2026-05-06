'use server';

import { redirect } from 'next/navigation';
import { createClient } from '@/lib/supabase/server';
import { createServiceClient } from '@/lib/supabase/service';

export interface BrandProfileInput {
  name: string;
  founderName: string;
  founderPhone: string;
  keySkus: string;       // comma-separated
  targetRoas: number;
  monthlyAdBudget: number | null;
}

export async function saveBrandProfile(input: BrandProfileInput) {
  const supabase = createClient();
  const serviceClient = createServiceClient();

  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect('/login');

  const skus = input.keySkus
    .split(',')
    .map(s => s.trim())
    .filter(Boolean);

  // Upsert brand
  const { data: existing } = await serviceClient
    .from('brands')
    .select('id')
    .eq('founder_email', user.email)
    .single();

  if (existing) {
    await serviceClient
      .from('brands')
      .update({
        name: input.name,
        founder_name: input.founderName,
        founder_phone: input.founderPhone || null,
      })
      .eq('id', existing.id);

    await serviceClient
      .from('brand_context')
      .upsert({
        brand_id: existing.id,
        key_skus: skus,
        target_roas: input.targetRoas,
        monthly_ad_budget_inr: input.monthlyAdBudget,
        updated_at: new Date().toISOString(),
      }, { onConflict: 'brand_id' });
  } else {
    const { data: newBrand } = await serviceClient
      .from('brands')
      .insert({
        name: input.name,
        founder_name: input.founderName,
        founder_phone: input.founderPhone || null,
        founder_email: user.email,
        plan: 'trial',
      })
      .select('id')
      .single();

    if (newBrand) {
      await serviceClient
        .from('brand_context')
        .insert({
          brand_id: newBrand.id,
          key_skus: skus,
          target_roas: input.targetRoas,
          monthly_ad_budget_inr: input.monthlyAdBudget,
        });
    }
  }

  redirect('/onboarding/connect');
}

export interface TallyCsvRow {
  date: string;
  cashBalance: number;
}

export async function saveTallyCsvData(rows: TallyCsvRow[]) {
  const supabase = createClient();
  const serviceClient = createServiceClient();

  const { data: { user } } = await supabase.auth.getUser();
  if (!user) return { error: 'Not authenticated' };

  const { data: brand } = await serviceClient
    .from('brands')
    .select('id')
    .eq('founder_email', user.email)
    .single();

  if (!brand) return { error: 'Brand not found' };

  const metricRows = rows.map(r => ({
    brand_id: brand.id,
    date: r.date,
    source: 'tally_csv',
    metric_key: 'cash_position',
    metric_value: r.cashBalance,
    metadata: {},
  }));

  await serviceClient
    .from('metrics_daily')
    .upsert(metricRows, { onConflict: 'brand_id,date,source,metric_key' });

  return { success: true };
}
