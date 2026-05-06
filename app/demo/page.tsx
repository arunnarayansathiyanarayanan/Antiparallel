import ChatInterface from '@/components/chat/ChatInterface';

const DEMO_BRAND_ID = '9d5c1f5c-0ae6-4f86-9c70-8a5a2f9167f1';

const DEMO_INTEGRATIONS = [
  { source: 'shopify', sync_status: 'success', last_synced_at: new Date().toISOString() },
  { source: 'meta',    sync_status: 'success', last_synced_at: new Date().toISOString() },
  { source: 'tally_csv', sync_status: 'success', last_synced_at: new Date().toISOString() },
] as const;

export default function DemoPage() {
  return (
    <div className="relative">
      {/* Demo banner */}
      <div className="bg-indigo-600 text-white text-center text-xs py-2 px-4">
        🎯 Demo mode — showing WellNest India sample data. &nbsp;
        <a href="/signup" className="underline font-semibold hover:text-indigo-200">
          Sign up free
        </a>
        &nbsp;to connect your own brand.
      </div>
      <ChatInterface
        brandId={DEMO_BRAND_ID}
        brandName="WellNest India"
        integrations={DEMO_INTEGRATIONS}
      />
    </div>
  );
}
