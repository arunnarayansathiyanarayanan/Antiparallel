import { type ReactNode } from 'react';

const STEPS = [
  { n: 1, label: 'Your Brand' },
  { n: 2, label: 'Connect Data' },
  { n: 3, label: 'Done' },
];

interface Props {
  children: ReactNode;
  // Step is derived from the segment path on the server
}

export default function OnboardingLayout({ children }: Props) {
  return (
    <div className="min-h-screen bg-zinc-950 text-zinc-100 flex flex-col">
      {/* Header */}
      <header className="px-6 py-4 border-b border-zinc-800">
        <div className="max-w-lg mx-auto flex items-center gap-2">
          <div className="w-7 h-7 rounded-full bg-indigo-600 flex items-center justify-center text-xs font-bold">
            B
          </div>
          <span className="font-semibold text-sm">Brain</span>
        </div>
      </header>

      {/* Progress bar */}
      <div className="px-6 pt-8 pb-2">
        <div className="max-w-lg mx-auto">
          <div className="flex items-center gap-0">
            {STEPS.map((step, i) => (
              <div key={step.n} className="flex items-center flex-1">
                <StepDot number={step.n} label={step.label} />
                {i < STEPS.length - 1 && (
                  <div className="flex-1 h-px bg-zinc-700 mx-2" />
                )}
              </div>
            ))}
          </div>
        </div>
      </div>

      {/* Content */}
      <main className="flex-1 px-6 py-8">
        <div className="max-w-lg mx-auto">
          {children}
        </div>
      </main>
    </div>
  );
}

function StepDot({ number, label }: { number: number; label: string }) {
  return (
    <div className="flex flex-col items-center gap-1 shrink-0">
      <div className="w-8 h-8 rounded-full bg-zinc-800 border border-zinc-600 flex items-center justify-center text-xs font-semibold text-zinc-400">
        {number}
      </div>
      <span className="text-xs text-zinc-500 hidden sm:block">{label}</span>
    </div>
  );
}
