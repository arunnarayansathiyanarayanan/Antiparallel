# Claude Code Prompts — Brain D2C MVP
# Copy and paste each prompt into your Claude Code terminal session
# Run them in sequence. One task per session.

# ================================================================
# ARCHITECTURE NOTE — NO N8N
# ================================================================
# All automation (syncing, morning briefs) runs as Vercel Cron Jobs,
# not n8n workflows. The two cron endpoints are:
#
#   /api/cron/sync   → every 4 hours (vercel.json: "0 */4 * * *")
#                      syncs Shopify + Meta for all active brands
#                      checks ROAS / RTO / cash alerts
#
#   /api/cron/brief  → 8am IST daily (vercel.json: "30 2 * * *")
#                      generates Claude brief → sends via WhatsApp
#                      only for Growth/Scale plan brands with a phone number
#
# Both routes are secured with Authorization: Bearer <CRON_SECRET>
# Set CRON_SECRET in .env.local and Vercel project settings.

# ================================================================
# BEFORE YOU START
# ================================================================
# 1. Install Claude Code: npm install -g @anthropic-ai/claude-code
# 2. cd into brain-d2c/ folder
# 3. Run: claude
# 4. Paste prompts below one at a time

# ================================================================
# DAY 1 PROMPT 1 — Project scaffold
# ================================================================
Create a Next.js 14 project with TypeScript in the current directory.
Use the App Router. Install these dependencies:
- @anthropic-ai/sdk
- ai (Vercel AI SDK)
- @ai-sdk/anthropic
- @supabase/supabase-js
- @supabase/ssr
- razorpay
- @upstash/redis
- @upstash/ratelimit
- zod
- date-fns
- recharts
- lucide-react
- tailwindcss
- shadcn/ui

Set up shadcn/ui with the default config.
Create the folder structure exactly as defined in CLAUDE.md.
Create an .env.local file by copying .env.example.
Create a .gitignore that ignores .env.local and node_modules.
Do not create placeholder pages yet — just the structure.

# ================================================================
# DAY 1 PROMPT 2 — Supabase client setup
# ================================================================
Read the CLAUDE.md file and the supabase/migrations/001_initial_schema.sql file.
Then:
1. Create lib/supabase/client.ts — browser Supabase client using createBrowserClient from @supabase/ssr
2. Create lib/supabase/server.ts — server Supabase client using createServerClient from @supabase/ssr
   that reads cookies from Next.js headers()
3. Create lib/supabase/middleware.ts — middleware to refresh auth sessions
4. Create middleware.ts at root — uses the supabase middleware
5. Create all TypeScript types in types/index.ts based on the database schema in CLAUDE.md

# ================================================================
# DAY 1 PROMPT 3 — Shopify integration
# ================================================================
Read CLAUDE.md for context on what Brain does.
Create lib/integrations/shopify.ts with these functions:
1. getShopifyOAuthUrl(shop: string): string — generates OAuth redirect URL
2. exchangeShopifyCode(shop: string, code: string): Promise<string> — exchanges auth code for access token
3. syncShopifyData(brandId: string, shopDomain: string, accessToken: string): Promise<void>
   — pulls last 90 days of orders from Shopify Admin API
   — computes daily metrics: revenue, orders, AOV, return_count, rto_rate
   — upserts to metrics_daily table in Supabase
   — updates integrations.last_synced_at and sync_status
4. getTopSkus(brandId: string, days: number): Promise<SkuMetric[]>
   — returns top 10 SKUs by revenue from metrics_daily

Use the Shopify Admin REST API v2024-01.
Handle rate limiting with exponential backoff.
Handle pagination (250 orders per page).

Also create app/api/integrations/shopify/auth/route.ts — GET handler that:
- Receives shop and code params
- Calls exchangeShopifyCode
- Saves token to integrations table
- Redirects to /dashboard/sources?connected=shopify

