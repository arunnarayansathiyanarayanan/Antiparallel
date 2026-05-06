import { redirect } from 'next/navigation';
import { createClient } from '@/lib/supabase/server';
import ChatInterface from '@/components/chat/ChatInterface';
import type { Integration } from '@/types';

export default async function ChatPage() {
  const supabase = createClient();

  const { data: { user } } = await supabase.auth.getUser();
  if (!user) redirect('/login');

  const { data: brand } = await supabase
    .from('brands')
    .select('id, name')
    .eq('founder_email', user.email)
    .single();

  if (!brand) redirect('/onboarding/brand');

  const { data: integrations } = await supabase
    .from('integrations')
    .select('source, sync_status, last_synced_at')
    .eq('brand_id', brand.id);

  return (
    <ChatInterface
      brandId={brand.id}
      brandName={brand.name}
      integrations={(integrations ?? []) as Pick<Integration, 'source' | 'sync_status' | 'last_synced_at'>[]}
    />
  );
}
