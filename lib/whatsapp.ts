const GRAPH_API = 'https://graph.facebook.com/v19.0';

export async function sendWhatsAppMessage(phone: string, text: string): Promise<void> {
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

export async function sendWhatsAppTemplate(
  phone: string,
  templateName: string,
  params: string[]
): Promise<void> {
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
        type: 'template',
        template: {
          name: templateName,
          language: { code: 'en_IN' },
          components: params.length > 0
            ? [{ type: 'body', parameters: params.map(p => ({ type: 'text', text: p })) }]
            : [],
        },
      }),
    }
  );
  if (!res.ok) {
    const detail = await res.text();
    throw new Error(`WhatsApp template send failed (${res.status}): ${detail}`);
  }
}
