import { Resend } from 'resend';

const resend = new Resend(process.env.RESEND_API_KEY);
const FROM = process.env.EMAIL_FROM ?? 'Brain <briefs@updates.brainapp.in>';

export async function sendMorningBrief(to: string, founderName: string, brief: string): Promise<void> {
  if (!process.env.RESEND_API_KEY) throw new Error('RESEND_API_KEY not set');

  const firstName = founderName?.split(' ')[0] ?? 'there';

  const { error } = await resend.emails.send({
    from: FROM,
    to,
    subject: `☀️ Your morning brief — ${new Date().toLocaleDateString('en-IN', { weekday: 'long', day: 'numeric', month: 'short' })}`,
    html: `
      <div style="font-family: -apple-system, sans-serif; max-width: 560px; margin: 0 auto; background: #09090b; color: #f4f4f5; padding: 32px 24px; border-radius: 16px;">
        <div style="display:flex; align-items:center; gap:10px; margin-bottom:24px;">
          <div style="width:32px;height:32px;background:#4f46e5;border-radius:50%;display:flex;align-items:center;justify-content:center;font-weight:700;font-size:14px;">B</div>
          <span style="font-weight:600;font-size:14px;">Brain</span>
        </div>
        <h1 style="font-size:18px;font-weight:700;margin:0 0 6px;">Good morning, ${firstName}! ☀️</h1>
        <p style="font-size:12px;color:#71717a;margin:0 0 20px;">Here's your business snapshot for today.</p>
        <div style="background:#18181b;border:1px solid #27272a;border-radius:12px;padding:20px;font-size:14px;line-height:1.7;color:#e4e4e7;white-space:pre-line;">${brief}</div>
        <p style="margin-top:20px;font-size:12px;color:#52525b;">
          Reply to this email or visit <a href="${process.env.NEXT_PUBLIC_APP_URL}/chat" style="color:#818cf8;">Brain Chat</a> to ask follow-up questions.
        </p>
        <p style="margin-top:24px;font-size:11px;color:#3f3f46;">
          You're receiving this because you're on a Growth or Scale plan.
          <a href="${process.env.NEXT_PUBLIC_APP_URL}/settings" style="color:#52525b;">Manage preferences</a>
        </p>
      </div>
    `,
  });

  if (error) throw new Error(`Email send failed: ${error.message}`);
}

export async function sendAlertEmail(to: string, founderName: string, alertMessage: string, severity: string): Promise<void> {
  if (!process.env.RESEND_API_KEY) return; // silent skip if not configured

  const emoji = severity === 'critical' ? '🚨' : severity === 'warning' ? '⚠️' : 'ℹ️';

  await resend.emails.send({
    from: FROM,
    to,
    subject: `${emoji} Brain Alert: ${alertMessage.slice(0, 60)}`,
    html: `
      <div style="font-family: -apple-system, sans-serif; max-width: 560px; margin: 0 auto; background: #09090b; color: #f4f4f5; padding: 32px 24px; border-radius: 16px;">
        <div style="display:flex; align-items:center; gap:10px; margin-bottom:24px;">
          <div style="width:32px;height:32px;background:#4f46e5;border-radius:50%;display:flex;align-items:center;justify-content:center;font-weight:700;font-size:14px;">B</div>
          <span style="font-weight:600;font-size:14px;">Brain Alert</span>
        </div>
        <div style="background:#27272a;border-left:3px solid ${severity === 'critical' ? '#ef4444' : severity === 'warning' ? '#f59e0b' : '#6366f1'};padding:16px;border-radius:8px;font-size:14px;color:#e4e4e7;">
          ${emoji} ${alertMessage}
        </div>
        <p style="margin-top:16px;font-size:13px;color:#71717a;">
          <a href="${process.env.NEXT_PUBLIC_APP_URL}/chat" style="color:#818cf8;">Open Brain Chat →</a>
        </p>
      </div>
    `,
  });
}
