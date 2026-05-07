'use client';

import { useEffect, useRef, useState } from 'react';
import { useSearchParams } from 'next/navigation';
import Link from 'next/link';
import { CheckCircle, AlertCircle, Loader2, Upload, ExternalLink, RefreshCw } from 'lucide-react';

interface Integration {
  source: string;
  sync_status: string;
  last_synced_at: string | null;
  error_message: string | null;
  shop_domain: string | null;
  account_id: string | null;
}

interface PageData {
  brandId: string;
  brandName: string;
  integrations: Integration[];
}

function statusBadge(status: string) {
  if (status === 'success') return <span className="flex items-center gap-1 text-xs text-emerald-400"><CheckCircle className="w-3.5 h-3.5" /> Connected</span>;
  if (status === 'syncing') return <span className="flex items-center gap-1 text-xs text-yellow-400"><Loader2 className="w-3.5 h-3.5 animate-spin" /> Syncing…</span>;
  if (status === 'error') return <span className="flex items-center gap-1 text-xs text-red-400"><AlertCircle className="w-3.5 h-3.5" /> Error</span>;
  return <span className="text-xs text-zinc-400">Not connected</span>;
}

function timeAgo(iso: string | null) {
  if (!iso) return null;
  const diff = Math.floor((Date.now() - new Date(iso).getTime()) / 60000);
  if (diff < 1) return 'just now';
  if (diff < 60) return `${diff}m ago`;
  if (diff < 1440) return `${Math.floor(diff / 60)}h ago`;
  return `${Math.floor(diff / 1440)}d ago`;
}

