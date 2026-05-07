'use client';

import { useState, useRef } from 'react';
import { useRouter } from 'next/navigation';
import { Button } from '@/components/ui/button';
import { CheckCircle, Loader2, Upload, ExternalLink, Eye, EyeOff } from 'lucide-react';
import {
  saveTallyCsvData,
  saveShopifyCredentials,
  saveMetaCredentials,
  type TallyCsvRow,
} from '@/app/actions/onboarding';

type Status = 'idle' | 'loading' | 'done' | 'error';

export default function ConnectPage() {
  const router = useRouter();

  // Shopify
  const [shopDomain, setShopDomain] = useState('');
  const [shopToken, setShopToken] = useState('');
  const [showShopToken, setShowShopToken] = useState(false);
  const [shopStatus, setShopStatus] = useState<Status>('idle');
  const [shopError, setShopError] = useState('');

  // Meta
  const [metaAccountId, setMetaAccountId] = useState('');
  const [metaToken, setMetaToken] = useState('');
  const [showMetaToken, setShowMetaToken] = useState(false);
  const [metaStatus, setMetaStatus] = useState<Status>('idle');
  const [metaError, setMetaError] = useState('');

  // Tally CSV
  const [csvStatus, setCsvStatus] = useState<Status>('idle');
  const [csvError, setCsvError] = useState('');
  const fileRef = useRef<HTMLInputElement>(null);

  const anyConnected = shopStatus === 'done' || metaStatus === 'done' || csvStatus === 'done';

  async function connectShopify() {
    if (!shopDomain.trim() || !shopToken.trim()) return;
    setShopStatus('loading');
    setShopError('');
    const result = await saveShopifyCredentials(shopDomain, shopToken);
    if (result?.error) {
      setShopStatus('error');
      setShopError(result.error);
    } else {
      setShopStatus('done');
    }
  }

  async function connectMeta() {
    if (!metaAccountId.trim() || !metaToken.trim()) return;
    setMetaStatus('loading');
    setMetaError('');
    const result = await saveMetaCredentials(metaAccountId, metaToken);
    if (result?.error) {
      setMetaStatus('error');
      setMetaError(result.error);
    } else {
      setMetaStatus('done');
    }
  }

  async function handleCsvUpload(e: React.ChangeEvent<HTMLInputElement>) {
    const file = e.target.files?.[0];
    if (!file) return;
    setCsvStatus('loading');
    setCsvError('');
    try {
      const text = await file.text();
      const rows = parseTallyCsv(text);
      if (rows.length === 0) {
        setCsvStatus('error');
        setCsvError('No valid rows found. Expected columns: date, cash_balance (or ebitda)');
        return;
      }
      await saveTallyCsvData(rows);
      setCsvStatus('done');
    } catch (err) {
      setCsvStatus('error');
      setCsvError((err as Error).message);
    }
  }

  return (
    <div>
      <h1 className="text-2xl font-bold mb-1">Connect your data</h1>
      <p className="text-zinc-400 text-sm mb-2">
        Brain needs your data to give accurate answers. Connect at least one source to get started.
      </p>
      <p className="text-xs text-zinc-500 mb-8">You can always add more from Settings → Sources later.</p>

      <div className="space-y-3">

        {/* ── Shopify ── */}
        <ConnectCard
          emoji="🛍️"
          title="Shopify"
          description="Revenue · Orders · RTO rate · Top SKUs"
          what="Connects your store to track daily sales, return rates, and product performance."
          connected={shopStatus === 'done'}
        >
          {shopStatus !== 'done' && (
            <div className="mt-3 space-y-3">
              <HowToGet
                steps={[
                  'Open your Shopify Admin → Settings → Apps and sales channels',
                  'Click "Develop apps" → Create an app',
                  'Under API credentials → Admin API access token → Install',
                  'Copy the token (starts with shpat_)',
                ]}
              />
              <input
                value={shopDomain}
                onChange={e => setShopDomain(e.target.value)}
                placeholder="mystore  or  mystore.myshopify.com"
                className={inputCls}
              />
              <div className="relative">
                <input
                  value={shopToken}
                  onChange={e => setShopToken(e.target.value)}
                  type={showShopToken ? 'text' : 'password'}
                  placeholder="shpat_xxxxxxxxxxxxxxxxxxxxxxxx"
                  className={inputCls + ' pr-10'}
                />
                <button
                  type="button"
                  onClick={() => setShowShopToken(v => !v)}
                  className="absolute right-3 top-1/2 -translate-y-1/2 text-zinc-500 hover:text-zinc-300"
                >
                  {showShopToken ? <EyeOff className="w-4 h-4" /> : <Eye className="w-4 h-4" />}
                </button>
              </div>
              {shopStatus === 'error' && <p className="text-red-400 text-xs">{shopError}</p>}
              <Button
                onClick={connectShopify}
                disabled={!shopDomain.trim() || !shopToken.trim() || shopStatus === 'loading'}
                className="w-full bg-indigo-600 hover:bg-indigo-500 text-white text-sm"
              >
                {shopStatus === 'loading'
                  ? <><Loader2 className="w-4 h-4 mr-2 animate-spin" /> Connecting…</>
                  : 'Connect Shopify'}
              </Button>
            </div>
          )}
        </ConnectCard>

        {/* ── Meta Ads ── */}
        <ConnectCard
          emoji="📘"
          title="Meta Ads"
          description="Ad spend · ROAS · CTR · Creative performance"
          what="Links your Facebook/Instagram ad account so Brain can track campaign performance."
          connected={metaStatus === 'done'}
        >
          {metaStatus !== 'done' && (
            <div className="mt-3 space-y-3">
              <HowToGet
                steps={[
                  'Open Meta Business Manager → Settings → System Users',
                  'Create a system user → Generate Token → select your Ad Account',
                  'Enable: ads_read, ads_management, read_insights',
                  'Copy the token and your Ad Account ID from Ads Manager',
                ]}
              />
              <input
                value={metaAccountId}
                onChange={e => setMetaAccountId(e.target.value)}
                placeholder="Ad Account ID  (e.g. 123456789)"
                className={inputCls}
              />
              <div className="relative">
                <input
                  value={metaToken}
                  onChange={e => setMetaToken(e.target.value)}
                  type={showMetaToken ? 'text' : 'password'}
                  placeholder="Access token"
                  className={inputCls + ' pr-10'}
                />
                <button
                  type="button"
                  onClick={() => setShowMetaToken(v => !v)}
                  className="absolute right-3 top-1/2 -translate-y-1/2 text-zinc-500 hover:text-zinc-300"
                >
                  {showMetaToken ? <EyeOff className="w-4 h-4" /> : <Eye className="w-4 h-4" />}
                </button>
              </div>
              {metaStatus === 'error' && <p className="text-red-400 text-xs">{metaError}</p>}
              <Button
                onClick={connectMeta}
                disabled={!metaAccountId.trim() || !metaToken.trim() || metaStatus === 'loading'}
                className="w-full bg-blue-700 hover:bg-blue-600 text-white text-sm"
              >
                {metaStatus === 'loading'
                  ? <><Loader2 className="w-4 h-4 mr-2 animate-spin" /> Connecting…</>
                  : 'Connect Meta Ads'}
              </Button>
            </div>
          )}
        </ConnectCard>

        {/* ── Tally CSV ── */}
        <ConnectCard
          emoji="📊"
          title="Tally / Zoho Books"
          description="Cash position · P&L · Runway"
          what="Upload a CSV export from Tally or Zoho with date and cash_balance columns. Unlocks cash runway analysis."
          connected={csvStatus === 'done'}
        >
          {csvStatus !== 'done' && (
            <div className="mt-3 space-y-2">
              <p className="text-xs text-zinc-500">
                CSV must have columns: <code className="bg-zinc-700 px-1 py-0.5 rounded">date</code> and{' '}
                <code className="bg-zinc-700 px-1 py-0.5 rounded">cash_balance</code> (or <code className="bg-zinc-700 px-1 py-0.5 rounded">ebitda</code>)
              </p>
              <input ref={fileRef} type="file" accept=".csv" className="hidden" onChange={handleCsvUpload} />
              <Button
                onClick={() => fileRef.current?.click()}
                disabled={csvStatus === 'loading'}
                variant="outline"
                className="w-full border-zinc-600 text-zinc-300 hover:bg-zinc-700 text-sm"
              >
                {csvStatus === 'loading'
                  ? <><Loader2 className="w-4 h-4 mr-2 animate-spin" /> Uploading…</>
                  : <><Upload className="w-4 h-4 mr-2" /> Upload CSV</>
                }
              </Button>
              {csvStatus === 'error' && <p className="text-red-400 text-xs">{csvError}</p>}
            </div>
          )}
        </ConnectCard>

        {/* ── Coming soon ── */}
        <div className="rounded-xl border border-zinc-800 bg-zinc-900/50 p-4 flex items-center gap-3 opacity-50">
          <span className="text-xl">🔍</span>
          <div>
            <p className="text-sm font-medium">Google Ads</p>
            <p className="text-xs text-zinc-500">Coming soon</p>
          </div>
        </div>

        <div className="rounded-xl border border-zinc-800 bg-zinc-900/50 p-4 flex items-center gap-3 opacity-50">
          <span className="text-xl">📦</span>
          <div>
            <p className="text-sm font-medium">Amazon India</p>
            <p className="text-xs text-zinc-500">Coming soon</p>
          </div>
        </div>
      </div>

      <div className="mt-8 space-y-3">
        <Button
          onClick={() => router.push('/onboarding/done')}
          className={`w-full py-3 text-white ${anyConnected ? 'bg-indigo-600 hover:bg-indigo-500' : 'bg-zinc-700 hover:bg-zinc-600'}`}
        >
          {anyConnected ? 'Continue →' : 'Skip for now →'}
        </Button>
        {!anyConnected && (
          <p className="text-xs text-zinc-500 text-center">
            You can connect sources later from Settings → Sources
          </p>
        )}
      </div>
    </div>
  );
}

