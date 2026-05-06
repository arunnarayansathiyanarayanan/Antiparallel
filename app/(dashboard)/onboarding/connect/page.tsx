'use client';

import { useState, useRef } from 'react';
import { useRouter, useSearchParams } from 'next/navigation';
import { Button } from '@/components/ui/button';
import { CheckCircle, Loader2, Upload, ExternalLink } from 'lucide-react';
import { getShopifyOAuthUrl } from '@/lib/integrations/shopify';
import { getMetaOAuthUrl } from '@/lib/integrations/meta';
import { saveTallyCsvData, type TallyCsvRow } from '@/app/actions/onboarding';

export default function ConnectPage() {
  const router = useRouter();
  const searchParams = useSearchParams();
  const connected = searchParams.get('connected');

  const [shopInput, setShopInput] = useState('');
  const [csvStatus, setCsvStatus] = useState<'idle' | 'loading' | 'done' | 'error'>('idle');
  const [csvError, setCsvError] = useState('');
  const fileRef = useRef<HTMLInputElement>(null);

  const shopifyConnected = connected === 'shopify';
  const metaConnected = connected === 'meta';

  function connectShopify() {
    const shop = shopInput.trim().replace(/^https?:\/\//, '').replace(/\/$/, '');
    if (!shop) return;
    const url = getShopifyOAuthUrl(shop);
    window.location.href = url;
  }

  function connectMeta() {
    const url = getMetaOAuthUrl();
    window.location.href = url;
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
        setCsvError('No valid rows found. Expected columns: Date, Cash Balance');
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
      <p className="text-zinc-400 text-sm mb-8">
        Brain needs your data to give accurate answers. You can always connect more later.
      </p>

      <div className="space-y-4">
        {/* Shopify */}
        <ConnectCard
          title="Shopify"
          description="Revenue, orders, AOV, RTO rate"
          emoji="🛒"
          connected={shopifyConnected}
        >
          {!shopifyConnected && (
            <div className="flex gap-2 mt-3">
              <input
                value={shopInput}
                onChange={e => setShopInput(e.target.value)}
                placeholder="mystore.myshopify.com"
                className="flex-1 bg-zinc-700 border border-zinc-600 rounded-lg px-3 py-2 text-sm text-zinc-100 placeholder:text-zinc-500 focus:outline-none focus:ring-2 focus:ring-indigo-500"
              />
              <Button
                onClick={connectShopify}
                disabled={!shopInput.trim()}
                className="bg-indigo-600 hover:bg-indigo-500 text-white text-sm"
              >
                Connect <ExternalLink className="w-3 h-3 ml-1" />
              </Button>
            </div>
          )}
        </ConnectCard>

        {/* Meta */}
        <ConnectCard
          title="Meta Ads"
          description="Ad spend, ROAS, creative performance"
          emoji="📣"
          connected={metaConnected}
        >
          {!metaConnected && (
            <Button
              onClick={connectMeta}
              className="mt-3 bg-blue-600 hover:bg-blue-500 text-white text-sm w-full"
            >
              Connect Facebook / Instagram Ads <ExternalLink className="w-3 h-3 ml-1" />
            </Button>
          )}
        </ConnectCard>

        {/* Tally CSV */}
        <ConnectCard
          title="Tally / Zoho Books"
          description="Cash position and financial data"
          emoji="📊"
          connected={csvStatus === 'done'}
        >
          {csvStatus !== 'done' && (
            <div className="mt-3">
              <p className="text-xs text-zinc-500 mb-2">
                Export a CSV from Tally/Zoho with columns: <code className="bg-zinc-700 px-1 rounded">Date</code>,{' '}
                <code className="bg-zinc-700 px-1 rounded">Cash Balance</code>
              </p>
              <input
                ref={fileRef}
                type="file"
                accept=".csv"
                className="hidden"
                onChange={handleCsvUpload}
              />
              <Button
                onClick={() => fileRef.current?.click()}
                disabled={csvStatus === 'loading'}
                variant="outline"
                className="border-zinc-600 text-zinc-300 hover:bg-zinc-700 text-sm w-full"
              >
                {csvStatus === 'loading' ? (
                  <><Loader2 className="w-4 h-4 mr-2 animate-spin" /> Uploading...</>
                ) : (
                  <><Upload className="w-4 h-4 mr-2" /> Upload CSV</>
                )}
              </Button>
              {csvStatus === 'error' && (
                <p className="text-red-400 text-xs mt-1">{csvError}</p>
              )}
            </div>
          )}
        </ConnectCard>
      </div>

      <div className="mt-8 flex flex-col gap-3">
        <Button
          onClick={() => router.push('/onboarding/done')}
          className="w-full bg-indigo-600 hover:bg-indigo-500 text-white py-3"
        >
          Continue →
        </Button>
        <button
          onClick={() => router.push('/onboarding/done')}
          className="text-sm text-zinc-500 hover:text-zinc-300 text-center"
        >
          Skip for now — connect later from Sources
        </button>
      </div>
    </div>
  );
}

function ConnectCard({
  title,
  description,
  emoji,
  connected,
  children,
}: {
  title: string;
  description: string;
  emoji: string;
  connected: boolean;
  children?: React.ReactNode;
}) {
  return (
    <div className={`rounded-xl border p-4 ${connected ? 'border-emerald-700 bg-emerald-900/20' : 'border-zinc-700 bg-zinc-800/50'}`}>
      <div className="flex items-start justify-between">
        <div className="flex items-center gap-3">
          <span className="text-2xl">{emoji}</span>
          <div>
            <p className="font-medium text-sm">{title}</p>
            <p className="text-xs text-zinc-400">{description}</p>
          </div>
        </div>
        {connected && (
          <CheckCircle className="w-5 h-5 text-emerald-400 shrink-0" />
        )}
      </div>
      {children}
    </div>
  );
}

// Parse Tally CSV export — expects headers: Date, Cash Balance
function parseTallyCsv(text: string): TallyCsvRow[] {
  const lines = text.trim().split('\n');
  if (lines.length < 2) return [];

  const header = lines[0].toLowerCase().split(',').map(h => h.trim().replace(/"/g, ''));
  const dateIdx = header.findIndex(h => h.includes('date'));
  const cashIdx = header.findIndex(h => h.includes('cash') || h.includes('balance'));

  if (dateIdx === -1 || cashIdx === -1) return [];

  const rows: TallyCsvRow[] = [];
  for (let i = 1; i < lines.length; i++) {
    const cols = lines[i].split(',').map(c => c.trim().replace(/"/g, ''));
    const dateRaw = cols[dateIdx];
    const cashRaw = parseFloat(cols[cashIdx].replace(/[₹,\s]/g, ''));

    if (!dateRaw || isNaN(cashRaw)) continue;

    // Parse common Indian date formats: DD-MM-YYYY, DD/MM/YYYY, YYYY-MM-DD
    let isoDate = dateRaw;
    const dmyMatch = dateRaw.match(/^(\d{1,2})[-/](\d{1,2})[-/](\d{4})$/);
    if (dmyMatch) {
      isoDate = `${dmyMatch[3]}-${dmyMatch[2].padStart(2, '0')}-${dmyMatch[1].padStart(2, '0')}`;
    }

    rows.push({ date: isoDate, cashBalance: cashRaw });
  }
  return rows;
}
