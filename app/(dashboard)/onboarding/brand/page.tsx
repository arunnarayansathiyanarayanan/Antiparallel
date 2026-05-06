'use client';

import { useState } from 'react';
import { saveBrandProfile } from '@/app/actions/onboarding';
import { Button } from '@/components/ui/button';
import { Loader2 } from 'lucide-react';

export default function BrandPage() {
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState('');

  async function handleSubmit(e: React.FormEvent<HTMLFormElement>) {
    e.preventDefault();
    setSaving(true);
    setError('');

    const fd = new FormData(e.currentTarget);
    const budget = fd.get('monthlyAdBudget') as string;

    try {
      await saveBrandProfile({
        name: fd.get('name') as string,
        founderName: fd.get('founderName') as string,
        founderPhone: fd.get('founderPhone') as string,
        keySkus: fd.get('keySkus') as string,
        targetRoas: parseFloat(fd.get('targetRoas') as string) || 3.0,
        monthlyAdBudget: budget ? parseInt(budget, 10) : null,
      });
    } catch {
      setError('Something went wrong. Please try again.');
      setSaving(false);
    }
  }

  return (
    <div>
      <h1 className="text-2xl font-bold mb-1">Tell us about your brand</h1>
      <p className="text-zinc-400 text-sm mb-8">
        This helps Brain give you accurate, personalised insights.
      </p>

      <form onSubmit={handleSubmit} className="space-y-5">
        <Field label="Brand name" required>
          <input name="name" required placeholder="Glow & Co." className={inputCls} />
        </Field>

        <Field label="Your name" required>
          <input name="founderName" required placeholder="Priya Sharma" className={inputCls} />
        </Field>

        <Field label="WhatsApp number" hint="For morning briefs (Growth/Scale plans)">
          <div className="flex">
            <span className="px-3 py-2.5 bg-zinc-700 border border-zinc-600 border-r-0 rounded-l-lg text-zinc-300 text-sm">
              +91
            </span>
            <input
              name="founderPhone"
              type="tel"
              placeholder="9876543210"
              maxLength={10}
              className={`${inputCls} rounded-l-none`}
              onChange={e => {
                const el = e.currentTarget;
                if (el.value && !el.value.startsWith('+91')) {
                  el.dataset.raw = el.value;
                }
              }}
            />
          </div>
        </Field>

        <Field label="Key SKUs" hint="Comma separated — your top products">
          <input
            name="keySkus"
            placeholder="Collagen Gummies 30pc, Vitamin C Serum 30ml"
            className={inputCls}
          />
        </Field>

        <div className="grid grid-cols-2 gap-4">
          <Field label="Target ROAS" hint="Default: 3×">
            <input
              name="targetRoas"
              type="number"
              step="0.1"
              min="0"
              defaultValue="3.0"
              className={inputCls}
            />
          </Field>

          <Field label="Monthly ad budget (₹)" hint="Optional">
            <input
              name="monthlyAdBudget"
              type="number"
              min="0"
              placeholder="500000"
              className={inputCls}
            />
          </Field>
        </div>

        {error && <p className="text-red-400 text-sm">{error}</p>}

        <Button
          type="submit"
          disabled={saving}
          className="w-full bg-indigo-600 hover:bg-indigo-500 text-white py-3"
        >
          {saving ? (
            <><Loader2 className="w-4 h-4 mr-2 animate-spin" /> Saving...</>
          ) : (
            'Continue →'
          )}
        </Button>
      </form>
    </div>
  );
}

const inputCls =
  'w-full bg-zinc-800 border border-zinc-600 rounded-lg px-3 py-2.5 text-sm text-zinc-100 placeholder:text-zinc-500 focus:outline-none focus:ring-2 focus:ring-indigo-500';

function Field({
  label,
  hint,
  required,
  children,
}: {
  label: string;
  hint?: string;
  required?: boolean;
  children: React.ReactNode;
}) {
  return (
    <div className="space-y-1.5">
      <label className="block text-sm font-medium text-zinc-200">
        {label}{required && <span className="text-red-400 ml-0.5">*</span>}
      </label>
      {children}
      {hint && <p className="text-xs text-zinc-500">{hint}</p>}
    </div>
  );
}
