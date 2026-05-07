import Link from 'next/link';

const demoQuestions = [
  {
    q: 'Why did sales drop last Tuesday?',
    a: 'Meta creative fatigue drove 62% of the drop. Buy Box loss on 3 SKUs added 28%. Recommend rotating top 2 creatives today.',
  },
  {
    q: 'Which SKU is most profitable this week?',
    a: 'Vitamin C Serum 30ml leads with 41% contribution margin and 3.9x blended ROAS.',
  },
  {
    q: 'What is my cash runway?',
    a: 'At current spend, runway is 73 days. Cut low-ROAS campaigns to extend to 92 days.',
  },
];

const faqs = [
  'How quickly can I connect Shopify and Meta?',
  'Do I need a CA or analyst to use Brain?',
  'Can Brain send WhatsApp morning briefs?',
  'Is my data secure and isolated per brand?',
  'What happens after my 14-day trial?',
];

export default function Home() {
  return (
    <main className="min-h-screen bg-zinc-950 text-zinc-100">
      <section className="mx-auto max-w-6xl px-4 pt-20 pb-16">
        <p className="inline-block rounded-full border border-zinc-700 bg-zinc-900 px-3 py-1 text-xs text-zinc-300">
          Built for Indian D2C founders
        </p>
        <h1 className="mt-6 text-4xl font-bold leading-tight md:text-6xl">
          Ask your business anything.
          <br />
          Get an instant answer.
        </h1>
        <p className="mt-5 max-w-2xl text-zinc-400">
          Brain connects Shopify, Meta Ads, Google Ads, and finance data so you can ask one question and get a clear answer with action steps.
        </p>
        <div className="mt-8 flex flex-wrap gap-3">
          <Link
            href="/demo"
            className="rounded-xl bg-indigo-600 px-5 py-3 text-sm font-semibold text-white hover:bg-indigo-500"
          >
            Try live demo →
          </Link>
          <Link
            href="/signup"
            className="rounded-xl border border-zinc-700 bg-zinc-900 px-5 py-3 text-sm font-semibold hover:bg-zinc-800"
          >
            Start free 14-day trial
          </Link>
        </div>
      </section>

      <section className="mx-auto max-w-6xl px-4 pb-16">
        <h2 className="mb-5 text-2xl font-semibold">Live Demo Questions</h2>
        <div className="grid gap-4 md:grid-cols-3">
          {demoQuestions.map(item => (
            <article key={item.q} className="rounded-xl border border-zinc-800 bg-zinc-900 p-4">
              <p className="text-sm text-indigo-300">Q: {item.q}</p>
              <p className="mt-3 text-sm text-zinc-300">{item.a}</p>
            </article>
          ))}
        </div>
      </section>

      <section className="mx-auto max-w-6xl px-4 pb-16">
        <h2 className="mb-5 text-2xl font-semibold">Pricing</h2>
        <div className="grid gap-4 md:grid-cols-3">
          {[
            { name: 'Starter', price: '₹4,999', detail: 'Shopify + 1 ad platform' },
            { name: 'Growth', price: '₹9,999', detail: 'All platforms + WhatsApp briefs' },
            { name: 'Scale', price: '₹24,999', detail: 'Action engine + priority support' },
          ].map(plan => (
            <div key={plan.name} className="rounded-xl border border-zinc-800 bg-zinc-900 p-5">
              <p className="text-lg font-semibold">{plan.name}</p>
              <p className="mt-2 text-3xl font-bold">{plan.price}</p>
              <p className="mt-2 text-sm text-zinc-400">{plan.detail}</p>
            </div>
          ))}
        </div>
      </section>


      <section className="mx-auto max-w-6xl px-4 pb-20">
        <h2 className="mb-5 text-2xl font-semibold">FAQ</h2>
        <div className="space-y-3">
          {faqs.map(faq => (
            <details key={faq} className="rounded-xl border border-zinc-800 bg-zinc-900 p-4">
              <summary className="cursor-pointer text-sm font-medium">{faq}</summary>
              <p className="mt-2 text-sm text-zinc-400">
                Brain is designed for speed: connect sources, ask questions, and get recommendations grounded in your own numbers.
              </p>
            </details>
          ))}
        </div>
        <div className="mt-8 text-center">
          <Link
            href="/signup"
            className="rounded-xl bg-indigo-600 px-5 py-3 text-sm font-semibold text-white hover:bg-indigo-500"
          >
            Start free 14-day trial
          </Link>
        </div>
      </section>
    </main>
  );
}
