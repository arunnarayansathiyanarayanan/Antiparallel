-- Auto-generated sample seed SQL for Brain MVP
begin;
insert into brands (id, name, founder_name, founder_phone, founder_email, plan, plan_status, mrr_inr)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', 'WellNest India', 'Arun Sharma', '+919876543210', 'arun@wellnestindia.com', 'growth', 'active', 9999)
on conflict (id) do update set
  name = excluded.name,
  founder_name = excluded.founder_name,
  founder_phone = excluded.founder_phone,
  founder_email = excluded.founder_email,
  plan = excluded.plan,
  plan_status = excluded.plan_status,
  mrr_inr = excluded.mrr_inr;
insert into brand_context (brand_id, key_skus, target_roas, monthly_ad_budget_inr, competitors, primary_channels, business_notes)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '{"Collagen Gummies 30pc","Vitamin C Serum 30ml","Ashwagandha 60pc"}', 3.5, 320000, '{"HealthKart","MuscleBlaze","Oziva"}', '{"shopify","meta","google"}', 'Strong Diwali and Valentine''s seasonality. COD is 48% of orders. Main RTO problem in tier-2 cities.')
on conflict (brand_id) do update set
  key_skus = excluded.key_skus,
  target_roas = excluded.target_roas,
  monthly_ad_budget_inr = excluded.monthly_ad_budget_inr,
  competitors = excluded.competitors,
  primary_channels = excluded.primary_channels,
  business_notes = excluded.business_notes;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-06', 'shopify', 'revenue', 32703)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-06', 'shopify', 'net_revenue', 25863)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-06', 'shopify', 'orders', 39)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-06', 'shopify', 'rto_rate', 12.82)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-06', 'shopify', 'cod_rate', 53.85)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-06', 'shopify', 'aov', 838.54)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-07', 'shopify', 'revenue', 30501)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-07', 'shopify', 'net_revenue', 24615.55)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-07', 'shopify', 'orders', 37)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-07', 'shopify', 'rto_rate', 16.22)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-07', 'shopify', 'cod_rate', 40.54)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-07', 'shopify', 'aov', 824.35)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-08', 'shopify', 'revenue', 37494)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-08', 'shopify', 'net_revenue', 35261.95)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-08', 'shopify', 'orders', 39)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-08', 'shopify', 'rto_rate', 5.13)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-08', 'shopify', 'cod_rate', 56.41)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-08', 'shopify', 'aov', 961.38)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-09', 'shopify', 'revenue', 29907)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-09', 'shopify', 'net_revenue', 26546.7)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-09', 'shopify', 'orders', 35)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-09', 'shopify', 'rto_rate', 8.57)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-09', 'shopify', 'cod_rate', 57.14)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-09', 'shopify', 'aov', 854.49)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-10', 'shopify', 'revenue', 59464)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-10', 'shopify', 'net_revenue', 54481.35)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-10', 'shopify', 'orders', 60)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-10', 'shopify', 'rto_rate', 5)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-10', 'shopify', 'cod_rate', 53.33)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-10', 'shopify', 'aov', 991.07)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-11', 'shopify', 'revenue', 42037)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-11', 'shopify', 'net_revenue', 39068.95)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-11', 'shopify', 'orders', 50)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-11', 'shopify', 'rto_rate', 6)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-11', 'shopify', 'cod_rate', 54)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-11', 'shopify', 'aov', 840.74)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-12', 'shopify', 'revenue', 52973)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-12', 'shopify', 'net_revenue', 48345.6)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-12', 'shopify', 'orders', 53)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-12', 'shopify', 'rto_rate', 5.66)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-12', 'shopify', 'cod_rate', 41.51)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-12', 'shopify', 'aov', 999.49)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-13', 'shopify', 'revenue', 57268)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-13', 'shopify', 'net_revenue', 53928.05)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-13', 'shopify', 'orders', 61)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-13', 'shopify', 'rto_rate', 4.92)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-13', 'shopify', 'cod_rate', 54.1)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-13', 'shopify', 'aov', 938.82)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-14', 'shopify', 'revenue', 47431)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-14', 'shopify', 'net_revenue', 42179.4)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-14', 'shopify', 'orders', 49)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-14', 'shopify', 'rto_rate', 10.2)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-14', 'shopify', 'cod_rate', 42.86)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-14', 'shopify', 'aov', 967.98)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-15', 'shopify', 'revenue', 39292)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-15', 'shopify', 'net_revenue', 35537.95)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-15', 'shopify', 'orders', 42)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-15', 'shopify', 'rto_rate', 7.14)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-15', 'shopify', 'cod_rate', 33.33)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-15', 'shopify', 'aov', 935.52)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-16', 'shopify', 'revenue', 29405)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-16', 'shopify', 'net_revenue', 25786.7)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-16', 'shopify', 'orders', 32)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-16', 'shopify', 'rto_rate', 12.5)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-16', 'shopify', 'cod_rate', 53.12)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-16', 'shopify', 'aov', 918.91)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-17', 'shopify', 'revenue', 33354)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-17', 'shopify', 'net_revenue', 30443.45)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-17', 'shopify', 'orders', 34)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-17', 'shopify', 'rto_rate', 8.82)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-17', 'shopify', 'cod_rate', 32.35)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-17', 'shopify', 'aov', 981)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-18', 'shopify', 'revenue', 29007)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-18', 'shopify', 'net_revenue', 25836.85)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-18', 'shopify', 'orders', 31)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-18', 'shopify', 'rto_rate', 12.9)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-18', 'shopify', 'cod_rate', 41.94)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-18', 'shopify', 'aov', 935.71)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-19', 'shopify', 'revenue', 28057)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-19', 'shopify', 'net_revenue', 22115.55)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-19', 'shopify', 'orders', 32)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-19', 'shopify', 'rto_rate', 12.5)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-19', 'shopify', 'cod_rate', 56.25)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-19', 'shopify', 'aov', 876.78)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-20', 'shopify', 'revenue', 31106)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-20', 'shopify', 'net_revenue', 28344.95)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-20', 'shopify', 'orders', 38)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-20', 'shopify', 'rto_rate', 7.89)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-20', 'shopify', 'cod_rate', 60.53)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-20', 'shopify', 'aov', 818.58)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-21', 'shopify', 'revenue', 37297)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-21', 'shopify', 'net_revenue', 33242.8)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-21', 'shopify', 'orders', 38)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-21', 'shopify', 'rto_rate', 5.26)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-21', 'shopify', 'cod_rate', 44.74)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-21', 'shopify', 'aov', 981.5)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-22', 'shopify', 'revenue', 34848)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-22', 'shopify', 'net_revenue', 32247.3)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-22', 'shopify', 'orders', 41)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-22', 'shopify', 'rto_rate', 7.32)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-22', 'shopify', 'cod_rate', 46.34)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-22', 'shopify', 'aov', 849.95)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-23', 'shopify', 'revenue', 31556)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-23', 'shopify', 'net_revenue', 28815.1)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-23', 'shopify', 'orders', 30)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-23', 'shopify', 'rto_rate', 10)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-23', 'shopify', 'cod_rate', 43.33)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-23', 'shopify', 'aov', 1051.87)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-24', 'shopify', 'revenue', 34200)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-24', 'shopify', 'net_revenue', 33256.45)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-24', 'shopify', 'orders', 37)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-24', 'shopify', 'rto_rate', 2.7)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-24', 'shopify', 'cod_rate', 59.46)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-24', 'shopify', 'aov', 924.32)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-25', 'shopify', 'revenue', 37347)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-25', 'shopify', 'net_revenue', 31920.1)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-25', 'shopify', 'orders', 34)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-25', 'shopify', 'rto_rate', 11.76)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-25', 'shopify', 'cod_rate', 52.94)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-25', 'shopify', 'aov', 1098.44)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-26', 'shopify', 'revenue', 37945)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-26', 'shopify', 'net_revenue', 31444.45)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-26', 'shopify', 'orders', 39)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-26', 'shopify', 'rto_rate', 12.82)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-26', 'shopify', 'cod_rate', 46.15)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-26', 'shopify', 'aov', 972.95)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-27', 'shopify', 'revenue', 39841)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-27', 'shopify', 'net_revenue', 35026.1)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-27', 'shopify', 'orders', 39)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-27', 'shopify', 'rto_rate', 10.26)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-27', 'shopify', 'cod_rate', 48.72)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-27', 'shopify', 'aov', 1021.56)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-28', 'shopify', 'revenue', 32851)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-28', 'shopify', 'net_revenue', 28741.95)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-28', 'shopify', 'orders', 36)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-28', 'shopify', 'rto_rate', 11.11)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-28', 'shopify', 'cod_rate', 47.22)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-28', 'shopify', 'aov', 912.53)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-01', 'shopify', 'revenue', 33849)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-01', 'shopify', 'net_revenue', 28847.05)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-01', 'shopify', 'orders', 42)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-01', 'shopify', 'rto_rate', 14.29)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-01', 'shopify', 'cod_rate', 40.48)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-01', 'shopify', 'aov', 805.93)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-02', 'shopify', 'revenue', 27512)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-02', 'shopify', 'net_revenue', 24561.05)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-02', 'shopify', 'orders', 26)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-02', 'shopify', 'rto_rate', 11.54)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-02', 'shopify', 'cod_rate', 50)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-02', 'shopify', 'aov', 1058.15)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-03', 'shopify', 'revenue', 31503)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-03', 'shopify', 'net_revenue', 26449.85)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-03', 'shopify', 'orders', 37)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-03', 'shopify', 'rto_rate', 10.81)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-03', 'shopify', 'cod_rate', 43.24)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-03', 'shopify', 'aov', 851.43)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-04', 'shopify', 'revenue', 20371)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-04', 'shopify', 'net_revenue', 18343.9)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-04', 'shopify', 'orders', 23)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-04', 'shopify', 'rto_rate', 8.7)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-04', 'shopify', 'cod_rate', 43.48)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-04', 'shopify', 'aov', 885.7)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-05', 'shopify', 'revenue', 30560)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-05', 'shopify', 'net_revenue', 27733.4)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-05', 'shopify', 'orders', 33)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-05', 'shopify', 'rto_rate', 3.03)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-05', 'shopify', 'cod_rate', 48.48)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-05', 'shopify', 'aov', 926.06)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-06', 'shopify', 'revenue', 45186)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-06', 'shopify', 'net_revenue', 39734.95)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-06', 'shopify', 'orders', 42)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-06', 'shopify', 'rto_rate', 11.9)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-06', 'shopify', 'cod_rate', 45.24)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-06', 'shopify', 'aov', 1075.86)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-07', 'shopify', 'revenue', 39292)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-07', 'shopify', 'net_revenue', 36111.8)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-07', 'shopify', 'orders', 40)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-07', 'shopify', 'rto_rate', 7.5)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-07', 'shopify', 'cod_rate', 52.5)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-07', 'shopify', 'aov', 982.3)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-08', 'shopify', 'revenue', 39891)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-08', 'shopify', 'net_revenue', 36645.75)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-08', 'shopify', 'orders', 40)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-08', 'shopify', 'rto_rate', 5)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-08', 'shopify', 'cod_rate', 42.5)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-08', 'shopify', 'aov', 997.27)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-09', 'shopify', 'revenue', 29709)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-09', 'shopify', 'net_revenue', 23913.8)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-09', 'shopify', 'orders', 27)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-09', 'shopify', 'rto_rate', 14.81)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-09', 'shopify', 'cod_rate', 33.33)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-09', 'shopify', 'aov', 1100.33)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-10', 'shopify', 'revenue', 33748)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-10', 'shopify', 'net_revenue', 29630.65)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-10', 'shopify', 'orders', 34)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-10', 'shopify', 'rto_rate', 11.76)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-10', 'shopify', 'cod_rate', 67.65)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-10', 'shopify', 'aov', 992.59)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-11', 'shopify', 'revenue', 37898)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-11', 'shopify', 'net_revenue', 35680.55)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-11', 'shopify', 'orders', 37)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-11', 'shopify', 'rto_rate', 5.41)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-11', 'shopify', 'cod_rate', 45.95)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-11', 'shopify', 'aov', 1024.27)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-12', 'shopify', 'revenue', 29707)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-12', 'shopify', 'net_revenue', 28134.45)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-12', 'shopify', 'orders', 29)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-12', 'shopify', 'rto_rate', 6.9)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-12', 'shopify', 'cod_rate', 51.72)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-12', 'shopify', 'aov', 1024.38)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-13', 'shopify', 'revenue', 38142)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-13', 'shopify', 'net_revenue', 34103.6)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-13', 'shopify', 'orders', 39)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-13', 'shopify', 'rto_rate', 10.26)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-13', 'shopify', 'cod_rate', 53.85)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-13', 'shopify', 'aov', 978)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-14', 'shopify', 'revenue', 43636)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-14', 'shopify', 'net_revenue', 34729.45)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-14', 'shopify', 'orders', 46)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-14', 'shopify', 'rto_rate', 13.04)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-14', 'shopify', 'cod_rate', 34.78)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-14', 'shopify', 'aov', 948.61)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-15', 'shopify', 'revenue', 37144)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-15', 'shopify', 'net_revenue', 30341.9)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-15', 'shopify', 'orders', 40)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-15', 'shopify', 'rto_rate', 17.5)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-15', 'shopify', 'cod_rate', 50)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-15', 'shopify', 'aov', 928.6)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-16', 'shopify', 'revenue', 37599)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-16', 'shopify', 'net_revenue', 31736.15)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-16', 'shopify', 'orders', 37)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-16', 'shopify', 'rto_rate', 13.51)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-16', 'shopify', 'cod_rate', 43.24)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-16', 'shopify', 'aov', 1016.19)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-17', 'shopify', 'revenue', 41439)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-17', 'shopify', 'net_revenue', 37620.5)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-17', 'shopify', 'orders', 41)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-17', 'shopify', 'rto_rate', 9.76)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-17', 'shopify', 'cod_rate', 51.22)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-17', 'shopify', 'aov', 1010.71)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-18', 'shopify', 'revenue', 31553)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-18', 'shopify', 'net_revenue', 28797.1)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-18', 'shopify', 'orders', 32)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-18', 'shopify', 'rto_rate', 9.38)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-18', 'shopify', 'cod_rate', 46.88)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-18', 'shopify', 'aov', 986.03)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-19', 'shopify', 'revenue', 39690)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-19', 'shopify', 'net_revenue', 36120.75)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-19', 'shopify', 'orders', 44)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-19', 'shopify', 'rto_rate', 4.55)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-19', 'shopify', 'cod_rate', 50)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-19', 'shopify', 'aov', 902.05)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-20', 'shopify', 'revenue', 30307)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-20', 'shopify', 'net_revenue', 27063.85)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-20', 'shopify', 'orders', 35)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-20', 'shopify', 'rto_rate', 8.57)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-20', 'shopify', 'cod_rate', 51.43)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-20', 'shopify', 'aov', 865.91)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-21', 'shopify', 'revenue', 36296)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-21', 'shopify', 'net_revenue', 32736.1)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-21', 'shopify', 'orders', 39)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-21', 'shopify', 'rto_rate', 7.69)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-21', 'shopify', 'cod_rate', 58.97)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-21', 'shopify', 'aov', 930.67)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-22', 'shopify', 'revenue', 35647)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-22', 'shopify', 'net_revenue', 32873.65)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-22', 'shopify', 'orders', 36)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-22', 'shopify', 'rto_rate', 5.56)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-22', 'shopify', 'cod_rate', 41.67)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-22', 'shopify', 'aov', 990.19)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-23', 'shopify', 'revenue', 27809)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-23', 'shopify', 'net_revenue', 22482)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-23', 'shopify', 'orders', 28)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-23', 'shopify', 'rto_rate', 14.29)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-23', 'shopify', 'cod_rate', 39.29)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-23', 'shopify', 'aov', 993.18)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-24', 'shopify', 'revenue', 33302)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-24', 'shopify', 'net_revenue', 26122.15)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-24', 'shopify', 'orders', 34)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-24', 'shopify', 'rto_rate', 20.59)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-24', 'shopify', 'cod_rate', 58.82)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-24', 'shopify', 'aov', 979.47)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-25', 'shopify', 'revenue', 30307)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-25', 'shopify', 'net_revenue', 28215.3)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-25', 'shopify', 'orders', 31)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-25', 'shopify', 'rto_rate', 6.45)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-25', 'shopify', 'cod_rate', 48.39)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-25', 'shopify', 'aov', 977.65)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-26', 'shopify', 'revenue', 32654)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-26', 'shopify', 'net_revenue', 30207.2)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-26', 'shopify', 'orders', 35)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-26', 'shopify', 'rto_rate', 5.71)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-26', 'shopify', 'cod_rate', 60)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-26', 'shopify', 'aov', 932.97)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-27', 'shopify', 'revenue', 31852)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-27', 'shopify', 'net_revenue', 29755.35)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-27', 'shopify', 'orders', 39)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-27', 'shopify', 'rto_rate', 5.13)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-27', 'shopify', 'cod_rate', 38.46)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-27', 'shopify', 'aov', 816.72)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-28', 'shopify', 'revenue', 30556)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-28', 'shopify', 'net_revenue', 27819.85)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-28', 'shopify', 'orders', 36)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-28', 'shopify', 'rto_rate', 8.33)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-28', 'shopify', 'cod_rate', 63.89)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-28', 'shopify', 'aov', 848.78)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-29', 'shopify', 'revenue', 39943)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-29', 'shopify', 'net_revenue', 36068.75)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-29', 'shopify', 'orders', 46)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-29', 'shopify', 'rto_rate', 8.7)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-29', 'shopify', 'cod_rate', 36.96)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-29', 'shopify', 'aov', 868.33)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-30', 'shopify', 'revenue', 29509)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-30', 'shopify', 'net_revenue', 25210.3)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-30', 'shopify', 'orders', 29)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-30', 'shopify', 'rto_rate', 13.79)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-30', 'shopify', 'cod_rate', 51.72)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-30', 'shopify', 'aov', 1017.55)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-31', 'shopify', 'revenue', 33154)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-31', 'shopify', 'net_revenue', 31037.35)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-31', 'shopify', 'orders', 39)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-31', 'shopify', 'rto_rate', 5.13)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-31', 'shopify', 'cod_rate', 58.97)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-31', 'shopify', 'aov', 850.1)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-01', 'shopify', 'revenue', 21220)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-01', 'shopify', 'net_revenue', 18234.35)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-01', 'shopify', 'orders', 25)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-01', 'shopify', 'rto_rate', 12)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-01', 'shopify', 'cod_rate', 56)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-01', 'shopify', 'aov', 848.8)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-02', 'shopify', 'revenue', 39440)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-02', 'shopify', 'net_revenue', 33951.35)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-02', 'shopify', 'orders', 44)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-02', 'shopify', 'rto_rate', 11.36)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-02', 'shopify', 'cod_rate', 52.27)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-02', 'shopify', 'aov', 896.36)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-03', 'shopify', 'revenue', 44538)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-03', 'shopify', 'net_revenue', 37257.55)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-03', 'shopify', 'orders', 48)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-03', 'shopify', 'rto_rate', 12.5)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-03', 'shopify', 'cod_rate', 43.75)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-03', 'shopify', 'aov', 927.88)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-04', 'shopify', 'revenue', 38794)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-04', 'shopify', 'net_revenue', 37338.9)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-04', 'shopify', 'orders', 39)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-04', 'shopify', 'rto_rate', 2.56)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-04', 'shopify', 'cod_rate', 35.9)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-04', 'shopify', 'aov', 994.72)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-05', 'shopify', 'revenue', 25862)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-05', 'shopify', 'net_revenue', 24608.85)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-05', 'shopify', 'orders', 32)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-05', 'shopify', 'rto_rate', 3.12)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-05', 'shopify', 'cod_rate', 43.75)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-05', 'shopify', 'aov', 808.19)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-06', 'shopify', 'revenue', 23015)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-06', 'shopify', 'net_revenue', 21397.8)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-06', 'shopify', 'orders', 27)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-06', 'shopify', 'rto_rate', 7.41)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-06', 'shopify', 'cod_rate', 59.26)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-06', 'shopify', 'aov', 852.41)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-07', 'shopify', 'revenue', 25912)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-07', 'shopify', 'net_revenue', 23887.15)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-07', 'shopify', 'orders', 31)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-07', 'shopify', 'rto_rate', 3.23)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-07', 'shopify', 'cod_rate', 51.61)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-07', 'shopify', 'aov', 835.87)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-08', 'shopify', 'revenue', 35896)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-08', 'shopify', 'net_revenue', 31836.35)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-08', 'shopify', 'orders', 39)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-08', 'shopify', 'rto_rate', 5.13)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-08', 'shopify', 'cod_rate', 56.41)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-08', 'shopify', 'aov', 920.41)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-09', 'shopify', 'revenue', 34301)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-09', 'shopify', 'net_revenue', 32873)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-09', 'shopify', 'orders', 34)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-09', 'shopify', 'rto_rate', 0)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-09', 'shopify', 'cod_rate', 52.94)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-09', 'shopify', 'aov', 1008.85)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-10', 'shopify', 'revenue', 38295)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-10', 'shopify', 'net_revenue', 34550.2)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-10', 'shopify', 'orders', 39)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-10', 'shopify', 'rto_rate', 7.69)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-10', 'shopify', 'cod_rate', 43.59)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-10', 'shopify', 'aov', 981.92)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-11', 'shopify', 'revenue', 43133)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-11', 'shopify', 'net_revenue', 39963.45)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-11', 'shopify', 'orders', 43)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-11', 'shopify', 'rto_rate', 4.65)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-11', 'shopify', 'cod_rate', 53.49)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-11', 'shopify', 'aov', 1003.09)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-12', 'shopify', 'revenue', 43086)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-12', 'shopify', 'net_revenue', 41767.8)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-12', 'shopify', 'orders', 42)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-12', 'shopify', 'rto_rate', 0)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-12', 'shopify', 'cod_rate', 54.76)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-12', 'shopify', 'aov', 1025.86)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-13', 'shopify', 'revenue', 26011)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-13', 'shopify', 'net_revenue', 20648.7)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-13', 'shopify', 'orders', 29)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-13', 'shopify', 'rto_rate', 17.24)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-13', 'shopify', 'cod_rate', 44.83)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-13', 'shopify', 'aov', 896.93)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-14', 'shopify', 'revenue', 35349)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-14', 'shopify', 'net_revenue', 31978.75)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-14', 'shopify', 'orders', 37)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-14', 'shopify', 'rto_rate', 10.81)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-14', 'shopify', 'cod_rate', 29.73)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-14', 'shopify', 'aov', 955.38)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-15', 'shopify', 'revenue', 37446)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-15', 'shopify', 'net_revenue', 32614.1)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-15', 'shopify', 'orders', 40)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-15', 'shopify', 'rto_rate', 12.5)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-15', 'shopify', 'cod_rate', 45)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-15', 'shopify', 'aov', 936.15)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-16', 'shopify', 'revenue', 34400)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-16', 'shopify', 'net_revenue', 32657.7)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-16', 'shopify', 'orders', 34)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-16', 'shopify', 'rto_rate', 5.88)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-16', 'shopify', 'cod_rate', 52.94)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-16', 'shopify', 'aov', 1011.76)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-17', 'shopify', 'revenue', 42987)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-17', 'shopify', 'net_revenue', 38942.95)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-17', 'shopify', 'orders', 40)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-17', 'shopify', 'rto_rate', 7.5)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-17', 'shopify', 'cod_rate', 45)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-17', 'shopify', 'aov', 1074.67)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-18', 'shopify', 'revenue', 43237)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-18', 'shopify', 'net_revenue', 40613.65)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-18', 'shopify', 'orders', 40)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-18', 'shopify', 'rto_rate', 7.5)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-18', 'shopify', 'cod_rate', 60)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-18', 'shopify', 'aov', 1080.92)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-19', 'shopify', 'revenue', 35146)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-19', 'shopify', 'net_revenue', 33066.25)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-19', 'shopify', 'orders', 38)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-19', 'shopify', 'rto_rate', 2.63)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-19', 'shopify', 'cod_rate', 39.47)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-19', 'shopify', 'aov', 924.89)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-20', 'shopify', 'revenue', 27559)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-20', 'shopify', 'net_revenue', 26540.15)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-20', 'shopify', 'orders', 31)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-20', 'shopify', 'rto_rate', 3.23)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-20', 'shopify', 'cod_rate', 48.39)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-20', 'shopify', 'aov', 889)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-21', 'shopify', 'revenue', 31556)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-21', 'shopify', 'net_revenue', 28130.55)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-21', 'shopify', 'orders', 30)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-21', 'shopify', 'rto_rate', 10)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-21', 'shopify', 'cod_rate', 63.33)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-21', 'shopify', 'aov', 1051.87)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-22', 'shopify', 'revenue', 30057)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-22', 'shopify', 'net_revenue', 29008.65)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-22', 'shopify', 'orders', 28)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-22', 'shopify', 'rto_rate', 3.57)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-22', 'shopify', 'cod_rate', 53.57)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-22', 'shopify', 'aov', 1073.46)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-23', 'shopify', 'revenue', 33004)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-23', 'shopify', 'net_revenue', 31445.8)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-23', 'shopify', 'orders', 33)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-23', 'shopify', 'rto_rate', 3.03)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-23', 'shopify', 'cod_rate', 42.42)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-23', 'shopify', 'aov', 1000.12)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-24', 'shopify', 'revenue', 29807)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-24', 'shopify', 'net_revenue', 26826.5)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-24', 'shopify', 'orders', 33)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-24', 'shopify', 'rto_rate', 12.12)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-24', 'shopify', 'cod_rate', 42.42)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-24', 'shopify', 'aov', 903.24)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-25', 'shopify', 'revenue', 44135)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-25', 'shopify', 'net_revenue', 41079.75)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-25', 'shopify', 'orders', 48)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-25', 'shopify', 'rto_rate', 4.17)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-25', 'shopify', 'cod_rate', 52.08)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-25', 'shopify', 'aov', 919.48)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-26', 'shopify', 'revenue', 36596)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-26', 'shopify', 'net_revenue', 30786.8)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-26', 'shopify', 'orders', 36)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-26', 'shopify', 'rto_rate', 11.11)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-26', 'shopify', 'cod_rate', 50)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-26', 'shopify', 'aov', 1016.56)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-27', 'shopify', 'revenue', 33849)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-27', 'shopify', 'net_revenue', 32690.95)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-27', 'shopify', 'orders', 34)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-27', 'shopify', 'rto_rate', 2.94)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-27', 'shopify', 'cod_rate', 52.94)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-27', 'shopify', 'aov', 995.56)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-28', 'shopify', 'revenue', 32455)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-28', 'shopify', 'net_revenue', 26632.95)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-28', 'shopify', 'orders', 34)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-28', 'shopify', 'rto_rate', 8.82)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-28', 'shopify', 'cod_rate', 50)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-28', 'shopify', 'aov', 954.56)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-29', 'shopify', 'revenue', 38696)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-29', 'shopify', 'net_revenue', 35989.55)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-29', 'shopify', 'orders', 40)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-29', 'shopify', 'rto_rate', 7.5)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-29', 'shopify', 'cod_rate', 40)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-29', 'shopify', 'aov', 967.4)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-30', 'shopify', 'revenue', 28660)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-30', 'shopify', 'net_revenue', 27182.05)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-30', 'shopify', 'orders', 31)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-30', 'shopify', 'rto_rate', 3.23)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-30', 'shopify', 'cod_rate', 35.48)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-30', 'shopify', 'aov', 924.52)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-01', 'shopify', 'revenue', 41141)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-01', 'shopify', 'net_revenue', 36947.3)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-01', 'shopify', 'orders', 46)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-01', 'shopify', 'rto_rate', 8.7)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-01', 'shopify', 'cod_rate', 54.35)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-01', 'shopify', 'aov', 894.37)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-02', 'shopify', 'revenue', 39842)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-02', 'shopify', 'net_revenue', 38419.25)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-02', 'shopify', 'orders', 40)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-02', 'shopify', 'rto_rate', 2.5)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-02', 'shopify', 'cod_rate', 42.5)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-02', 'shopify', 'aov', 996.05)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-03', 'shopify', 'revenue', 36348)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-03', 'shopify', 'net_revenue', 34408.05)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-03', 'shopify', 'orders', 37)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-03', 'shopify', 'rto_rate', 2.7)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-03', 'shopify', 'cod_rate', 54.05)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-03', 'shopify', 'aov', 982.38)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-04', 'shopify', 'revenue', 21517)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-04', 'shopify', 'net_revenue', 21032.75)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-04', 'shopify', 'orders', 23)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-04', 'shopify', 'rto_rate', 0)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-04', 'shopify', 'cod_rate', 43.48)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-04', 'shopify', 'aov', 935.52)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-05', 'shopify', 'revenue', 28158)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-05', 'shopify', 'net_revenue', 23024.4)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-05', 'shopify', 'orders', 28)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-05', 'shopify', 'rto_rate', 14.29)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-05', 'shopify', 'cod_rate', 42.86)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-05', 'shopify', 'aov', 1005.64)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-06', 'shopify', 'revenue', 27660)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-06', 'shopify', 'net_revenue', 27390.4)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-06', 'shopify', 'orders', 30)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-06', 'shopify', 'rto_rate', 0)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-06', 'shopify', 'cod_rate', 43.33)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-06', 'shopify', 'aov', 922)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-06', 'meta', 'spend', 11838.27)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-06', 'meta', 'roas', 3.12)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-06', 'meta', 'impressions', 2844145)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-07', 'meta', 'spend', 11687.53)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-07', 'meta', 'roas', 3.24)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-07', 'meta', 'impressions', 3200945)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-08', 'meta', 'spend', 10828.58)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-08', 'meta', 'roas', 3.53)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-08', 'meta', 'impressions', 3098554)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-09', 'meta', 'spend', 9188.01)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-09', 'meta', 'roas', 2.35)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-09', 'meta', 'impressions', 2664045)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-10', 'meta', 'spend', 18062.72)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-10', 'meta', 'roas', 4.68)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-10', 'meta', 'impressions', 5714531)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-11', 'meta', 'spend', 18346.11)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-11', 'meta', 'roas', 4.02)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-11', 'meta', 'impressions', 4650751)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-12', 'meta', 'spend', 17274.38)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-12', 'meta', 'roas', 4.12)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-12', 'meta', 'impressions', 4700445)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-13', 'meta', 'spend', 15649.87)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-13', 'meta', 'roas', 3.71)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-13', 'meta', 'impressions', 4148328)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-14', 'meta', 'spend', 16918.23)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-14', 'meta', 'roas', 3.68)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-14', 'meta', 'impressions', 4972522)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-15', 'meta', 'spend', 12449.19)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-15', 'meta', 'roas', 2.84)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-15', 'meta', 'impressions', 3288876)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-16', 'meta', 'spend', 9443.34)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-16', 'meta', 'roas', 1.89)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-16', 'meta', 'impressions', 2785063)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-17', 'meta', 'spend', 13097.3)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-17', 'meta', 'roas', 2.16)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-17', 'meta', 'impressions', 3541467)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-18', 'meta', 'spend', 11284.31)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-18', 'meta', 'roas', 1.89)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-18', 'meta', 'impressions', 3114823)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-19', 'meta', 'spend', 10553.98)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-19', 'meta', 'roas', 2.01)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-19', 'meta', 'impressions', 2928372)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-20', 'meta', 'spend', 11528.91)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-20', 'meta', 'roas', 3.81)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-20', 'meta', 'impressions', 3226893)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-21', 'meta', 'spend', 12516.25)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-21', 'meta', 'roas', 3.65)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-21', 'meta', 'impressions', 3316545)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-22', 'meta', 'spend', 11210.15)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-22', 'meta', 'roas', 3.5)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-22', 'meta', 'impressions', 2964187)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-23', 'meta', 'spend', 10220.89)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-23', 'meta', 'roas', 2.46)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-23', 'meta', 'impressions', 3103088)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-24', 'meta', 'spend', 10980.39)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-24', 'meta', 'roas', 2.86)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-24', 'meta', 'impressions', 3281949)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-25', 'meta', 'spend', 10303.87)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-25', 'meta', 'roas', 2.56)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-25', 'meta', 'impressions', 3054878)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-26', 'meta', 'spend', 12644.83)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-26', 'meta', 'roas', 2.49)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-26', 'meta', 'impressions', 3439180)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-27', 'meta', 'spend', 12716.21)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-27', 'meta', 'roas', 2.88)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-27', 'meta', 'impressions', 3641195)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-28', 'meta', 'spend', 12857.94)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-28', 'meta', 'roas', 2.88)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-28', 'meta', 'impressions', 3482995)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-01', 'meta', 'spend', 11393.34)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-01', 'meta', 'roas', 2.47)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-01', 'meta', 'impressions', 3423334)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-02', 'meta', 'spend', 9426.92)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-02', 'meta', 'roas', 1.89)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-02', 'meta', 'impressions', 2670764)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-03', 'meta', 'spend', 10802.08)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-03', 'meta', 'roas', 2.06)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-03', 'meta', 'impressions', 3169135)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-04', 'meta', 'spend', 9377.96)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-04', 'meta', 'roas', 1.94)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-04', 'meta', 'impressions', 2554966)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-05', 'meta', 'spend', 9770.07)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-05', 'meta', 'roas', 1.7)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-05', 'meta', 'impressions', 2755564)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-06', 'meta', 'spend', 10031.83)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-06', 'meta', 'roas', 3.7)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-06', 'meta', 'impressions', 2997276)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-07', 'meta', 'spend', 12517.3)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-07', 'meta', 'roas', 3.43)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-07', 'meta', 'impressions', 3768608)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-08', 'meta', 'spend', 11907.11)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-08', 'meta', 'roas', 3.26)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-08', 'meta', 'impressions', 3433156)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-09', 'meta', 'spend', 8823.04)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-09', 'meta', 'roas', 2.49)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-09', 'meta', 'impressions', 2380202)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-10', 'meta', 'spend', 11121.29)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-10', 'meta', 'roas', 2.56)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-10', 'meta', 'impressions', 3122384)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-11', 'meta', 'spend', 11208.8)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-11', 'meta', 'roas', 2.51)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-11', 'meta', 'impressions', 3399129)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-12', 'meta', 'spend', 9450.44)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-12', 'meta', 'roas', 2.65)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-12', 'meta', 'impressions', 2809539)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-13', 'meta', 'spend', 12959.68)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-13', 'meta', 'roas', 2.64)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-13', 'meta', 'impressions', 4026600)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-14', 'meta', 'spend', 11411.35)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-14', 'meta', 'roas', 2.67)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-14', 'meta', 'impressions', 3577729)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-15', 'meta', 'spend', 12293.51)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-15', 'meta', 'roas', 2.47)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-15', 'meta', 'impressions', 3951937)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-16', 'meta', 'spend', 9982.51)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-16', 'meta', 'roas', 1.65)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-16', 'meta', 'impressions', 2488759)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-17', 'meta', 'spend', 11312.65)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-17', 'meta', 'roas', 2.11)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-17', 'meta', 'impressions', 3092292)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-18', 'meta', 'spend', 10843.7)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-18', 'meta', 'roas', 2.1)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-18', 'meta', 'impressions', 2654236)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-19', 'meta', 'spend', 7854.06)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-19', 'meta', 'roas', 1.73)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-19', 'meta', 'impressions', 2209396)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-20', 'meta', 'spend', 12250.97)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-20', 'meta', 'roas', 3.71)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-20', 'meta', 'impressions', 3278101)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-21', 'meta', 'spend', 12200.72)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-21', 'meta', 'roas', 3.42)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-21', 'meta', 'impressions', 3345077)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-22', 'meta', 'spend', 12366.6)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-22', 'meta', 'roas', 3.5)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-22', 'meta', 'impressions', 3243365)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-23', 'meta', 'spend', 8606.63)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-23', 'meta', 'roas', 2.53)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-23', 'meta', 'impressions', 2501599)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-24', 'meta', 'spend', 11396.48)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-24', 'meta', 'roas', 2.4)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-24', 'meta', 'impressions', 3080231)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-25', 'meta', 'spend', 11384.47)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-25', 'meta', 'roas', 2.58)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-25', 'meta', 'impressions', 3141110)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-26', 'meta', 'spend', 10886.2)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-26', 'meta', 'roas', 2.57)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-26', 'meta', 'impressions', 3101589)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-27', 'meta', 'spend', 12688.48)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-27', 'meta', 'roas', 2.58)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-27', 'meta', 'impressions', 3204737)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-28', 'meta', 'spend', 12646.72)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-28', 'meta', 'roas', 2.66)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-28', 'meta', 'impressions', 3689100)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-29', 'meta', 'spend', 12259.81)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-29', 'meta', 'roas', 2.53)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-29', 'meta', 'impressions', 3343654)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-30', 'meta', 'spend', 7788.85)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-30', 'meta', 'roas', 1.93)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-30', 'meta', 'impressions', 1963952)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-31', 'meta', 'spend', 10348.29)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-31', 'meta', 'roas', 2.07)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-31', 'meta', 'impressions', 2655838)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-01', 'meta', 'spend', 10111.32)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-01', 'meta', 'roas', 1.92)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-01', 'meta', 'impressions', 2613800)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-02', 'meta', 'spend', 11074.76)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-02', 'meta', 'roas', 2.03)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-02', 'meta', 'impressions', 3148955)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-03', 'meta', 'spend', 12043.05)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-03', 'meta', 'roas', 3.47)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-03', 'meta', 'impressions', 3389522)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-04', 'meta', 'spend', 11294.98)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-04', 'meta', 'roas', 3.3)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-04', 'meta', 'impressions', 3152501)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-05', 'meta', 'spend', 12259.19)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-05', 'meta', 'roas', 3.52)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-05', 'meta', 'impressions', 3455863)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-06', 'meta', 'spend', 8472.71)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-06', 'meta', 'roas', 2.23)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-06', 'meta', 'impressions', 2583343)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-07', 'meta', 'spend', 11802.38)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-07', 'meta', 'roas', 2.53)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-07', 'meta', 'impressions', 3392099)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-08', 'meta', 'spend', 10984.09)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-08', 'meta', 'roas', 2.83)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-08', 'meta', 'impressions', 3384190)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-09', 'meta', 'spend', 11387.65)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-09', 'meta', 'roas', 2.63)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-09', 'meta', 'impressions', 3152861)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-10', 'meta', 'spend', 12717.7)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-10', 'meta', 'roas', 2.99)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-10', 'meta', 'impressions', 3762091)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-11', 'meta', 'spend', 11848.23)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-11', 'meta', 'roas', 2.67)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-11', 'meta', 'impressions', 3172237)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-12', 'meta', 'spend', 11786.76)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-12', 'meta', 'roas', 2.72)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-12', 'meta', 'impressions', 3247114)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-13', 'meta', 'spend', 8657.24)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-13', 'meta', 'roas', 2.14)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-13', 'meta', 'impressions', 2433841)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-14', 'meta', 'spend', 9590.76)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-14', 'meta', 'roas', 2.05)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-14', 'meta', 'impressions', 2665202)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-15', 'meta', 'spend', 10569.38)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-15', 'meta', 'roas', 2)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-15', 'meta', 'impressions', 2877466)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-16', 'meta', 'spend', 11616.3)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-16', 'meta', 'roas', 1.9)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-16', 'meta', 'impressions', 3286327)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-17', 'meta', 'spend', 11835.2)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-17', 'meta', 'roas', 3.54)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-17', 'meta', 'impressions', 3362589)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-18', 'meta', 'spend', 13549.96)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-18', 'meta', 'roas', 3.56)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-18', 'meta', 'impressions', 4094066)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-19', 'meta', 'spend', 10128.93)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-19', 'meta', 'roas', 3.31)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-19', 'meta', 'impressions', 2890464)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-20', 'meta', 'spend', 9123.87)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-20', 'meta', 'roas', 2.49)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-20', 'meta', 'impressions', 2739004)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-21', 'meta', 'spend', 9974.92)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-21', 'meta', 'roas', 2.69)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-21', 'meta', 'impressions', 2860141)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-22', 'meta', 'spend', 11702.16)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-22', 'meta', 'roas', 2.6)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-22', 'meta', 'impressions', 2965745)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-23', 'meta', 'spend', 11663.62)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-23', 'meta', 'roas', 2.77)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-23', 'meta', 'impressions', 3124043)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-24', 'meta', 'spend', 12773.46)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-24', 'meta', 'roas', 2.77)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-24', 'meta', 'impressions', 3649866)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-25', 'meta', 'spend', 13168.16)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-25', 'meta', 'roas', 3.01)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-25', 'meta', 'impressions', 3663201)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-26', 'meta', 'spend', 10057.33)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-26', 'meta', 'roas', 2.58)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-26', 'meta', 'impressions', 2886685)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-27', 'meta', 'spend', 8427.79)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-27', 'meta', 'roas', 1.91)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-27', 'meta', 'impressions', 2271138)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-28', 'meta', 'spend', 11176.94)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-28', 'meta', 'roas', 1.89)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-28', 'meta', 'impressions', 3328388)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-29', 'meta', 'spend', 10570.04)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-29', 'meta', 'roas', 1.88)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-29', 'meta', 'impressions', 2875746)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-30', 'meta', 'spend', 10640.09)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-30', 'meta', 'roas', 1.78)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-30', 'meta', 'impressions', 3063617)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-01', 'meta', 'spend', 10805.63)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-01', 'meta', 'roas', 3.58)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-01', 'meta', 'impressions', 2866782)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-02', 'meta', 'spend', 13477.36)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-02', 'meta', 'roas', 3.71)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-02', 'meta', 'impressions', 3983295)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-03', 'meta', 'spend', 12892.26)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-03', 'meta', 'roas', 3.54)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-03', 'meta', 'impressions', 3618899)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-04', 'meta', 'spend', 8194.98)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-04', 'meta', 'roas', 2.72)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-04', 'meta', 'impressions', 1951542)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-05', 'meta', 'spend', 8330.78)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-05', 'meta', 'roas', 2.66)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-05', 'meta', 'impressions', 2319850)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-06', 'meta', 'spend', 10117.72)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-06', 'meta', 'roas', 2.69)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-06', 'meta', 'impressions', 2991362)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-06', 'meta', 'revenue', 38611.69)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-07', 'meta', 'revenue', 41757.56)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-08', 'meta', 'revenue', 41125.1)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-09', 'meta', 'revenue', 22748.34)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-10', 'meta', 'revenue', 92633.29)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-11', 'meta', 'revenue', 78037.92)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-12', 'meta', 'revenue', 76010.42)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-13', 'meta', 'revenue', 59062.4)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-14', 'meta', 'revenue', 66909.29)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-15', 'meta', 'revenue', 38089.79)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-16', 'meta', 'revenue', 19283.02)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-17', 'meta', 'revenue', 29649.6)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-18', 'meta', 'revenue', 22604.17)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-19', 'meta', 'revenue', 22662.73)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-20', 'meta', 'revenue', 46647.21)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-21', 'meta', 'revenue', 48775.92)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-22', 'meta', 'revenue', 40395.81)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-23', 'meta', 'revenue', 26161.1)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-24', 'meta', 'revenue', 32845.35)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-25', 'meta', 'revenue', 28354.14)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-26', 'meta', 'revenue', 34173.64)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-27', 'meta', 'revenue', 39886.52)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-28', 'meta', 'revenue', 39562.73)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-01', 'meta', 'revenue', 30736.83)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-02', 'meta', 'revenue', 19121.4)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-03', 'meta', 'revenue', 23386.07)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-04', 'meta', 'revenue', 20037.14)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-05', 'meta', 'revenue', 17890.08)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-06', 'meta', 'revenue', 39414.2)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-07', 'meta', 'revenue', 45252.31)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-08', 'meta', 'revenue', 41425.65)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-09', 'meta', 'revenue', 24303.82)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-10', 'meta', 'revenue', 30616.9)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-11', 'meta', 'revenue', 30517.88)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-12', 'meta', 'revenue', 26500.34)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-13', 'meta', 'revenue', 35429.81)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-14', 'meta', 'revenue', 30978.78)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-15', 'meta', 'revenue', 34052.49)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-16', 'meta', 'revenue', 17134.6)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-17', 'meta', 'revenue', 26737.18)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-18', 'meta', 'revenue', 24178.04)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-19', 'meta', 'revenue', 14294.47)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-20', 'meta', 'revenue', 47417.93)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-21', 'meta', 'revenue', 46111.79)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-22', 'meta', 'revenue', 46277.69)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-23', 'meta', 'revenue', 23489.63)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-24', 'meta', 'revenue', 28878.75)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-25', 'meta', 'revenue', 31113.37)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-26', 'meta', 'revenue', 29863.23)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-27', 'meta', 'revenue', 34888.97)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-28', 'meta', 'revenue', 34992.56)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-29', 'meta', 'revenue', 32318.85)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-30', 'meta', 'revenue', 16342.6)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-31', 'meta', 'revenue', 22801.63)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-01', 'meta', 'revenue', 21024.78)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-02', 'meta', 'revenue', 24140.85)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-03', 'meta', 'revenue', 45168.97)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-04', 'meta', 'revenue', 40009.27)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-05', 'meta', 'revenue', 47969.09)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-06', 'meta', 'revenue', 21242.58)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-07', 'meta', 'revenue', 33642.32)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-08', 'meta', 'revenue', 32235.05)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-09', 'meta', 'revenue', 32103.55)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-10', 'meta', 'revenue', 41248.48)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-11', 'meta', 'revenue', 33574.96)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-12', 'meta', 'revenue', 32774.64)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-13', 'meta', 'revenue', 19726.33)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-14', 'meta', 'revenue', 20922.38)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-15', 'meta', 'revenue', 24120.17)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-16', 'meta', 'revenue', 23985.05)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-17', 'meta', 'revenue', 43456.6)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-18', 'meta', 'revenue', 53865.3)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-19', 'meta', 'revenue', 35069.81)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-20', 'meta', 'revenue', 24259.49)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-21', 'meta', 'revenue', 28106)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-22', 'meta', 'revenue', 31881.8)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-23', 'meta', 'revenue', 34552.34)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-24', 'meta', 'revenue', 37835.66)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-25', 'meta', 'revenue', 41407.24)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-26', 'meta', 'revenue', 29075.87)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-27', 'meta', 'revenue', 17046.11)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-28', 'meta', 'revenue', 22655.07)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-29', 'meta', 'revenue', 21182.35)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-30', 'meta', 'revenue', 19896)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-01', 'meta', 'revenue', 41719.36)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-02', 'meta', 'revenue', 52611.64)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-03', 'meta', 'revenue', 48082.87)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-04', 'meta', 'revenue', 24784.58)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-05', 'meta', 'revenue', 22774.22)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-06', 'meta', 'revenue', 28888.18)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-06', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-07', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-08', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-09', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-10', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-11', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-12', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-13', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-14', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-15', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-16', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-17', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-18', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-19', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-20', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-21', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-22', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-23', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-24', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-25', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-26', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-27', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-02-28', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-01', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-02', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-03', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-04', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-05', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-06', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-07', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-08', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-09', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-10', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-11', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-12', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-13', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-14', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-15', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-16', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-17', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-18', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-19', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-20', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-21', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-22', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-23', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-24', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-25', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-26', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-27', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-28', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-29', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-30', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-03-31', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-01', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-02', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-03', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-04', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-05', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-06', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-07', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-08', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-09', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-10', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-11', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-12', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-13', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-14', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-15', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-16', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-17', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-18', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-19', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-20', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-21', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-22', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-23', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-24', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-25', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-26', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-27', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-28', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-29', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-04-30', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-01', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-02', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-03', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-04', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-05', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1', '2026-05-06', 'tally_csv', 'cash_position', 1840000)
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;
commit;
