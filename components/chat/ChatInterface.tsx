'use client';

import { useChat, type Message } from 'ai/react';
import { useRef, useEffect } from 'react';
import { Send, Loader2, Circle } from 'lucide-react';
import { Button } from '@/components/ui/button';
import type { Integration } from '@/types';

interface Props {
  brandId: string;
  brandName: string;
  integrations: Pick<Integration, 'source' | 'sync_status' | 'last_synced_at'>[];
}

const QUICK_QUESTIONS = [
  'Why did sales drop?',
  'Most profitable SKU?',
  'Cash runway?',
  'Scale which creative?',
  'Biggest risk this week?',
];

const SOURCE_LABELS: Record<string, string> = {
  shopify: 'Shopify',
  meta: 'Meta',
  google: 'Google',
  tally_csv: 'Tally',
  amazon: 'Amazon',
};

export default function ChatInterface({ brandId, brandName, integrations }: Props) {
  const bottomRef = useRef<HTMLDivElement>(null);

  const { messages, input, handleInputChange, handleSubmit, isLoading, append } = useChat({
    api: '/api/chat',
    body: { brandId },
  });

  useEffect(() => {
    bottomRef.current?.scrollIntoView({ behavior: 'smooth' });
  }, [messages]);

  const handleQuickQuestion = (question: string) => {
    append({ role: 'user', content: question });
  };

  return (
    <div className="flex flex-col h-screen bg-zinc-950 text-zinc-100">
      {/* Header */}
      <header className="flex items-center justify-between px-4 py-3 border-b border-zinc-800 bg-zinc-900">
        <div className="flex items-center gap-3">
          <div className="w-8 h-8 rounded-full bg-indigo-600 flex items-center justify-center text-sm font-bold">
            B
          </div>
          <div>
            <p className="font-semibold text-sm leading-none">{brandName}</p>
            <p className="text-xs text-zinc-400 mt-0.5">Brain AI</p>
          </div>
        </div>

        {/* Source status pills */}
        <div className="flex items-center gap-2 flex-wrap justify-end">
          {integrations.map(integration => {
            const isConnected = integration.sync_status === 'success';
            const isSyncing = integration.sync_status === 'syncing';
            return (
              <span
                key={integration.source}
                className={`inline-flex items-center gap-1 px-2 py-0.5 rounded-full text-xs font-medium ${
                  isConnected
                    ? 'bg-emerald-900/50 text-emerald-400'
                    : isSyncing
                    ? 'bg-yellow-900/50 text-yellow-400'
                    : 'bg-zinc-800 text-zinc-400'
                }`}
              >
                <Circle
                  className={`w-1.5 h-1.5 fill-current ${isSyncing ? 'animate-pulse' : ''}`}
                />
                {SOURCE_LABELS[integration.source] ?? integration.source}
                {isConnected && ' ✓'}
              </span>
            );
          })}
        </div>
      </header>

      {/* Messages */}
      <div className="flex-1 overflow-y-auto px-4 py-6 space-y-6">
        {messages.length === 0 && (
          <div className="flex flex-col items-center justify-center h-full gap-6 text-center">
            <div>
              <h2 className="text-2xl font-bold text-zinc-100">Ask your business anything</h2>
              <p className="text-zinc-400 mt-2 text-sm">
                I have full context on your revenue, ads, and operations.
              </p>
            </div>
            <div className="flex flex-wrap gap-2 justify-center max-w-lg">
              {QUICK_QUESTIONS.map(q => (
                <button
                  key={q}
                  onClick={() => handleQuickQuestion(q)}
                  className="px-3 py-2 rounded-lg bg-zinc-800 hover:bg-zinc-700 text-sm text-zinc-300 transition-colors"
                >
                  {q}
                </button>
              ))}
            </div>
          </div>
        )}

        {messages.map((m: Message) => (
          <div
            key={m.id}
            className={`flex ${m.role === 'user' ? 'justify-end' : 'justify-start'}`}
          >
            <div
              className={`max-w-[85%] md:max-w-[70%] rounded-2xl px-4 py-3 ${
                m.role === 'user'
                  ? 'bg-indigo-600 text-white rounded-br-sm'
                  : 'bg-zinc-800 text-zinc-100 rounded-bl-sm'
              }`}
            >
              {m.role === 'assistant' ? (
                <MessageContent content={m.content} />
              ) : (
                <p className="text-sm">{m.content}</p>
              )}
            </div>
          </div>
        ))}

        {isLoading && (
          <div className="flex justify-start">
            <div className="bg-zinc-800 rounded-2xl rounded-bl-sm px-4 py-3 flex items-center gap-2">
              <Loader2 className="w-4 h-4 animate-spin text-indigo-400" />
              <span className="text-sm text-zinc-400">Analysing your data...</span>
            </div>
          </div>
        )}

        <div ref={bottomRef} />
      </div>

      {/* Quick questions (shown when conversation exists) */}
      {messages.length > 0 && (
        <div className="px-4 pb-2 flex gap-2 overflow-x-auto scrollbar-none">
          {QUICK_QUESTIONS.map(q => (
            <button
              key={q}
              onClick={() => handleQuickQuestion(q)}
              className="whitespace-nowrap px-3 py-1.5 rounded-full bg-zinc-800 hover:bg-zinc-700 text-xs text-zinc-300 transition-colors shrink-0"
            >
              {q}
            </button>
          ))}
        </div>
      )}

      {/* Input */}
      <div className="px-4 pb-4 pt-2 border-t border-zinc-800 bg-zinc-900">
        <form onSubmit={handleSubmit} className="flex gap-2">
          <input
            value={input}
            onChange={handleInputChange}
            placeholder="Ask anything about your business..."
            className="flex-1 bg-zinc-800 border border-zinc-700 rounded-xl px-4 py-3 text-sm text-zinc-100 placeholder:text-zinc-500 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-transparent"
            disabled={isLoading}
          />
          <Button
            type="submit"
            disabled={isLoading || !input.trim()}
            className="bg-indigo-600 hover:bg-indigo-500 text-white rounded-xl px-4 shrink-0"
          >
            <Send className="w-4 h-4" />
          </Button>
        </form>
      </div>
    </div>
  );
}