const inputCls =
  'w-full bg-zinc-800 border border-zinc-600 rounded-lg px-3 py-2.5 text-sm text-zinc-100 placeholder:text-zinc-500 focus:outline-none focus:ring-2 focus:ring-indigo-500';

function HowToGet({ steps }: { steps: string[] }) {
  const [open, setOpen] = useState(false);
  return (
    <div className="rounded-lg border border-zinc-700 bg-zinc-900/60 overflow-hidden">
      <button
        type="button"
        onClick={() => setOpen(v => !v)}
        className="w-full flex items-center gap-2 px-3 py-2 text-xs text-zinc-400 hover:text-zinc-200 text-left"
      >
        <ExternalLink className="w-3 h-3 shrink-0" />
        <span>How to get these credentials</span>
        <span className="ml-auto">{open ? '▲' : '▼'}</span>
      </button>
      {open && (
        <ol className="px-3 pb-3 space-y-1">
          {steps.map((s, i) => (
            <li key={i} className="text-xs text-zinc-400 flex gap-2">
              <span className="text-indigo-400 shrink-0">{i + 1}.</span>
              {s}
            </li>
          ))}
        </ol>
      )}
    </div>
  );
}

function ConnectCard({ emoji, title, description, what, connected, children }: {
  emoji: string;
  title: string;
  description: string;
  what: string;
  connected: boolean;
  children?: React.ReactNode;
}) {
  return (
    <div className={`rounded-xl border p-4 transition-colors ${connected ? 'border-emerald-700 bg-emerald-950/30' : 'border-zinc-700 bg-zinc-800/50'}`}>
      <div className="flex items-start gap-3">
        <span className="text-2xl shrink-0">{emoji}</span>
        <div className="flex-1">
          <div className="flex items-center gap-2">
            <p className="font-medium text-sm">{title}</p>
            {connected && <CheckCircle className="w-4 h-4 text-emerald-400" />}
          </div>
          <p className="text-xs text-zinc-400 mt-0.5">{description}</p>
          <p className="text-xs text-zinc-500 mt-1">{what}</p>
        </div>
      </div>
      {children}
    </div>
  );
}

