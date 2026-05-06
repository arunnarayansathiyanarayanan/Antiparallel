'use client';

import { useState, useEffect } from 'react';

const DEMOS = [
  {
    q: 'Why did sales drop last Tuesday?',
    a: 'Three causes: Meta creative fatigued (60% of drop), Buy Box lost on 3 SKUs (30%), Shiprocket SLA breach in Delhi (10%).\n\n→ Refresh top-3 Meta creatives today. Reprice those SKUs.',
  },
  {
    q: 'Which SKU should I scale on Meta?',
    a: 'Collagen Gummies 30pc — ROAS 4.8x, 12% repeat rate, RTO only 6%. Increase budget ₹50K/day and test UGC creative.',
  },
  {
    q: 'How much cash do I have for Diwali inventory?',
    a: 'Cash ₹24.3L, monthly ad spend ₹8.2L, Diwali inventory needed ~₹40L. You\'re short ₹15.7L.\n\n→ Cut Sept ad spend 30% or take a 90-day CC loan.',
  },
];

export function DemoChat() {
  const [idx, setIdx] = useState(0);
  const [typedQ, setTypedQ] = useState('');
  const [typedA, setTypedA] = useState('');
  const [phase, setPhase] = useState<'q' | 'pause' | 'a' | 'wait'>('q');

  const demo = DEMOS[idx];

  useEffect(() => {
    let timer: ReturnType<typeof setTimeout>;

    if (phase === 'q') {
      if (typedQ.length < demo.q.length) {
        timer = setTimeout(() => setTypedQ(demo.q.slice(0, typedQ.length + 1)), 45);
      } else {
        timer = setTimeout(() => setPhase('pause'), 600);
      }
    }

    if (phase === 'pause') {
      timer = setTimeout(() => setPhase('a'), 200);
    }

    if (phase === 'a') {
      if (typedA.length < demo.a.length) {
        timer = setTimeout(() => setTypedA(demo.a.slice(0, typedA.length + 1)), 18);
      } else {
        timer = setTimeout(() => setPhase('wait'), 3200);
      }
    }

    if (phase === 'wait') {
      setTypedQ('');
      setTypedA('');
      setIdx(i => (i + 1) % DEMOS.length);
      setPhase('q');
    }

    return () => clearTimeout(timer);
  }, [phase, typedQ, typedA, demo]);

  return (
    <div className="bg-zinc-900 border border-zinc-700 rounded-2xl p-5 space-y-4 font-mono text-sm shadow-2xl">
      {/* User message */}
      <div className="flex justify-end">
        <div className="bg-indigo-600 text-white rounded-2xl rounded-br-sm px-4 py-2.5 max-w-xs">
          {typedQ}
          {phase === 'q' && <span className="animate-pulse">▋</span>}
        </div>
      </div>

      {/* AI response */}
      {(phase === 'a' || phase === 'wait') && (
        <div className="flex justify-start">
          <div className="bg-zinc-800 text-zinc-100 rounded-2xl rounded-bl-sm px-4 py-2.5 max-w-sm whitespace-pre-line leading-relaxed">
            {typedA}
            {phase === 'a' && <span className="animate-pulse">▋</span>}
          </div>
        </div>
      )}

      {/* Analysing indicator */}
      {phase === 'pause' && (
        <div className="flex justify-start">
          <div className="bg-zinc-800 text-zinc-400 rounded-2xl rounded-bl-sm px-4 py-2.5 text-xs flex items-center gap-2">
            <span className="flex gap-1">
              {[0, 1, 2].map(i => (
                <span
                  key={i}
                  className="w-1.5 h-1.5 rounded-full bg-indigo-400 animate-bounce"
                  style={{ animationDelay: `${i * 150}ms` }}
                />
              ))}
            </span>
            Analysing your data…
          </div>
        </div>
      )}

      {/* Demo counter */}
      <div className="flex justify-center gap-1.5 pt-1">
        {DEMOS.map((_, i) => (
          <div
            key={i}
            className={`w-1.5 h-1.5 rounded-full transition-colors ${i === idx ? 'bg-indigo-400' : 'bg-zinc-600'}`}
          />
        ))}
      </div>
    </div>
  );
}

export function PricingToggle() {
  return null; // billing is monthly only for MVP
}
