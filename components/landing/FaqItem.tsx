'use client';

import { useState } from 'react';
import { ChevronDown } from 'lucide-react';

interface Props {
  question: string;
  answer: string;
}

export function FaqItem({ question, answer }: Props) {
  const [open, setOpen] = useState(false);

  return (
    <div className="border-b border-zinc-800">
      <button
        onClick={() => setOpen(o => !o)}
        className="w-full flex items-center justify-between py-4 text-left text-zinc-200 hover:text-white transition-colors"
      >
        <span className="font-medium pr-4">{question}</span>
        <ChevronDown
          className={`w-5 h-5 text-zinc-400 shrink-0 transition-transform ${open ? 'rotate-180' : ''}`}
        />
      </button>
      {open && (
        <p className="pb-4 text-sm text-zinc-400 leading-relaxed">{answer}</p>
      )}
    </div>
  );
}