function parseTallyCsv(text: string): TallyCsvRow[] {
  const lines = text.trim().split('\n');
  if (lines.length < 2) return [];
  const header = lines[0].toLowerCase().split(',').map(h => h.trim().replace(/"/g, ''));
  const dateIdx = header.findIndex(h => h.includes('date'));
  const cashIdx = header.findIndex(h => h.includes('cash') || h.includes('balance'));
  const ebitdaIdx = header.findIndex(h => h.includes('ebitda'));
  if (dateIdx === -1 || (cashIdx === -1 && ebitdaIdx === -1)) return [];

  const useIdx = cashIdx !== -1 ? cashIdx : ebitdaIdx;
  const rows: TallyCsvRow[] = [];
  let running = 0;
  const isCumulative = cashIdx !== -1;

  for (let i = 1; i < lines.length; i++) {
    const cols = lines[i].split(',').map(c => c.trim().replace(/"/g, ''));
    const dateRaw = cols[dateIdx];
    const valRaw = parseFloat(cols[useIdx]?.replace(/[₹,\s]/g, '') ?? '');
    if (!dateRaw || isNaN(valRaw)) continue;

    let isoDate = dateRaw;
    const dmyMatch = dateRaw.match(/^(\d{1,2})[-/](\d{1,2})[-/](\d{4})$/);
    if (dmyMatch) isoDate = `${dmyMatch[3]}-${dmyMatch[2].padStart(2, '0')}-${dmyMatch[1].padStart(2, '0')}`;

    const cash = isCumulative ? valRaw : (running += valRaw);
    rows.push({ date: isoDate, cashBalance: cash });
  }
  return rows;
}
