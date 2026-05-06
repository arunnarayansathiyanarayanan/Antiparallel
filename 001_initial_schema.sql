-- 001_initial_schema.sql
-- Run this in Supabase SQL editor: app.supabase.com → SQL editor

-- Enable pgvector for future embedding search
create extension if not exists vector;

-- ============================================================
-- BRANDS
-- ============================================================
create table public.brands (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  founder_name text,
  founder_phone text,
  founder_email text,
  plan text not null default 'trial'
    check (plan in ('trial', 'starter', 'growth', 'scale')),
  plan_status text not null default 'active'
    check (plan_status in ('active', 'paused', 'cancelled')),
  razorpay_subscription_id text,
  mrr_inr integer default 0,
  timezone text default 'Asia/Kolkata',
  created_at timestamptz default now(),
  trial_ends_at timestamptz default now() + interval '14 days'
);

alter table public.brands enable row level security;

-- ============================================================
-- INTEGRATIONS
-- ============================================================
create table public.integrations (
  id uuid primary key default gen_random_uuid(),
  brand_id uuid not null references public.brands(id) on delete cascade,
  source text not null
    check (source in ('shopify', 'meta', 'google', 'tally_csv', 'amazon', 'zoho')),
  access_token text,
  refresh_token text,
  shop_domain text,
  account_id text,
  last_synced_at timestamptz,
  sync_status text not null default 'pending'
    check (sync_status in ('pending', 'syncing', 'success', 'error')),
  error_message text,
  metadata jsonb default '{}',
  created_at timestamptz default now(),
  unique(brand_id, source)
);

alter table public.integrations enable row level security;

-- ============================================================
-- METRICS DAILY
-- ============================================================
create table public.metrics_daily (
  id uuid primary key default gen_random_uuid(),
  brand_id uuid not null references public.brands(id) on delete cascade,
  date date not null,
  source text not null,
  metric_key text not null,
  metric_value numeric,
  metadata jsonb default '{}',
  unique(brand_id, date, source, metric_key)
);

alter table public.metrics_daily enable row level security;

-- Index for fast metric queries
create index idx_metrics_brand_date
  on public.metrics_daily(brand_id, date desc);

create index idx_metrics_brand_source
  on public.metrics_daily(brand_id, source, date desc);

-- ============================================================
-- CONVERSATIONS
-- ============================================================
create table public.conversations (
  id uuid primary key default gen_random_uuid(),
  brand_id uuid not null references public.brands(id) on delete cascade,
  messages jsonb not null default '[]',
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

alter table public.conversations enable row level security;

-- ============================================================
-- ALERTS
-- ============================================================
create table public.alerts (
  id uuid primary key default gen_random_uuid(),
  brand_id uuid not null references public.brands(id) on delete cascade,
  alert_type text not null,
  severity text not null default 'warning'
    check (severity in ('info', 'warning', 'critical')),
  message text not null,
  data jsonb default '{}',
  triggered_at timestamptz default now(),
  resolved_at timestamptz,
  notified_whatsapp boolean default false
);

alter table public.alerts enable row level security;

create index idx_alerts_brand_unresolved
  on public.alerts(brand_id, triggered_at desc)
  where resolved_at is null;

-- ============================================================
-- BRAND CONTEXT
-- ============================================================
create table public.brand_context (
  brand_id uuid primary key references public.brands(id) on delete cascade,
  key_skus text[] default '{}',
  target_roas numeric default 3.0,
  monthly_ad_budget_inr integer,
  competitors text[] default '{}',
  primary_channels text[] default '{}',
  business_notes text,
  updated_at timestamptz default now()
);

alter table public.brand_context enable row level security;

-- ============================================================
-- HELPER FUNCTION: get brand summary for AI context
-- ============================================================
create or replace function get_brand_metrics_summary(
  p_brand_id uuid,
  p_days integer default 30
)
returns jsonb
language plpgsql
security definer
as $$
declare
  v_result jsonb;
begin
  select jsonb_build_object(
    'revenue_last_7d', coalesce(
      (select sum(metric_value)
       from metrics_daily
       where brand_id = p_brand_id
         and source = 'shopify'
         and metric_key = 'revenue'
         and date >= current_date - 7),
      0
    ),
    'revenue_prev_7d', coalesce(
      (select sum(metric_value)
       from metrics_daily
       where brand_id = p_brand_id
         and source = 'shopify'
         and metric_key = 'revenue'
         and date >= current_date - 14
         and date < current_date - 7),
      0
    ),
    'total_ad_spend_7d', coalesce(
      (select sum(metric_value)
       from metrics_daily
       where brand_id = p_brand_id
         and metric_key = 'spend'
         and date >= current_date - 7),
      0
    ),
    'blended_roas_7d', coalesce(
      (select
         sum(case when metric_key = 'revenue' then metric_value else 0 end) /
         nullif(sum(case when metric_key = 'spend' then metric_value else 0 end), 0)
       from metrics_daily
       where brand_id = p_brand_id
         and date >= current_date - 7
         and source in ('meta', 'google')),
      0
    ),
    'orders_last_7d', coalesce(
      (select sum(metric_value)
       from metrics_daily
       where brand_id = p_brand_id
         and source = 'shopify'
         and metric_key = 'orders'
         and date >= current_date - 7),
      0
    ),
    'rto_rate', coalesce(
      (select avg(metric_value)
       from metrics_daily
       where brand_id = p_brand_id
         and metric_key = 'rto_rate'
         and date >= current_date - 7),
      null
    )
  ) into v_result;

  return v_result;
end;
$$;

-- ============================================================
-- RLS POLICIES (basic — tighten after adding auth)
-- ============================================================

-- Brands: service role can do anything, users see their own
create policy "Service role full access on brands"
  on public.brands for all
  to service_role using (true);

create policy "Service role full access on integrations"
  on public.integrations for all
  to service_role using (true);

create policy "Service role full access on metrics_daily"
  on public.metrics_daily for all
  to service_role using (true);

create policy "Service role full access on conversations"
  on public.conversations for all
  to service_role using (true);

create policy "Service role full access on alerts"
  on public.alerts for all
  to service_role using (true);

create policy "Service role full access on brand_context"
  on public.brand_context for all
  to service_role using (true);

-- ============================================================
-- SEED: test brand for development
-- ============================================================
insert into public.brands (
  name, founder_name, founder_phone, founder_email, plan
) values (
  'Test Brand Co', 'Arun', '+919876543210', 'arun@testbrand.com', 'growth'
);
