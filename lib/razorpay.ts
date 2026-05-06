import Razorpay from 'razorpay';

// Razorpay plan IDs — create plans in Razorpay dashboard and set these env vars
export const PLAN_IDS: Record<string, string> = {
  starter: process.env.RAZORPAY_PLAN_ID_STARTER ?? '',
  growth: process.env.RAZORPAY_PLAN_ID_GROWTH ?? '',
  scale: process.env.RAZORPAY_PLAN_ID_SCALE ?? '',
};

function getClient() {
  return new Razorpay({
    key_id: process.env.RAZORPAY_KEY_ID!,
    key_secret: process.env.RAZORPAY_KEY_SECRET!,
  });
}

export async function createSubscription(brandId: string, planId: string): Promise<string> {
  const client = getClient();
  const sub = await client.subscriptions.create({
    plan_id: planId,
    customer_notify: 1,
    total_count: 12, // 12 billing cycles (monthly)
    notes: { brand_id: brandId },
  });
  return sub.id as string;
}

export async function cancelSubscription(subscriptionId: string): Promise<void> {
  const client = getClient();
  await client.subscriptions.cancel(subscriptionId, false);
}