# ================================================================
# DAY 2 PROMPT 1 — Meta Ads integration
# ================================================================
Read CLAUDE.md for context.
Create lib/integrations/meta.ts with these functions:
1. getMetaOAuthUrl(): string — generates Meta OAuth URL with ads_read scope
2. exchangeMetaCode(code: string): Promise<string> — exchanges for long-lived token
3. syncMetaAdsData(brandId: string, adAccountId: string, accessToken: string): Promise<void>
   — pulls campaign insights from Meta Marketing API for last 90 days
   — fields: spend, impressions, clicks, conversions, purchase_roas
   — computes daily: spend, roas, cpm, ctr, conversions
   — upserts to metrics_daily with source='meta'
4. getAdCreativePerformance(brandId: string, days: number): Promise<CreativeMetric[]>
   — returns ad performance by creative_id, sorted by roas desc

Also create app/api/integrations/meta/auth/route.ts — similar to Shopify auth route.

# ================================================================
# DAY 2 PROMPT 2 — AI intelligence engine (core brain)
# ================================================================
Read CLAUDE.md carefully, especially the system prompt structure and Indian D2C context sections.

Create lib/ai/context-builder.ts:
- function buildBrandContext(brandId: string): Promise<BrandContext>
  Queries Supabase for:
  1. brands + brand_context row for this brand
  2. Last 30 days metrics_daily (all sources)
  3. Unresolved alerts from last 48 hours
  4. Recent conversation summary (last 5 messages)
  Returns a structured BrandContext object

Create lib/ai/system-prompt.ts:
- function buildSystemPrompt(ctx: BrandContext): string
  Generates the full system prompt string with:
  - Brand identity and key SKUs
  - Revenue and orders last 7 days (vs prev 7 days)
  - Ad spend and ROAS per platform
  - Cash position if available
  - Recent alerts
  - Full Indian D2C context (festivals, benchmarks, COD norms, GST)
  - Instructions for response format

Create app/api/chat/route.ts:
- POST handler using Vercel AI SDK streamText
- Reads brandId from request body
- Calls buildBrandContext + buildSystemPrompt
- Streams response from claude-sonnet-4-20250514
- Saves conversation to conversations table after completion
- Rate limits: 50 messages per brand per day using Upstash Redis

# ================================================================
# DAY 2 PROMPT 3 — Chat UI
# ================================================================
Read CLAUDE.md for context. Look at the existing components folder.

Create components/chat/ChatInterface.tsx:
A dark-themed chat interface component that:
- Shows a header with brand name, source connection status dots, and live sync indicator
- Shows connected sources as pills (Shopify ✓, Meta ✓, Google pending)
- Displays conversation messages with streaming support using useChat from 'ai/react'
- Has quick-question chips: "Why did sales drop?", "Most profitable SKU?",
  "Cash runway?", "Scale which creative?", "Biggest risk this week?"
- Has a text input with send button
- Shows AI responses with markdown formatting (bold, bullet points)
- Shows a subtle "analysing your data..." indicator while streaming
- Mobile responsive

Create app/(dashboard)/chat/page.tsx:
- Server component that gets the brand from Supabase session
- Renders ChatInterface with the brandId prop

# ================================================================
# DAY 3 PROMPT 1 — Morning brief + WhatsApp
# ================================================================
Read CLAUDE.md for WhatsApp and morning brief requirements.

Create lib/whatsapp.ts:
- sendWhatsAppMessage(phone: string, text: string): Promise<void>
  Uses Meta Cloud API to send a text message
- sendWhatsAppTemplate(phone: string, templateName: string, params: string[]): Promise<void>

Create lib/ai/brief-generator.ts:
- generateMorningBrief(brandId: string): Promise<string>
  Uses Claude to generate a concise WhatsApp morning brief (max 300 chars)
  Format:
  "🧠 Good morning [name]!
  📊 Yesterday: ₹X (+Y% vs last week)
  ⚠️ [top alert if any]
  💰 Cash: ₹X
  Reply with any question."

Create app/api/cron/brief/route.ts:
- GET handler (secured with CRON_SECRET header)
- Gets all brands with plan_status='active' and founder_phone set
- For each brand: generates brief → sends WhatsApp
- Logs success/failure to alerts table
- Returns summary JSON

