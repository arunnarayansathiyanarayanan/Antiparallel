"""
Generates realistic Indian D2C brand sample data for Brain MVP testing.
Brand: "WellNest" — a health supplements D2C brand selling on Shopify + Meta + Google.
₹3-4 crore annual revenue, typical Indian D2C patterns.
"""

import json
import random
import csv
from datetime import datetime, timedelta
from pathlib import Path

random.seed(42)

# ── Configuration ────────────────────────────────────────────
BRAND_ID = "demo-brand-wellnest-001"
BRAND_NAME = "WellNest India"
FOUNDER = "Arun Sharma"
PHONE = "+919876543210"

SKUS = [
    {"name": "Collagen Gummies 30pc", "cogs": 85, "asp": 699},
    {"name": "Vitamin C Serum 30ml",  "cogs": 120, "asp": 899},
    {"name": "Ashwagandha 60pc",       "cogs": 65, "asp": 499},
    {"name": "Biotin Hair Gummies",    "cogs": 75, "asp": 599},
    {"name": "Omega-3 Fish Oil 60pc",  "cogs": 90, "asp": 799},
    {"name": "Multivitamin Women 30pc","cogs": 70, "asp": 549},
]

CITIES = [
    ("Mumbai", 22), ("Delhi", 18), ("Bengaluru", 15),
    ("Hyderabad", 10), ("Chennai", 8), ("Pune", 7),
    ("Kolkata", 6), ("Ahmedabad", 5), ("Jaipur", 3), ("Lucknow", 3),
    ("Surat", 1), ("Chandigarh", 1), ("Bhopal", 1),
]

COURIERS = ["Delhivery", "BlueDart", "DTDC", "Ecom Express", "Shadowfax"]

def gen_dates(days=90):
    today = datetime.now().date()
    return [today - timedelta(days=i) for i in range(days)][::-1]

def seasonal_multiplier(date):
    """Indian festival demand patterns."""
    m, d = date.month, date.day
    # Diwali window (Oct 15 - Nov 10)
    if m == 10 and d >= 15: return 2.8
    if m == 11 and d <= 10: return 2.2
    # Valentine's (Feb 10-14)
    if m == 2 and 10 <= d <= 14: return 1.6
    # Mother's Day (May 12-13)
    if m == 5 and 12 <= d <= 13: return 1.5
    # Rakhi (Aug 18-19 approx)
    if m == 8 and 16 <= d <= 22: return 1.8
    # General weekend bump
    if date.weekday() in (4, 5, 6): return 1.15
    # Monday dip
    if date.weekday() == 0: return 0.88
    return 1.0

def gen_rto_rate(city, courier, sku):
    """Indian D2C RTO rates vary significantly."""
    base = 0.09  # 9% baseline
    if city in ("Jaipur", "Lucknow", "Bhopal"): base += 0.05  # tier-2 higher RTO
    if courier == "Shadowfax": base += 0.03
    if courier == "BlueDart": base -= 0.03
    if sku["asp"] > 700: base -= 0.02  # expensive = more intent
    return max(0.03, min(0.22, base + random.gauss(0, 0.02)))

# ── 1. ORDERS TABLE (Shopify-style) ──────────────────────────
print("Generating orders...")
orders = []
order_id = 10001
dates = gen_dates(90)

