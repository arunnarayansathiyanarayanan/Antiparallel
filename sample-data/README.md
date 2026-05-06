# Sample Data (MVP Test-Ready)

This folder contains sample data that is aligned with the current app schema and API validation.

## Files

- `brand_seed.json` - Brand + brand context seed (UUID brand ID)
- `metrics_daily_seed.json` - Metrics seed rows for `metrics_daily`
- `seed.sql` - One-shot SQL seed script for Supabase SQL Editor
- `orders.csv`, `meta_ads_daily.csv`, `tally_pl.csv` - Source-style CSVs
- `sku_summary.json` - Top SKU summary

## How to regenerate

Run:

```bash
npm run prepare:sample-data
```

This script reads from `Sample Data/` (raw source samples), fixes schema mismatches, and writes production-ready output here.

## How to load into Supabase quickly

1. Open Supabase SQL Editor.
2. Copy and run `sample-data/seed.sql`.
3. In chat UI/API, use brand ID:

`9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1`

## Notes

- This seed includes `meta` `revenue` metrics so ROAS calculations work in context builder.
- This seed includes `tally_csv` `cash_position` metrics so cash insights appear in AI responses.
