import { NextRequest } from 'next/server';
import { handleIncomingWhatsApp, type WhatsAppWebhookBody } from '@/lib/whatsapp';

// ── GET: webhook verification ─────────────────────────────────────────────
export async function GET(request: NextRequest) {
  const params    = request.nextUrl.searchParams;
  const mode      = params.get('hub.mode');
  const token     = params.get('hub.verify_token');
  const challenge = params.get('hub.challenge');

  if (mode === 'subscribe' && token === process.env.WHATSAPP_VERIFY_TOKEN) {
    return new Response(challenge, { status: 200 });
  }

  return new Response('Forbidden', { status: 403 });
}

// ── POST: receive messages ────────────────────────────────────────────────
export async function POST(request: NextRequest) {
  const body = await request.json() as WhatsAppWebhookBody;

  if (body.object !== 'whatsapp_business_account') {
    return Response.json({ ok: true });
  }

  // Respond 200 immediately — Meta requires sub-5s response
  // Fire-and-forget processing
  handleIncomingWhatsApp(body).catch(err =>
    console.error('[whatsapp-webhook] processing error:', (err as Error).message)
  );

  return Response.json({ ok: true });
}
