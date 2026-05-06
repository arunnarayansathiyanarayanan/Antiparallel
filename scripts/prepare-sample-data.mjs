import fs from 'node:fs';
import path from 'node:path';

const ROOT = process.cwd();
const INPUT_DIR = path.join(ROOT, 'Sample Data');
const OUTPUT_DIR = path.join(ROOT, 'sample-data');
const BRAND_ID = '9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1';
const STARTING_CASH = 1840000;

function ensureDir(dir) {
  if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
}

function readJson(filePath) {
  return JSON.parse(fs.readFileSync(filePath, 'utf-8'));
}

function writeJson(filePath, value) {
  fs.writeFileSync(filePath, JSON.stringify(value, null, 2));
}

function parseCsv(filePath) {
  const content = fs.readFileSync(filePath, 'utf-8').trim();
  const lines = content.split('\n');
  const header = lines[0].split(',');
  const rows = lines.slice(1).map(line => {
    const cols = line.split(',');
    const row = {};
    for (let i = 0; i < header.length; i++) row[header[i]] = cols[i];
    return row;
  });
  return { header, rows };
}

function writeCsv(filePath, header, rows) {
  const lines = [header.join(',')];
  for (const row of rows) {
    lines.push(header.map(col => row[col] ?? '').join(','));
  }
  fs.writeFileSync(filePath, `${lines.join('\n')}\n`);
}

function toNumber(v) {
  const n = Number(v);
  return Number.isFinite(n) ? n : 0;
}

function escSql(text) {
  return String(text).replaceAll("'", "''");
}

function main() {
  ensureDir(OUTPUT_DIR);

  const brandSeed = readJson(path.join(INPUT_DIR, 'brand_seed.json'));
  brandSeed.brand.id = BRAND_ID;
  brandSeed.brand_context.brand_id = BRAND_ID;
  delete brandSeed.brand_context.cash_in_bank_inr;
  writeJson(path.join(OUTPUT_DIR, 'brand_seed.json'), brandSeed);

  const metrics = readJson(path.join(INPUT_DIR, 'metrics_daily_seed.json'));
  for (const row of metrics) {
    row.brand_id = BRAND_ID;
  }

  const { header: metaHeader, rows: metaRows } = parseCsv(path.join(INPUT_DIR, 'meta_ads_daily.csv'));
  for (const row of metaRows) row.brand_id = BRAND_ID;
  writeCsv(path.join(OUTPUT_DIR, 'meta_ads_daily.csv'), metaHeader, metaRows);

  const metaByDate = new Map();
  for (const row of metaRows) {
    const date = row.date;
    const spend = toNumber(row.spend_inr);
    const revenue = toNumber(row.revenue_attributed_inr);
    const entry = metaByDate.get(date) ?? { spend: 0, revenue: 0 };
    entry.spend += spend;
    entry.revenue += revenue;
    metaByDate.set(date, entry);
  }

  const existing = new Set(metrics.map(m => `${m.date}|${m.source}|${m.metric_key}`));
  for (const [date, entry] of metaByDate.entries()) {
    const key = `${date}|meta|revenue`;
    if (!existing.has(key)) {
      metrics.push({
        brand_id: BRAND_ID,
        date,
        source: 'meta',
        metric_key: 'revenue',
        metric_value: Number(entry.revenue.toFixed(2)),
      });
    }
  }

  const { header: tallyHeader, rows: tallyRows } = parseCsv(path.join(INPUT_DIR, 'tally_pl.csv'));
  let cashBalance = STARTING_CASH;
  const tallyWithCash = tallyRows.map(row => {
    cashBalance += toNumber(row.ebitda);
    return { ...row, cash_balance: cashBalance.toFixed(2) };
  });
  writeCsv(path.join(OUTPUT_DIR, 'tally_pl.csv'), [...tallyHeader, 'cash_balance'], tallyWithCash);

  for (const row of tallyWithCash) {
    metrics.push({
      brand_id: BRAND_ID,
      date: row.date,
      source: 'tally_csv',
      metric_key: 'cash_position',
      metric_value: Number(toNumber(row.cash_balance).toFixed(2)),
    });
  }

  writeJson(path.join(OUTPUT_DIR, 'metrics_daily_seed.json'), metrics);

  const ordersCsv = fs.readFileSync(path.join(INPUT_DIR, 'orders.csv'), 'utf-8').replaceAll('demo-brand-wellnest-001', BRAND_ID);
  fs.writeFileSync(path.join(OUTPUT_DIR, 'orders.csv'), ordersCsv);
  fs.copyFileSync(path.join(INPUT_DIR, 'sku_summary.json'), path.join(OUTPUT_DIR, 'sku_summary.json'));

  const brand = brandSeed.brand;
  const ctx = brandSeed.brand_context;
  const keySkus = `{${ctx.key_skus.map(s => `"${escSql(s)}"`).join(',')}}`;
  const competitors = `{${ctx.competitors.map(s => `"${escSql(s)}"`).join(',')}}`;
  const channels = `{${ctx.primary_channels.map(s => `"${escSql(s)}"`).join(',')}}`;

  const sql = [];
  sql.push('-- Auto-generated sample seed SQL for Brain MVP');
  sql.push('begin;');
  sql.push(
    `insert into brands (id, name, founder_name, founder_phone, founder_email, plan, plan_status, mrr_inr)
values ('${brand.id}', '${escSql(brand.name)}', '${escSql(brand.founder_name)}', '${brand.founder_phone}', '${brand.founder_email}', '${brand.plan}', '${brand.plan_status}', ${brand.mrr_inr})
on conflict (id) do update set
  name = excluded.name,
  founder_name = excluded.founder_name,
  founder_phone = excluded.founder_phone,
  founder_email = excluded.founder_email,
  plan = excluded.plan,
  plan_status = excluded.plan_status,
  mrr_inr = excluded.mrr_inr;`
  );
  sql.push(
    `insert into brand_context (brand_id, key_skus, target_roas, monthly_ad_budget_inr, competitors, primary_channels, business_notes)
values ('${ctx.brand_id}', '${keySkus}', ${ctx.target_roas}, ${ctx.monthly_ad_budget_inr}, '${competitors}', '${channels}', '${escSql(ctx.business_notes)}')
on conflict (brand_id) do update set
  key_skus = excluded.key_skus,
  target_roas = excluded.target_roas,
  monthly_ad_budget_inr = excluded.monthly_ad_budget_inr,
  competitors = excluded.competitors,
  primary_channels = excluded.primary_channels,
  business_notes = excluded.business_notes;`
  );
  for (const row of metrics) {
    sql.push(
      `insert into metrics_daily (brand_id, date, source, metric_key, metric_value)
values ('${row.brand_id}', '${row.date}', '${row.source}', '${row.metric_key}', ${row.metric_value})
on conflict (brand_id, date, source, metric_key) do update set
  metric_value = excluded.metric_value;`
    );
  }
  sql.push('commit;');
  fs.writeFileSync(path.join(OUTPUT_DIR, 'seed.sql'), `${sql.join('\n')}\n`);

  console.log(`Prepared sample data in ${OUTPUT_DIR}`);
  console.log(`Brand UUID: ${BRAND_ID}`);
  console.log(`Rows in metrics_daily_seed.json: ${metrics.length}`);
}

main();