for date in dates:
    multiplier = seasonal_multiplier(date)
    # Base ~35 orders/day, with seasonal multiplier
    n_orders = int(random.gauss(35 * multiplier, 5))
    n_orders = max(5, n_orders)

    for _ in range(n_orders):
        sku = random.choices(SKUS, weights=[30, 20, 18, 15, 10, 7])[0]
        city, _ = random.choices(CITIES, weights=[w for _, w in CITIES])[0], None
        city = random.choices([c for c, _ in CITIES], weights=[w for _, w in CITIES])[0]
        courier = random.choice(COURIERS)
        is_cod = random.random() < 0.48  # 48% COD for Indian D2C
        rto_rate = gen_rto_rate(city, courier, sku)
        is_returned = random.random() < rto_rate
        qty = random.choices([1, 2, 3], weights=[70, 22, 8])[0]

        # Small discount sometimes
        discount = 0
        if random.random() < 0.25:
            discount = sku["asp"] * qty * random.choice([0.05, 0.10, 0.15])

        net_revenue = (sku["asp"] * qty) - discount

        orders.append({
            "order_id": f"ORD{order_id}",
            "created_at": f"{date}T{random.randint(8,22):02d}:{random.randint(0,59):02d}:00+05:30",
            "sku_name": sku["name"],
            "quantity": qty,
            "asp_inr": sku["asp"],
            "cogs_inr": sku["cogs"],
            "gross_revenue_inr": sku["asp"] * qty,
            "discount_inr": round(discount, 2),
            "net_revenue_inr": round(net_revenue, 2),
            "city": city,
            "payment_method": "COD" if is_cod else "Prepaid",
            "courier": courier,
            "is_returned": is_returned,
            "order_status": "returned" if is_returned else "delivered",
            "financial_status": "refunded" if is_returned else "paid",
        })
        order_id += 1

print(f"  Generated {len(orders)} orders")

# ── 2. DAILY SHOPIFY METRICS ──────────────────────────────────
print("Generating daily Shopify metrics...")
shopify_daily = {}
for o in orders:
    d = o["created_at"][:10]
    if d not in shopify_daily:
        shopify_daily[d] = {
            "brand_id": BRAND_ID, "date": d, "source": "shopify",
            "revenue": 0, "net_revenue": 0, "orders": 0,
            "returns": 0, "cod_orders": 0, "aov": 0
        }
    s = shopify_daily[d]
    s["revenue"] += o["gross_revenue_inr"]
    s["net_revenue"] += 0 if o["is_returned"] else o["net_revenue_inr"]
    s["orders"] += 1
    if o["is_returned"]: s["returns"] += 1
    if o["payment_method"] == "COD": s["cod_orders"] += 1

for d, s in shopify_daily.items():
    if s["orders"] > 0:
        s["aov"] = round(s["revenue"] / s["orders"], 2)
        s["rto_rate"] = round(s["returns"] / s["orders"] * 100, 2)
        s["cod_rate"] = round(s["cod_orders"] / s["orders"] * 100, 2)
    for k in ["revenue", "net_revenue"]:
        s[k] = round(s[k], 2)

# ── 3. META ADS DAILY METRICS ─────────────────────────────────
print("Generating Meta Ads metrics...")
meta_daily = []

# Campaigns
campaigns = [
    {"id": "camp_collagen", "name": "Collagen Gummies — Conversion", "budget_base": 4000},
    {"id": "camp_vitamin", "name": "Vitamin C Serum — Conversion",   "budget_base": 3000},
    {"id": "camp_retarget", "name": "Retargeting — All Products",     "budget_base": 2000},
    {"id": "camp_awareness", "name": "Brand Awareness",               "budget_base": 1500},
]

for date in dates:
    multiplier = seasonal_multiplier(date)
    for c in campaigns:
        spend = c["budget_base"] * multiplier * random.gauss(1, 0.15)
        # ROAS degrades over time (creative fatigue) then spikes with new creative
        day_index = dates.index(date)
        fatigue = 1 - (day_index % 14) * 0.03  # fatigue resets every 14 days
        base_roas = 3.8 if "Collagen" in c["name"] else 3.2 if "Vitamin" in c["name"] else 4.1 if "Retarget" in c["name"] else 1.2
        roas = base_roas * fatigue * random.gauss(1, 0.1) * multiplier
        revenue_attributed = spend * roas
        impressions = spend * random.gauss(280, 30)  # ~₹3.5 CPM
        ctr = random.gauss(0.022, 0.005)
        clicks = impressions * ctr

        meta_daily.append({
            "brand_id": BRAND_ID,
            "date": str(date),
            "source": "meta",
            "campaign_id": c["id"],
            "campaign_name": c["name"],
            "spend_inr": round(spend, 2),
            "impressions": int(impressions),
            "clicks": int(clicks),
            "ctr_pct": round(ctr * 100, 3),
            "cpm_inr": round((spend / impressions) * 1000, 2) if impressions > 0 else 0,
            "roas": round(roas, 2),
            "revenue_attributed_inr": round(revenue_attributed, 2),
            "conversions": int(revenue_attributed / 699),
        })

