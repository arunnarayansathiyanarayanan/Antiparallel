# Brain — AI Business Intelligence for Indian D2C Brands

## What this product is

Brain is an AI-powered business intelligence platform for Indian D2C brands.
It connects every data source a D2C brand uses (Shopify, Meta Ads, Google Ads,
Amazon India, Tally/Zoho Books, GSTN) and lets the founder ask any business
question in plain English via a chat interface or WhatsApp.

It replaces: CA firm (monthly bookkeeping), analytics agency (weekly reports),
growth consultant (ad optimization), and CFO (cash flow management).

**The founder types:** "Why did sales drop last Tuesday?"
**Brain answers:** "Three causes: Meta creative fatigued (60% of drop), Flipkart
Buy Box lost on 3 SKUs (30%), Shiprocket SLA breach in Delhi (10%). Recommended
actions: ..."

## Tech stack

- **Framework:** Next.js 14 (App Router, TypeScript)
- **Database:** Supabase (Postgres + pgvector + Auth)
- **AI:** Anthropic Claude claude-sonnet-4-20250514 via Vercel AI SDK (streaming)
- **Styling:** Tailwind CSS + shadcn/ui
- **Billing:** Razorpay Subscriptions
- **WhatsApp:** Meta Cloud API (WABA)
- **Deployment:** Vercel
- **Caching:** Upstash Redis
- **Monitoring:** Sentry + PostHog

## Project structure

```
brain-d2c/
├── app/
│   ├── (auth)/
│   │   ├── login/page.tsx
│   │   └── signup/page.tsx
│   ├── (dashboard)/
│   │   ├── layout.tsx
│   │   ├── chat/page.tsx           ← Main chat interface
│   │   ├── sources/page.tsx        ← Connect data sources
│   │   ├── alerts/page.tsx         ← Alert management
│   │   └── settings/page.tsx
│   ├── api/
│   │   ├── chat/route.ts           ← Claude streaming chat
│   │   ├── sync/
│   │   │   ├── shopify/route.ts    ← Shopify data sync
│   │   │   ├── meta/route.ts       ← Meta Ads sync
│   │   │   └── google/route.ts     ← Google Ads sync
│   │   ├── webhooks/
│   │   │   ├── razorpay/route.ts   ← Billing webhooks
│   │   │   └── whatsapp/route.ts   ← WA incoming messages
│   │   ├── integrations/
│   │   │   ├── shopify/auth/route.ts   ← Shopify OAuth
│   │   │   └── meta/auth/route.ts     ← Meta OAuth
│   │   └── cron/
│   │       ├── sync/route.ts       ← 4-hour data sync
│   │       └── brief/route.ts      ← 8am morning brief
│   ├── layout.tsx
│   └── page.tsx                    ← Landing page
├── components/
│   ├── chat/
│   │   ├── ChatInterface.tsx       ← Main chat UI
│   │   ├── MessageBubble.tsx
│   │   ├── QuickQuestions.tsx
│   │   └── SourceStatus.tsx
│   ├── dashboard/
│   │   ├── MetricsStrip.tsx
│   │   ├── AlertBanner.tsx
│   │   └── DataSourceCard.tsx
│   └── ui/                        ← shadcn components
├── lib/
│   ├── supabase/
│   │   ├── client.ts              ← Browser client
│   │   └── server.ts              ← Server client
│   ├── integrations/
│   │   ├── shopify.ts             ← Shopify API client
│   │   ├── meta.ts                ← Meta API client
│   │   └── google.ts              ← Google Ads client
│   ├── ai/
│   │   ├── system-prompt.ts       ← Master system prompt builder
│   │   ├── context-builder.ts     ← RAG context from Supabase
│   │   └── actions.ts             ← Action dispatcher
│   ├── whatsapp.ts                ← WhatsApp Cloud API client
│   ├── razorpay.ts                ← Razorpay client
│   └── utils.ts
├── types/
│   └── index.ts                   ← All TypeScript types
├── supabase/
│   └── migrations/
│       └── 001_initial_schema.sql ← Full DB schema
├── .env.local                     ← All environment variables
├── .env.example                   ← Template (commit this)
├── vercel.json                    ← Vercel cron config
└── CLAUDE.md                      ← This file
```

## Database schema (Supabase Postgres)

