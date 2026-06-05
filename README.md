# Brain — AI BI for Indian D2C Brands
Brain is an AI-powered business intelligence platform for Indian D2C founders.
It connects sales, ads, and finance data and answers business questions in plain English.

## Stack

- Next.js 14 (App Router + TypeScript)
- Supabase (Postgres + Auth)
- Anthropic Claude via Vercel AI SDK
- Tailwind + shadcn/ui
- Razorpay Subscriptions
- Upstash Redis (rate limit)
- Vercel Cron + WhatsApp Cloud API

## Prerequisites

- Node.js 18+
- A Supabase project
- Anthropic API key
- Meta app credentials (for Meta Ads + WhatsApp)
- Shopify app credentials
- Razorpay credentials
- Upstash Redis credentials

## Environment Setup

1. Copy environment template:

```bash
cp .env.example .env.local
```

2. Fill all required keys in `.env.local`:
- `ANTHROPIC_API_KEY`
- `NEXT_PUBLIC_SUPABASE_URL`
- `NEXT_PUBLIC_SUPABASE_ANON_KEY`
- `SUPABASE_SERVICE_ROLE_KEY`
- `SHOPIFY_API_KEY`
- `SHOPIFY_API_SECRET`
- `NEXT_PUBLIC_APP_URL`
- `META_APP_ID`
- `META_APP_SECRET`
- `WHATSAPP_TOKEN`
- `WHATSAPP_PHONE_NUMBER_ID`
- `WHATSAPP_VERIFY_TOKEN`
- `RAZORPAY_KEY_ID`
- `RAZORPAY_KEY_SECRET`
- `RAZORPAY_WEBHOOK_SECRET`
- `UPSTASH_REDIS_REST_URL`
- `UPSTASH_REDIS_REST_TOKEN`
- `CRON_SECRET`

## Install and Run

```bash
npm install
npm run dev
```

Open `http://localhost:3000`.

## Core Routes

- Landing: `/`
- Signup: `/signup`
- Login: `/login`
- Chat: `/chat`
- Sources: `/sources`
- Alerts: `/alerts`
- Settings: `/settings`

## API Routes

- Chat: `POST /api/chat`
- Health: `GET /api/health`
- Cron sync: `GET /api/cron/sync` (Bearer `CRON_SECRET`)
- Cron brief: `GET /api/cron/brief` (Bearer `CRON_SECRET`)
- Shopify OAuth callback: `GET /api/integrations/shopify/auth`
- Meta OAuth callback: `GET /api/integrations/meta/auth`
- Razorpay webhook: `POST /api/webhooks/razorpay`

## Cron Configuration

`vercel.json` should include:
- `/api/cron/sync` every 4 hours
- `/api/cron/brief` at 8am IST (`30 2 * * *` UTC)

## Quick Verification

- `GET /api/health` returns `{ status: "ok", timestamp }`
- Signup creates/authenticates a user, then redirects to onboarding
- OAuth callbacks redirect to `/dashboard/sources?connected=<source>`
- Chat API enforces 50 requests per brand/day when Upstash keys are configured

## Sample Data (Local QA)

- Prepare aligned sample seed assets: `npm run prepare:sample-data`
- Generated files are written to `sample-data/`
- Use `sample-data/seed.sql` in Supabase SQL Editor for fast seeding
- Demo brand ID for chat tests: `9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1`

## Deployment Notes

- Add all `.env.local` keys to Vercel project settings.
- Set `CRON_SECRET` in Vercel for cron authorization.
- Ensure Supabase RLS policies match app behavior.
- Never log secrets or full tokens in server logs.
