-- 002_brand_insights.sql
-- Run in Supabase SQL editor after 001_initial_schema.sql

-- ============================================================
-- BRAND INSIGHTS (persistent AI memory per brand)
-- ============================================================
create table public.brand_insights (
  id uuid primary key default gen_random_uuid(),
  brand_id uuid not null references public.brands(id) on delete cascade,
  insight_type text not null
    check (insight_type in ('learning', 'decision', 'pattern', 'preference')),
  content text not null,
  source text
    check (source in ('founder_decision', 'ai_observation', 'chat_conversation')),
  created_at timestamptz default now()
);

alter table public.brand_insights enable row level security;

create policy "Service role full access on brand_insights"
  on public.brand_insights for all
  to service_role using (true);

create index idx_brand_insights_brand
  on public.brand_insights(brand_id, created_at desc);

-- ============================================================
-- Update integrations source check to include new sources
-- ============================================================
alter table public.integrations
  drop constraint if exists integrations_source_check;

alter table public.integrations
  add constraint integrations_source_check
  check (source in (
    'shopify', 'meta', 'google', 'tally_csv', 'amazon', 'zoho',
    'flipkart', 'shiprocket', 'meesho'
  ));