print(f"  Generated {len(meta_daily)} Meta Ads daily rows")

# ── 4. TALLY P&L CSV (simplified) ────────────────────────────
print("Generating Tally P&L data...")
tally_data = []
for date in dates:
    d = str(date)
    if d not in shopify_daily:
        continue
    s = shopify_daily[d]
    meta_spend = sum(r["spend_inr"] for r in meta_daily if r["date"] == d)
    cogs = sum(o["cogs_inr"] * o["quantity"] for o in orders if o["created_at"][:10] == d and not o["is_returned"])
    logistics = s["orders"] * random.gauss(65, 10)  # ₹65 avg per order
    gross_profit = s["net_revenue"] - cogs
    ebitda = gross_profit - meta_spend - logistics - 800  # ₹800/day fixed overhead

    tally_data.append({
        "date": d,
        "gross_revenue": round(s["revenue"], 2),
        "returns_deducted": round(s["revenue"] - s["net_revenue"], 2),
        "net_revenue": round(s["net_revenue"], 2),
        "cogs": round(cogs, 2),
        "gross_profit": round(gross_profit, 2),
        "meta_ad_spend": round(meta_spend, 2),
        "logistics_cost": round(logistics, 2),
        "fixed_overheads": 800,
        "ebitda": round(ebitda, 2),
    })

# Cash position summary
total_ebitda = sum(r["ebitda"] for r in tally_data[-30:])
cash_in_bank = 1840000  # ₹18.4 lakh

# ── 5. METRICS_DAILY (Supabase format) ───────────────────────
print("Generating metrics_daily rows for Supabase...")
supabase_rows = []
for d, s in shopify_daily.items():
    for key in ["revenue", "net_revenue", "orders", "rto_rate", "cod_rate", "aov"]:
        supabase_rows.append({
            "brand_id": BRAND_ID,
            "date": d,
            "source": "shopify",
            "metric_key": key,
            "metric_value": s[key],
        })

# Aggregate Meta by date
meta_by_date = {}
for r in meta_daily:
    d = r["date"]
    if d not in meta_by_date:
        meta_by_date[d] = {"spend": 0, "roas_sum": 0, "roas_count": 0, "impressions": 0}
    meta_by_date[d]["spend"] += r["spend_inr"]
    meta_by_date[d]["roas_sum"] += r["roas"]
    meta_by_date[d]["roas_count"] += 1
    meta_by_date[d]["impressions"] += r["impressions"]

for d, m in meta_by_date.items():
    avg_roas = m["roas_sum"] / m["roas_count"] if m["roas_count"] > 0 else 0
    supabase_rows.append({"brand_id": BRAND_ID, "date": d, "source": "meta", "metric_key": "spend", "metric_value": round(m["spend"], 2)})
    supabase_rows.append({"brand_id": BRAND_ID, "date": d, "source": "meta", "metric_key": "roas", "metric_value": round(avg_roas, 2)})
    supabase_rows.append({"brand_id": BRAND_ID, "date": d, "source": "meta", "metric_key": "impressions", "metric_value": m["impressions"]})

# ── 6. SKU SUMMARY ────────────────────────────────────────────
sku_summary = {}
for o in orders:
    if o["is_returned"]: continue
    name = o["sku_name"]
    if name not in sku_summary:
        sku_summary[name] = {"revenue": 0, "units": 0, "cogs": 0, "orders": 0}
    sku_summary[name]["revenue"] += o["net_revenue_inr"]
    sku_summary[name]["units"] += o["quantity"]
    sku_summary[name]["cogs"] += o["cogs_inr"] * o["quantity"]
    sku_summary[name]["orders"] += 1

# ── 7. WRITE FILES ─────────────────────────────────────────────
out = Path("sample-data")
out.mkdir(exist_ok=True)

# Orders CSV
with open(out / "orders.csv", "w", newline="") as f:
    if orders:
        w = csv.DictWriter(f, fieldnames=orders[0].keys())
        w.writeheader()
        w.writerows(orders)
print(f"  ✓ orders.csv ({len(orders)} rows)")

