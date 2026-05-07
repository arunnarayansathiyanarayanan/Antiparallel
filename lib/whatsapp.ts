import { generateText } from 'ai';
import { anthropic } from '@ai-sdk/anthropic';
import { createServiceClient } from '@/lib/supabase/service';
import { buildBrandContext } from './ai/context-builder';
import { buildSystemPrompt } from './ai/system-prompt';

const GRAPH_API = 'https://graph.facebook.com/v19.0';
const CLAUDE_MODEL = process.env.CLAUDE_MODEL_ID ?? 'claude-sonnet-4-20250514';

function inr(n: number): string {
  if (n >= 10_000_000) return `₹${(n / 10_000_000).toFixed(1)}Cr`;
  if (n >= 100_000)    return `₹${(n / 100_000).toFixed(1)}L`;
  if (n >= 1_000)      return `₹${(n / 1_000).toFixed(0)}K`;
  return `₹${Math.round(n)}`;
}

// ── Core send ─────────────────────────────────────────────────────────────
export async function sendWhatsAppMessage(phone: string, text: string): Promise<void> {
  if (!process.env.WHATSAPP_TOKEN || !process.env.WHATSAPP_PHONE_NUMBER_ID) {
    throw new Error('WhatsApp not configured');
  }

  const res = await fetch(
    `${GRAPH_API}/${process.env.WHATSAPP_PHONE_NUMBER_ID}/messages`,
    {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        Authorization: `Bearer ${process.env.WHATSAPP_TOKEN}`,
      },
      body: JSON.stringify({
        messaging_product: 'whatsapp',
        to: phone,
        type: 'text',
        text: { body: text },
      }),
    }
  );
  if (!res.ok) {
    const detail = await res.text();
    throw new Error(`WhatsApp send failed (${res.status}): ${detail}`);
  }
}

