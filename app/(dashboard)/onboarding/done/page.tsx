import Link from 'next/link';
import { redirect } from 'next/navigation';
import { createClient } from '@/lib/supabase/server';
import { createServiceClient } from '@/lib/supabase/service';
import { generateMorningBrief } from '@/lib/ai/brief-generator';
import { Button } from '@/components/ui/button';
import { CheckCircle, ArrowRight } from 'lucide-react';

export default async function DonePage() {
  const supabase = createClient();
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect('/login');

  const serviceClient = createServiceClient();
  const { data: brand } = await serviceClient
    .from('brands')
    .select('id, name, founder_name')
    .eq('founder_email', user.email)
    .single();

  if (!brand) redirect('/onboarding/brand');

  // Generate a brief preview — gracefully fall back if data isn't ready
  let briefPreview: string | null = null;
  try {
    briefPreview = await generateMorningBrief(brand.id);
  } catch {
    briefPreview = null;
  }

  const firstName = brand.founder_name?.split(' ')[0] ?? 'there';

  return (
    <div className="text-center">
      <div className="flex justify-center mb-6">
        <CheckCircle className="w-16 h-16 text-emerald-400" />
      </div>

      <h1 className="text-2xl font-bold mb-2">You&apos;re all set, {firstName}!</h1>
      <p className="text-zinc-400 text-sm mb-10">
        Brain is now learning your business. Ask it anything.
      </p>

      {/* Brief preview */}
      <div className="bg-zinc-800 border border-zinc-700 rounded-2xl p-5 mb-8 text-left">
        <p className="text-xs text-zinc-500 font-medium uppercase tracking-wide mb-3">
          Your morning brief will look like this
        </p>
        {briefPreview ? (
          <p className="text-sm text-zinc-200 whitespace-pre-line leading-relaxed">
            {briefPreview}
          </p>
        ) : (
          <div className="space-y-2">
            <p className="text-sm text-zinc-200">Good morning {firstName}! 🧠</p>
            <p className="text-sm text-zinc-200">📊 Connect Shopify to see your revenue here</p>
            <p className="text-sm text-zinc-400">⚡ Connect Meta Ads to see your ROAS</p>
            <p className="text-sm text-zinc-500">Reply with any question.</p>
          </div>
        )}
      </div>

      {/* What's next */}
      <div className="bg-zinc-900 border border-zinc-700 rounded-xl p-4 mb-8 text-left space-y-2">
        <p className="text-xs font-medium text-zinc-400 uppercase tracking-wide mb-3">What happens next</p>
        {[
          'Your data syncs every 4 hours automatically',
          'You\'ll get a WhatsApp brief at 8am IST (Growth/Scale plans)',
          'Ask Brain anything in the chat — it knows your numbers',
          'Alerts fire automatically when ROAS drops or RTO spikes',
        ].map((item, i) => (
          <div key={i} className="flex items-start gap-2 text-sm text-zinc-300">
            <span className="text-indigo-400 mt-0.5 shrink-0">✓</span>
            {item}
          </div>
        ))}
      </div>

      <Link href="/chat">
        <Button className="w-full bg-indigo-600 hover:bg-indigo-500 text-white py-3 text-base">
          Go to Dashboard <ArrowRight className="w-4 h-4 ml-2" />
        </Button>
      </Link>
    </div>
  );
}