// Safe markdown renderer — no dangerouslySetInnerHTML
function renderInline(text: string): React.ReactNode[] {
  const parts = text.split(/(\*\*[^*]+\*\*)/g);
  return parts.map((part, i) =>
    part.startsWith('**') && part.endsWith('**')
      ? <strong key={i}>{part.slice(2, -2)}</strong>
      : <span key={i}>{part}</span>
  );
}

function MessageContent({ content }: { content: string }) {
  const lines = content.split('\n');
  const elements: React.ReactNode[] = [];
  let listItems: string[] = [];

  const flushList = (key: number) => {
    if (listItems.length === 0) return;
    elements.push(
      <ul key={key} className="list-disc ml-4 space-y-0.5 my-1 text-sm">
        {listItems.map((item, i) => (
          <li key={i}>{renderInline(item)}</li>
        ))}
      </ul>
    );
    listItems = [];
  };

  lines.forEach((line, i) => {
    if (line.startsWith('- ') || line.startsWith('• ')) {
      listItems.push(line.slice(2));
    } else {
      flushList(i * 100);
      if (line.startsWith('## ')) {
        elements.push(
          <p key={i} className="font-semibold text-sm mt-2 mb-0.5 text-zinc-200">
            {line.slice(3)}
          </p>
        );
      } else if (line === '') {
        elements.push(<div key={i} className="h-2" />);
      } else {
        elements.push(
          <p key={i} className="text-sm leading-relaxed">
            {renderInline(line)}
          </p>
        );
      }
    }
  });
  flushList(lines.length * 100);

  return <div className="space-y-0.5">{elements}</div>;
}
