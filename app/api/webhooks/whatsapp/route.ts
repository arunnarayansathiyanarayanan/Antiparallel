export async function GET() {
  try {
    return new Response('Not implemented', { status: 501 });
  } catch {
    return Response.json({ error: 'Internal server error' }, { status: 500 });
  }
}

export async function POST() {
  try {
    return new Response('Not implemented', { status: 501 });
  } catch {
    return Response.json({ error: 'Internal server error' }, { status: 500 });
  }
}