export async function sendWhatsAppTemplate(phone: string, templateName: string, params: string[]): Promise<void> {
  if (!process.env.WHATSAPP_TOKEN || !process.env.WHATSAPP_PHONE_NUMBER_ID) return;

  await fetch(`${GRAPH_API}/${process.env.WHATSAPP_PHONE_NUMBER_ID}/messages`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${process.env.WHATSAPP_TOKEN}`,
    },
    body: JSON.stringify({
      messaging_product: 'whatsapp',
      to: phone,
      type: 'template',
      template: {
        name: templateName,
        language: { code: 'en_IN' },
        components: params.length > 0
          ? [{ type: 'body', parameters: params.map(p => ({ type: 'text', text: p })) }]
          : [],
      },
    }),
  });
}

// ── Morning brief ─────────────────────────────────────────────────────────
export async function sendMorningBrief(brandId: string): Promise<void> {
  const supabase = createServiceClient();

  const { data: brand } = await supabase
    .from('brands')
    .select('name, founder_name, founder_phone')
    .eq('id', brandId)
    .single();

  if (!brand?.founder_phone) return;

  const ctx = await buildBrandContext(brandId);
  const now = new Date();
  const dayName = now.toLocaleDateString('en-IN', { weekday: 'long' });
  const dateStr = now.toLocaleDateString('en-IN', { day: 'numeric', month: 'short' });

  // Build compact 400-char brief
  const revChange = ctx.revenuePrev7d > 0
    ? `${ctx.revenue7d >= ctx.revenuePrev7d ? '↑' : '↓'}${Math.abs((ctx.revenue7d - ctx.revenuePrev7d) / ctx.revenuePrev7d * 100).toFixed(0)}%`
    : '';

  // Yesterday revenue (last entry in revenueByDay)
  const yesterdayDate = new Date(Date.now() - 86400_000).toISOString().slice(0, 10);
  const yesterdayRev = ctx.revenueByDay[yesterdayDate] ?? 0;

  const roasStr = ctx.blendedRoas7d !== null ? `${ctx.blendedRoas7d.toFixed(1)}x` : 'N/A';

  const cashStr = ctx.cashPosition !== null
    ? inr(ctx.cashPosition) + (ctx.runwayDays !== null ? ` (${ctx.runwayDays}d runway)` : '')
    : 'N/A';

  const topAlert = ctx.recentAlerts[0];
  const alertLine = topAlert
    ? `⚠️ ${topAlert.message.slice(0, 80)}`
    : '✅ No active alerts';

  const actionHint = topAlert
    ? (topAlert.data as Record<string, unknown>)?.action_description as string | undefined
    : undefined;

  const lines = [
    `🧠 ${brand.name} — ${dayName}, ${dateStr}`,
    `📊 Yesterday: ${inr(yesterdayRev)}${revChange ? ` (${revChange} vs last wk)` : ''}`,
    `🎯 ROAS: ${roasStr} blended`,
    `💰 Cash: ${cashStr}`,
    alertLine,
    actionHint ? `${actionHint}` : '',
    'Reply with any question.',
  ].filter(Boolean).join('\n');

  // Trim to 400 chars if needed
  const brief = lines.length <= 400 ? lines : lines.slice(0, 397) + '…';

  await sendWhatsAppMessage(brand.founder_phone, brief);
}

// ── Incoming message handler ──────────────────────────────────────────────
export interface WhatsAppWebhookBody {
  object: string;
  entry: Array<{
    id: string;
    changes: Array<{
      value: {
        messaging_product: string;
        metadata: { display_phone_number: string; phone_number_id: string };
        contacts?: Array<{ profile: { name: string }; wa_id: string }>;
        messages?: Array<{
          from: string;
          id: string;
          timestamp: string;
          type: string;
          text?: { body: string };
        }>;
      };
      field: string;
    }>;
  }>;
}

export async function handleIncomingWhatsApp(body: WhatsAppWebhookBody): Promise<void> {
  const supabase = createServiceClient();

  for (const entry of body.entry ?? []) {
    for (const change of entry.changes ?? []) {
      const messages = change.value?.messages ?? [];
      for (const msg of messages) {
        if (msg.type !== 'text') continue;

        const phone     = msg.from;
        const text      = msg.text?.body?.trim() ?? '';
        const contactName = change.value.contacts?.[0]?.profile?.name ?? '';

        // Look up brand by founder_phone
        const { data: brand } = await supabase
          .from('brands')
          .select('id, name, founder_name')
          .eq('founder_phone', `+${phone.replace(/^\+/, '')}`)
          .single();

        if (!brand) continue;

        // Log to conversations
        const convMsg = { role: 'user' as const, content: text, timestamp: new Date().toISOString() };
        const { data: existing } = await supabase
          .from('conversations')
          .select('id, messages')
          .eq('brand_id', brand.id)
          .order('updated_at', { ascending: false })
          .limit(1)
          .single();

        const currentMessages = existing
          ? [...(existing.messages as Array<unknown>), convMsg]
          : [convMsg];

        if (existing) {
          await supabase
            .from('conversations')
            .update({ messages: currentMessages, updated_at: new Date().toISOString() })
            .eq('id', existing.id);
        } else {
          await supabase
            .from('conversations')
            .insert({ brand_id: brand.id, messages: currentMessages });
        }

        // Route: affirmative reply → action, anything else → AI
        const isAffirmative = /^(yes|y|1|ok|okay|sure|haan|ha)$/i.test(text);

        if (isAffirmative) {
          await handleAction(brand.id, phone);
        } else {
          await handleAiReply(brand.id, phone, text);
        }
      }
    }
  }
}

// ── Action execution ──────────────────────────────────────────────────────
async function handleAction(brandId: string, phone: string): Promise<void> {
  const supabase = createServiceClient();

  // Get most recent unresolved alert with a pending action
  const { data: alert } = await supabase
    .from('alerts')
    .select('*')
    .eq('brand_id', brandId)
    .is('resolved_at', null)
    .not('data->pending_action', 'is', null)
    .order('triggered_at', { ascending: false })
    .limit(1)
    .single();

  if (!alert) {
    await sendWhatsAppMessage(phone, '✅ No pending actions right now. Ask Brain anything about your business.');
    return;
  }

  const data = alert.data as Record<string, unknown>;
  const actionType = data.pending_action as string;
  let replyMsg = '✅ Done. ';

  try {
    if (actionType === 'pause_low_roas_campaigns' || actionType === 'pause_fatigued_campaigns') {
      const integration = await supabase
        .from('integrations')
        .select('access_token, account_id')
        .eq('brand_id', brandId)
        .eq('source', 'meta')
        .single();

      if (integration.data?.access_token && integration.data?.account_id) {
        const paused = await pauseLowRoasCampaigns(integration.data.account_id, integration.data.access_token);
        replyMsg += `Paused ${paused} Meta campaign${paused !== 1 ? 's' : ''} below 2× ROAS. `;
      } else {
        replyMsg += 'Could not pause — Meta not connected. ';
      }
    } else if (actionType === 'restrict_cod_city') {
      const city = data.action_city as string;
      await recordCodRestriction(brandId, city);
      replyMsg += `COD restriction logged for ${city}. Update your Shopify shipping zones to disable COD for ${city} orders. `;
    } else if (actionType === 'reorder_supplier') {
      const sku = data.action_sku as string;
      await triggerSupplierReorder(brandId, sku, phone);
      replyMsg += `Supplier reorder message sent for ${sku}. `;
    }

    // Mark alert resolved
    await supabase
      .from('alerts')
      .update({ resolved_at: new Date().toISOString(), notified_whatsapp: true })
      .eq('id', alert.id);

    replyMsg += 'Updating you as things change.';
    await sendWhatsAppMessage(phone, replyMsg);
  } catch (err) {
    await sendWhatsAppMessage(phone, `❌ Action failed: ${(err as Error).message.slice(0, 100)}`);
  }
}

async function pauseLowRoasCampaigns(adAccountId: string, accessToken: string): Promise<number> {
  // Fetch all active campaigns
  const res = await fetch(
    `${GRAPH_API}/act_${adAccountId}/campaigns?` +
    new URLSearchParams({
      access_token: accessToken,
      fields: 'id,name,status,insights.date_preset(last_7d){spend,purchase_roas}',
      effective_status: JSON.stringify(['ACTIVE']),
      limit: '50',
    })
  );
  if (!res.ok) throw new Error(`Meta campaigns fetch failed: ${res.status}`);
  const data = await res.json() as { data: Array<{ id: string; name: string; insights?: { data: Array<{ spend: string; purchase_roas?: Array<{ value: string }> }> } }> };

  const toPause: string[] = [];
  for (const campaign of data.data ?? []) {
    const insightRow = campaign.insights?.data?.[0];
    if (!insightRow) continue;
    const spend = parseFloat(insightRow.spend ?? '0');
    if (spend <= 0) continue;
    const roas = parseFloat(insightRow.purchase_roas?.[0]?.value ?? '0');
    if (roas < 2.0) toPause.push(campaign.id);
  }

  for (const campaignId of toPause) {
    await fetch(`${GRAPH_API}/${campaignId}`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${accessToken}` },
      body: JSON.stringify({ status: 'PAUSED' }),
    });
  }

  return toPause.length;
}

