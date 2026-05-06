import { NextRequest } from 'next/server';
import crypto from 'crypto';
import { z } from 'zod';
import { createServiceClient } from '@/lib/supabase/service';
import { sendWhatsAppMessage } from '@/lib/whatsapp';
import { PLAN_IDS } from '@/lib/razorpay';

function verifySignature(rawBody: string, signature: string): boolean {
  const digest = crypto
    .createHmac('sha256', process.env.RAZORPAY_WEBHOOK_SECRET!)
    .update(rawBody)
    .digest('hex');
  try {
    return crypto.timingSafeEqual(Buffer.from(digest, 'hex'), Buffer.from(signature, 'hex'));
  } catch {
    return false;
  }
}

// Reverse-lookup plan name from Razorpay plan ID
function planNameFromId(planId: string): string {
  return Object.entries(PLAN_IDS).find(([, id]) => id === planId)?.[0] ?? 'starter';
}

const payloadSchema = z.object({
  event: z.string(),
  payload: z.object({
    subscription: z.object({
      entity: z.object({
        id: z.string(),
        plan_id: z.string().optional().default(''),
        status: z.string().optional().default(''),
        notes: z.record(z.string()).optional(),
      }),
    }).optional(),
    payment: z.object({
      entity: z.object({
        amount: z.number(),
      }),
    }).optional(),
  }),
});

export async function POST(request: NextRequest) {
  try {
    const rawBody = await request.text();
    const signature = request.headers.get('x-razorpay-signature') ?? '';

    if (!verifySignature(rawBody, signature)) {
      return Response.json({ error: 'Invalid signature' }, { status: 400 });
    }

    const parsed = payloadSchema.safeParse(JSON.parse(rawBody));
    if (!parsed.success) {
      return Response.json({ error: 'Invalid webhook payload' }, { status: 400 });
    }

    const event = parsed.data;
    const supabase = createServiceClient();
    const sub = event.payload.subscription?.entity;

    if (!sub) return Response.json({ received: true });

    const brandId = sub.notes?.brand_id;
    if (!brandId) return Response.json({ received: true });

    switch (event.event) {
      case 'subscription.activated': {
        const plan = planNameFromId(sub.plan_id);
        await supabase
          .from('brands')
          .update({
            plan_status: 'active',
            plan,
            razorpay_subscription_id: sub.id,
          })
          .eq('id', brandId);
        break;
      }

      case 'subscription.charged': {
        const amountPaise = event.payload.payment?.entity.amount ?? 0;
        const mrrInr = Math.round(amountPaise / 100);
        await supabase
          .from('brands')
          .update({ mrr_inr: mrrInr })
          .eq('id', brandId);
        break;
      }

      case 'subscription.cancelled': {
        await supabase
          .from('brands')
          .update({ plan_status: 'cancelled', plan: 'trial' })
          .eq('id', brandId);
        break;
      }

      case 'subscription.halted': {
        await supabase
          .from('brands')
          .update({ plan_status: 'paused' })
          .eq('id', brandId);

        const { data: brand } = await supabase
          .from('brands')
          .select('founder_phone, founder_name')
          .eq('id', brandId)
          .single();

        if (brand?.founder_phone) {
          await sendWhatsAppMessage(
            brand.founder_phone,
            `Hi ${brand.founder_name ?? 'there'}, your Brain subscription has been paused due to a payment failure. Please update your payment method to continue: razorpay.com`
          ).catch(() => {});
        }
        break;
      }
    }

    return Response.json({ received: true });
  } catch {
    return Response.json({ error: 'Internal server error' }, { status: 500 });
  }
}