Create app/api/cron/sync/route.ts:
- GET handler (secured with CRON_SECRET)
- Gets all active brands with connected integrations
- Syncs Shopify data for each brand
- Syncs Meta data for each brand
- Checks for alert conditions (ROAS < 2.5, RTO > 15%, low cash)
- Creates alert records for triggered conditions

# ================================================================
# DAY 3 PROMPT 2 — Alert detection engine
# ================================================================
Read CLAUDE.md for alert types.

Create lib/ai/alert-detector.ts with these functions:
- checkRoasAlert(brandId: string): Promise<Alert | null>
  If blended ROAS drops >20% in last 24h vs 7d average → critical alert
- checkCreativeFatigueAlert(brandId: string): Promise<Alert | null>
  If any Meta creative CTR drops >40% in 48h → warning alert
- checkCashAlert(brandId: string): Promise<Alert | null>
  If cash position from Tally CSV < 2x monthly ad spend → warning
- checkRtoAlert(brandId: string): Promise<Alert | null>
  If RTO rate spikes >5pp above brand's 30d average → warning
- runAllAlertChecks(brandId: string): Promise<Alert[]>
  Runs all checks, saves new alerts to Supabase, returns new ones

# ================================================================
# DAY 4 PROMPT 1 — Razorpay billing
# ================================================================
Create lib/razorpay.ts:
- createSubscription(brandId: string, planId: string): Promise<string>
  Creates a Razorpay subscription, returns subscription_id
- cancelSubscription(subscriptionId: string): Promise<void>
- PLAN_IDS constant mapping plan names to Razorpay plan IDs

Create app/api/webhooks/razorpay/route.ts:
- POST handler
- Verify Razorpay webhook signature using RAZORPAY_WEBHOOK_SECRET
- Handle these events:
  - subscription.activated → set brand plan_status='active', plan from metadata
  - subscription.charged → update mrr_inr
  - subscription.cancelled → set plan_status='cancelled', plan='trial'
  - subscription.halted → set plan_status='paused', send WhatsApp alert to founder
- Return 200 for all handled events

# ================================================================
# DAY 4 PROMPT 2 — Onboarding flow
# ================================================================
Create a 3-step onboarding flow in app/(dashboard)/onboarding/:
Step 1 (/onboarding/brand): Brand name, founder name, phone, key SKUs (comma separated), target ROAS
Step 2 (/onboarding/connect): Connect Shopify (OAuth button), connect Meta (OAuth button), CSV upload for Tally
Step 3 (/onboarding/done): Success screen with first morning brief preview

Each step saves to Supabase (brands + brand_context tables).
After step 3, redirect to /dashboard/chat.
Show a progress indicator.
Make it mobile-friendly.

# ================================================================
# DAY 5 PROMPT — Landing page + auth
# ================================================================
Create app/page.tsx — a conversion-optimised landing page with:
- Hero: "Ask your business anything. Get an instant answer."
- 3 live demo questions with typewriter animation showing AI responses
- Pricing section: 3 cards (Starter ₹4,999 / Growth ₹9,999 / Scale ₹24,999)
- Social proof section: "Trusted by 50+ Indian D2C brands" (placeholder)
- FAQ section: 5 common questions
- CTA: "Start free 14-day trial" → /signup

Create app/(auth)/signup/page.tsx:
- Email + password signup using Supabase Auth
- After signup: create brand record → redirect to /onboarding/brand

Create app/(auth)/login/page.tsx:
- Email + password login
- Redirect to /dashboard/chat

# ================================================================
# FINAL PROMPT — Production checklist
# ================================================================
Review the entire codebase and:
1. Add proper error boundaries to all API routes (try/catch, return 500 with message)
2. Add input validation using zod to all POST/GET handlers
3. Add the CRON_SECRET check to both cron route handlers
4. Ensure no sensitive keys are logged to console
5. Add a /api/health route that returns 200 with { status: 'ok', timestamp }
6. Review all Supabase queries — ensure they use service_role key on server, anon key on client
7. Add rate limiting to /api/chat using Upstash Redis (50 requests/brand/day)
8. Create a README.md with setup instructions

List any missing pieces before I deploy.