# Meta Ads CSV
with open(out / "meta_ads_daily.csv", "w", newline="") as f:
    if meta_daily:
        w = csv.DictWriter(f, fieldnames=meta_daily[0].keys())
        w.writeheader()
        w.writerows(meta_daily)
print(f"  ✓ meta_ads_daily.csv ({len(meta_daily)} rows)")

# Tally P&L CSV
with open(out / "tally_pl.csv", "w", newline="") as f:
    if tally_data:
        w = csv.DictWriter(f, fieldnames=tally_data[0].keys())
        w.writeheader()
        w.writerows(tally_data)
print(f"  ✓ tally_pl.csv ({len(tally_data)} rows)")

# Supabase metrics JSON (ready to insert)
with open(out / "metrics_daily_seed.json", "w") as f:
    json.dump(supabase_rows, f, indent=2, default=str)
print(f"  ✓ metrics_daily_seed.json ({len(supabase_rows)} rows)")

# SKU summary JSON
sku_list = []
for name, s in sku_summary.items():
    gross_margin = (s["revenue"] - s["cogs"]) / s["revenue"] * 100 if s["revenue"] > 0 else 0
    sku_list.append({
        "sku_name": name,
        "total_revenue_inr": round(s["revenue"]),
        "units_sold": s["units"],
        "total_orders": s["orders"],
        "total_cogs_inr": round(s["cogs"]),
        "gross_margin_pct": round(gross_margin, 1),
    })
sku_list.sort(key=lambda x: x["total_revenue_inr"], reverse=True)
with open(out / "sku_summary.json", "w") as f:
    json.dump(sku_list, f, indent=2)
print(f"  ✓ sku_summary.json ({len(sku_list)} SKUs)")

# Brand seed JSON (for brands + brand_context tables)
brand_seed = {
    "brand": {
        "id": BRAND_ID,
        "name": BRAND_NAME,
        "founder_name": FOUNDER,
        "founder_phone": PHONE,
        "founder_email": "arun@wellnestindia.com",
        "plan": "growth",
        "plan_status": "active",
        "mrr_inr": 9999,
    },
    "brand_context": {
        "brand_id": BRAND_ID,
        "key_skus": [s["sku_name"] for s in sku_list[:3]],
        "target_roas": 3.5,
        "monthly_ad_budget_inr": 320000,
        "competitors": ["HealthKart", "MuscleBlaze", "Oziva"],
        "primary_channels": ["shopify", "meta", "google"],
        "business_notes": "Strong Diwali and Valentine's seasonality. COD is 48% of orders. Main RTO problem in tier-2 cities.",
        "cash_in_bank_inr": cash_in_bank,
    }
}
with open(out / "brand_seed.json", "w") as f:
    json.dump(brand_seed, f, indent=2)
print(f"  ✓ brand_seed.json")

# Summary stats
print("\n" + "="*50)
print("SAMPLE BRAND SUMMARY — WellNest India")
print("="*50)
total_rev = sum(s["revenue"] for s in shopify_daily.values())
total_net = sum(s["net_revenue"] for s in shopify_daily.values())
total_orders = sum(s["orders"] for s in shopify_daily.values())
total_returns = sum(s["returns"] for s in shopify_daily.values())
total_meta_spend = sum(r["spend_inr"] for r in meta_daily)
avg_roas = total_net / total_meta_spend if total_meta_spend > 0 else 0

print(f"Period: 90 days")
print(f"Total gross revenue: ₹{total_rev:,.0f}")
print(f"Total net revenue (post-returns): ₹{total_net:,.0f}")
print(f"Total orders: {total_orders:,}")
print(f"Total returns: {total_returns:,} ({total_returns/total_orders*100:.1f}% RTO)")
print(f"Total Meta ad spend: ₹{total_meta_spend:,.0f}")
print(f"Blended ROAS: {avg_roas:.2f}x")
print(f"Cash in bank: ₹{cash_in_bank:,.0f}")
print(f"\nTop SKU: {sku_list[0]['sku_name']} — ₹{sku_list[0]['total_revenue_inr']:,} revenue, {sku_list[0]['gross_margin_pct']}% gross margin")
print("\nFiles written to sample-data/")