```sql
-- brands: one row per D2C brand (paying customer)
brands (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  founder_name text,
  founder_phone text,        -- WhatsApp number for briefs (+91XXXXXXXXXX)
  founder_email text,
  plan text DEFAULT 'trial', -- trial | starter | growth | scale
  plan_status text DEFAULT 'active',
  razorpay_subscription_id text,
  mrr_inr integer DEFAULT 0,
  timezone text DEFAULT 'Asia/Kolkata',
  created_at timestamptz DEFAULT now(),
  trial_ends_at timestamptz DEFAULT now() + interval '14 days'
)

-- integrations: connected data sources per brand
integrations (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  brand_id uuid REFERENCES brands(id) ON DELETE CASCADE,
  source text NOT NULL,      -- shopify | meta | google | tally_csv | amazon
  access_token text,
  refresh_token text,
  shop_domain text,          -- for Shopify: mystore.myshopify.com
  account_id text,           -- for Meta/Google: ad account ID
  last_synced_at timestamptz,
  sync_status text DEFAULT 'pending',
  error_message text,
  metadata jsonb DEFAULT '{}',
  created_at timestamptz DEFAULT now()
)

-- metrics_daily: pre-computed daily metrics per source
metrics_daily (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  brand_id uuid REFERENCES brands(id) ON DELETE CASCADE,
  date date NOT NULL,
  source text NOT NULL,
  metric_key text NOT NULL,  -- revenue | orders | roas | spend | aov | rto_rate
  metric_value numeric,
  metadata jsonb DEFAULT '{}',
  UNIQUE(brand_id, date, source, metric_key)
)

-- conversations: chat history per brand
conversations (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  brand_id uuid REFERENCES brands(id) ON DELETE CASCADE,
  messages jsonb NOT NULL DEFAULT '[]',
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
)

-- alerts: triggered alerts per brand
alerts (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  brand_id uuid REFERENCES brands(id) ON DELETE CASCADE,
  alert_type text NOT NULL,  -- roas_drop | creative_fatigue | cash_low | rto_spike | gst_notice
  severity text DEFAULT 'warning', -- info | warning | critical
  message text NOT NULL,
  data jsonb DEFAULT '{}',
  triggered_at timestamptz DEFAULT now(),
  resolved_at timestamptz,
  notified_whatsapp boolean DEFAULT false
)

-- brand_context: static context about the brand for AI
brand_context (
  brand_id uuid PRIMARY KEY REFERENCES brands(id) ON DELETE CASCADE,
  key_skus text[],           -- ['Collagen Gummies 30pc', 'Vitamin C Serum']
  target_roas numeric DEFAULT 3.0,
  monthly_ad_budget_inr integer,
  competitors text[],
  primary_channels text[],   -- ['shopify', 'amazon', 'flipkart']
  business_notes text,       -- anything the brand wants AI to always know
  updated_at timestamptz DEFAULT now()
)
```

## Environment variables required

```bash
# Anthropic
ANTHROPIC_API_KEY=

# Supabase
NEXT_PUBLIC_SUPABASE_URL=
NEXT_PUBLIC_SUPABASE_ANON_KEY=
SUPABASE_SERVICE_ROLE_KEY=

# Shopify OAuth
SHOPIFY_API_KEY=
SHOPIFY_API_SECRET=
NEXT_PUBLIC_APP_URL=http://localhost:3000

# Meta (Facebook) Marketing API
META_APP_ID=
META_APP_SECRET=

# Google Ads API
GOOGLE_ADS_DEVELOPER_TOKEN=
GOOGLE_CLIENT_ID=
GOOGLE_CLIENT_SECRET=

# WhatsApp Cloud API
WHATSAPP_TOKEN=
WHATSAPP_PHONE_NUMBER_ID=
WHATSAPP_VERIFY_TOKEN=brain-webhook-secret-2026

# Razorpay
RAZORPAY_KEY_ID=
RAZORPAY_KEY_SECRET=
RAZORPAY_WEBHOOK_SECRET=

# Redis (Upstash)
UPSTASH_REDIS_REST_URL=
UPSTASH_REDIS_REST_TOKEN=

# Cron security
CRON_SECRET=your-random-secret-here
```

## Core AI system prompt structure

When a founder asks a question, the AI context must include:

1. **Brand identity:** name, key SKUs, target ROAS, primary channels
2. **Last 7 days revenue:** daily breakdown per channel
3. **Last 7 days ad spend + ROAS:** per platform (Meta, Google, Amazon)
4. **Inventory situation:** if available
5. **Cash position:** from Tally CSV if uploaded
6. **Recent alerts:** any triggered in last 48 hours
7. **Indian D2C context:** festival calendar, COD benchmarks, RTO norms

The system prompt always ends with:
"Answer like a world-class Indian D2C growth advisor. Be specific, cite exact
numbers from the data above. Give 1-2 concrete action recommendations. If data
is insufficient, say exactly which source to connect. Keep responses under 300
words unless the question requires detail."

## Key business rules

- Trial: 14 days free, all features, no credit card required
- Starter ₹4,999/month: Shopify + 1 ad platform, up to ₹1 cr GMV
- Growth ₹9,999/month: all platforms, unlimited GMV, WhatsApp briefs
- Scale ₹24,999/month: all platforms + action engine + priority support
- Syncing: every 4 hours via Vercel cron (/api/cron/sync)
- Morning brief: every day 8am IST via Vercel cron (/api/cron/brief)
- Data retention: 365 days of metrics_daily per brand

## Indian D2C context for AI

This context must be baked into every AI response:

- **RTO benchmarks:** <8% excellent, 8-15% average, >15% critical
- **Meta ROAS benchmarks India:** >4x excellent, 2.5-4x acceptable, <2.5x poor
- **COD ratio:** typically 40-60% for Indian D2C
- **Festival calendar:** Diwali (Oct/Nov), Holi (Mar), Rakhi (Aug) cause 3-5x spikes
- **Inventory planning:** order 60-90 days before peak season
- **GST on D2C:** 18% on most products, some at 5% or 12%
- **Payment settlement:** Shopify Payments India settles in 3-5 business days
- **Amazon FBA India vs FBM:** FBA has 15-20% fees, FBM has 5-10% fees + self-ship

## What NOT to build (out of scope for MVP)

- Flipkart API integration (partial API, add at v2)
- Amazon India API (complex, add at v2 after Shopify proven)
- Tally live API (use CSV upload for MVP)
- Real-time stock price or competitor price monitoring
- AI-generated creatives or copy
- Multi-currency support (INR only for MVP)
- Team/multi-user per brand (single founder user per brand for MVP)
