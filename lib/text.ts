/**
 * Split a paragraph into sentences with stable char offsets.
 * English-friendly: split on . ! ? followed by whitespace/end.
 */
export interface Sentence {
  index: number;
  text: string;
  start: number;
  end: number;
}

export function splitSentences(body: string): Sentence[] {
  const sentences: Sentence[] = [];
  // Match a sentence ending in . ! ? optionally followed by quotes/parens, then whitespace or end.
  const re = /[^.!?]+[.!?]+(?:["')\]]+)?(?=\s|$)/g;
  let match: RegExpExecArray | null;
  let i = 0;
  while ((match = re.exec(body)) !== null) {
    const text = match[0].trim();
    if (!text) continue;
    // Recompute start (trimming may shift)
    const rawStart = match.index;
    const start = body.indexOf(text, rawStart);
    sentences.push({
      index: i++,
      text,
      start,
      end: start + text.length,
    });
  }
  // Fallback: if regex captured nothing, return whole body as one sentence
  if (sentences.length === 0 && body.trim()) {
    sentences.push({ index: 0, text: body.trim(), start: 0, end: body.length });
  }
  return sentences;
}