async function recordCodRestriction(brandId: string, city: string): Promise<void> {
  const supabase = createServiceClient();
  const expiresAt = new Date(Date.now() + 7 * 86400_000).toISOString().slice(0, 10);

  // Store restriction in brand_context metadata for AI awareness
  await supabase
    .from('brand_context')
    .update({
      business_notes: `COD restricted for ${city} until ${expiresAt} (founder-approved via WhatsApp).`,
      updated_at: new Date().toISOString(),
    })
    .eq('brand_id', brandId);
}

async function triggerSupplierReorder(brandId: string, sku: string, founderPhone: string): Promise<void> {
  const supabase = createServiceClient();

  const { data: ctx } = await supabase
    .from('brand_context')
    .select('business_notes')
    .eq('brand_id', brandId)
    .single();

  // Parse supplier phone from business_notes (format: "Supplier: +91XXXXXXXXXX")
  const supplierMatch = ctx?.business_notes?.match(/[Ss]upplier.*?(\+91\d{10}|\d{10})/);
  const supplierPhone = supplierMatch?.[1];

  if (supplierPhone) {
    const normalised = supplierPhone.startsWith('+91') ? supplierPhone : `+91${supplierPhone}`;
    await sendWhatsAppMessage(normalised, `📦 Reorder request from Brain: Please replenish *${sku}* for brand. Confirm quantities and delivery date. — via Brain D2C`);
  }

  // Always notify founder
  const msg = `📦 Reorder triggered for *${sku}*.${supplierPhone ? ` Supplier WhatsApp sent.` : ' Add supplier phone to Settings to auto-notify them.'}`;
  await sendWhatsAppMessage(founderPhone, msg);
}

// ── AI reply for WhatsApp ─────────────────────────────────────────────────
async function handleAiReply(brandId: string, phone: string, question: string): Promise<void> {
  if (!process.env.ANTHROPIC_API_KEY) {
    await sendWhatsAppMessage(phone, 'Brain is not configured. Contact support.');
    return;
  }

  try {
    const ctx = await buildBrandContext(brandId);
    const systemPrompt = buildSystemPrompt(ctx, 'whatsapp');

    const { text } = await generateText({
      model: anthropic(CLAUDE_MODEL),
      system: systemPrompt,
      messages: [{ role: 'user', content: question }],
      maxTokens: 300,
    });

    // Trim to WhatsApp-safe length
    const reply = text.length > 450 ? text.slice(0, 447) + '…' : text;
    await sendWhatsAppMessage(phone, reply);
  } catch (err) {
    await sendWhatsAppMessage(phone, `❌ Brain error: ${(err as Error).message.slice(0, 80)}`);
  }
}