export default function SourcesPage() {
  const searchParams = useSearchParams();
  const [data, setData] = useState<PageData | null>(null);
  const [loading, setLoading] = useState(true);
  const [shopInput, setShopInput] = useState('');
  const [showShopInput, setShowShopInput] = useState(false);
  const [syncingSource, setSyncingSource] = useState<string | null>(null);
  const [tallyUploading, setTallyUploading] = useState(false);
  const [toast, setToast] = useState<{ msg: string; type: 'success' | 'error' } | null>(null);
  const fileRef = useRef<HTMLInputElement>(null);

  const showToast = (msg: string, type: 'success' | 'error' = 'success') => {
    setToast({ msg, type });
    setTimeout(() => setToast(null), 4000);
  };

  const fetchData = async () => {
    const res = await fetch('/api/integrations');
    if (res.ok) setData(await res.json());
    setLoading(false);
  };

  useEffect(() => {
    fetchData();
    const connected = searchParams.get('connected');
    const error = searchParams.get('error');
    if (connected) showToast(`${connected.charAt(0).toUpperCase() + connected.slice(1)} connected successfully!`);
    if (error) showToast(error.replaceAll('_', ' '), 'error');
  }, []);

  const getIntegration = (source: string) =>
    data?.integrations.find(i => i.source === source);

  const handleShopifyConnect = () => {
    if (!shopInput.trim()) return;
    window.location.href = `/api/integrations/shopify/connect?shop=${encodeURIComponent(shopInput.trim())}`;
  };

  const handleMetaConnect = () => {
    window.location.href = '/api/integrations/meta/connect';
  };

  const handleSync = async (source: string) => {
    if (!data?.brandId) return;
    setSyncingSource(source);
    try {
      const res = await fetch(`/api/sync/${source}`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ brandId: data.brandId }),
      });
      if (res.ok) {
        showToast(`${source} sync started`);
        setTimeout(fetchData, 3000);
      } else {
        showToast('Sync failed', 'error');
      }
    } finally {
      setSyncingSource(null);
    }
  };

  const handleTallyUpload = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (!file) return;
    setTallyUploading(true);
    try {
      const form = new FormData();
      form.append('file', file);
      const res = await fetch('/api/integrations/tally/upload', { method: 'POST', body: form });
      const json = await res.json() as { ok?: boolean; rows?: number; error?: string };
      if (res.ok) {
        showToast(`Tally CSV uploaded — ${json.rows} rows imported`);
        fetchData();
      } else {
        showToast(json.error ?? 'Upload failed', 'error');
      }
    } finally {
      setTallyUploading(false);
      if (fileRef.current) fileRef.current.value = '';
    }
  };

  const connectors = [
    {
      id: 'shopify',
      name: 'Shopify',
      description: 'Orders, revenue, RTO rate, SKU performance',
      icon: '🛍️',
      action: () => setShowShopInput(v => !v),
      actionLabel: getIntegration('shopify') ? 'Reconnect' : 'Connect',
    },
    {
      id: 'meta',
      name: 'Meta Ads',
      description: 'Ad spend, ROAS, CTR, creative performance',
      icon: '📘',
      action: handleMetaConnect,
      actionLabel: getIntegration('meta') ? 'Reconnect' : 'Connect',
    },
    {
      id: 'tally_csv',
      name: 'Tally / Finance CSV',
      description: 'Cash position, P&L (upload CSV with date + cash_balance columns)',
      icon: '📊',
      action: () => fileRef.current?.click(),
      actionLabel: tallyUploading ? 'Uploading…' : getIntegration('tally_csv') ? 'Re-upload CSV' : 'Upload CSV',
    },
    {
      id: 'google',
      name: 'Google Ads',
      description: 'Search & Shopping campaigns, ROAS',
      icon: '🔍',
      action: null,
      actionLabel: 'Coming soon',
    },
    {
      id: 'amazon',
      name: 'Amazon India',
      description: 'FBA/FBM sales, Buy Box status, sponsored ads',
      icon: '📦',
      action: null,
      actionLabel: 'Coming soon',
    },
  ];

  if (loading) {
    return (
      <div className="min-h-screen bg-zinc-950 flex items-center justify-center">
        <Loader2 className="w-6 h-6 animate-spin text-zinc-400" />
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-zinc-950 text-zinc-100">
      {/* Toast */}
      {toast && (
        <div className={`fixed top-4 right-4 z-50 px-4 py-3 rounded-xl text-sm font-medium shadow-lg ${
          toast.type === 'success' ? 'bg-emerald-700 text-white' : 'bg-red-700 text-white'
        }`}>
          {toast.msg}
        </div>
      )}

      {/* Header */}
      <header className="border-b border-zinc-800 bg-zinc-900 px-6 py-4 flex items-center justify-between">
        <div>
          <p className="text-xs text-zinc-400">{data?.brandName}</p>
          <h1 className="text-lg font-semibold">Data Sources</h1>
        </div>
        <Link href="/chat" className="text-sm text-indigo-400 hover:text-indigo-300">
          → Go to Chat
        </Link>
      </header>

      <main className="max-w-3xl mx-auto px-4 py-8 space-y-4">
        <p className="text-sm text-zinc-400">
          Connect your data sources. Brain syncs automatically every 4 hours once connected.
        </p>

        {/* Shopify domain input */}
        {showShopInput && (
          <div className="rounded-xl border border-indigo-500 bg-zinc-900 p-4 flex gap-2">
            <input
              autoFocus
              type="text"
              placeholder="your-store.myshopify.com or just your-store"
              value={shopInput}
              onChange={e => setShopInput(e.target.value)}
              onKeyDown={e => e.key === 'Enter' && handleShopifyConnect()}
              className="flex-1 bg-zinc-800 border border-zinc-700 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500"
            />
            <button
              onClick={handleShopifyConnect}
              className="px-4 py-2 bg-indigo-600 hover:bg-indigo-500 rounded-lg text-sm font-semibold"
            >
              Connect
            </button>
            <button onClick={() => setShowShopInput(false)} className="px-3 py-2 text-zinc-400 hover:text-zinc-200 text-sm">
              Cancel
            </button>
          </div>
        )}

        {/* Hidden file input for Tally */}
        <input ref={fileRef} type="file" accept=".csv" className="hidden" onChange={handleTallyUpload} />

        {/* Connector cards */}
        {connectors.map(c => {
          const integration = getIntegration(c.id);
          const isSyncing = syncingSource === c.id;

          return (
            <div key={c.id} className="rounded-xl border border-zinc-800 bg-zinc-900 p-5">
              <div className="flex items-start justify-between gap-4">
                <div className="flex items-start gap-3">
                  <span className="text-2xl">{c.icon}</span>
                  <div>
                    <p className="font-semibold text-sm">{c.name}</p>
                    <p className="text-xs text-zinc-400 mt-0.5">{c.description}</p>
                    {integration && (
                      <div className="mt-2 flex items-center gap-3">
                        {statusBadge(integration.sync_status)}
                        {integration.last_synced_at && (
                          <span className="text-xs text-zinc-500">Last sync: {timeAgo(integration.last_synced_at)}</span>
                        )}
                        {integration.shop_domain && (
                          <span className="text-xs text-zinc-500">{integration.shop_domain}</span>
                        )}
                      </div>
                    )}
                    {integration?.error_message && (
                      <p className="mt-1 text-xs text-red-400">{integration.error_message}</p>
                    )}
                  </div>
                </div>

                <div className="flex items-center gap-2 shrink-0">
                  {/* Sync now button (connected sources only) */}
                  {integration?.sync_status === 'success' && c.id !== 'tally_csv' && (
                    <button
                      onClick={() => handleSync(c.id)}
                      disabled={isSyncing}
                      className="flex items-center gap-1 px-3 py-1.5 rounded-lg border border-zinc-700 text-xs text-zinc-300 hover:bg-zinc-800 disabled:opacity-50"
                    >
                      <RefreshCw className={`w-3 h-3 ${isSyncing ? 'animate-spin' : ''}`} />
                      Sync now
                    </button>
                  )}

                  {/* Connect / action button */}
                  {c.action ? (
                    <button
                      onClick={c.action}
                      disabled={tallyUploading && c.id === 'tally_csv'}
                      className="flex items-center gap-1.5 px-4 py-2 rounded-lg bg-indigo-600 hover:bg-indigo-500 text-sm font-semibold disabled:opacity-60"
                    >
                      {c.id === 'tally_csv' ? (
                        <><Upload className="w-3.5 h-3.5" /> {c.actionLabel}</>
                      ) : (
                        <><ExternalLink className="w-3.5 h-3.5" /> {c.actionLabel}</>
                      )}
                    </button>
                  ) : (
                    <span className="px-4 py-2 rounded-lg border border-zinc-700 text-sm text-zinc-500 cursor-not-allowed">
                      {c.actionLabel}
                    </span>
                  )}
                </div>
              </div>
            </div>
          );
        })}

        <p className="text-xs text-zinc-500 text-center pt-4">
          All credentials are encrypted and stored securely. Brain never stores raw passwords.
        </p>
      </main>
    </div>
  );
}
