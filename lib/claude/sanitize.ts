/**
 * 피드백 환각 방어.
 *
 * 실제 사고: 재구성 첨삭에서 모델이 원문에 없는 영어 문장을
 * ("Stories were how knowledge moved between people") 원문인 것처럼 인용해
 * 학생이 "이런 문장 없는데요?" 하고 혼란에 빠졌다.
 * → 프롬프트로 금지하고, 코드로 한 번 더 걸러낸다. 원문에 없는 영어 인용이
 *   섞인 피드백 줄은 통째로 버린다 (지어낸 문장을 학생에게 보여주느니 없는 게 낫다).
 */

/** 비교용 정규화: 소문자 + 영숫자만 남기고 공백 하나로 */
function normalize(s: string): string {
  return s
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, " ")
    .trim();
}

const QUOTE_RE = /["“”'‘’「」『』]([^"“”「」『』\n]{6,240})["“”'‘’「」『』]/g;

/** 따옴표 안 영어 구절 중 원문에 없는 게 있으면 true */
export function hasFabricatedQuote(text: string, source: string): boolean {
  if (!text) return false;
  const normSource = normalize(source);
  QUOTE_RE.lastIndex = 0;
  let m: RegExpExecArray | null;
  while ((m = QUOTE_RE.exec(text)) !== null) {
    const quoted = m[1].trim();
    const englishWords = quoted.match(/[A-Za-z']{2,}/g) ?? [];
    // 영어 3단어 이상일 때만 "원문 인용"으로 간주 (한국어 강조 따옴표는 통과)
    if (englishWords.length < 3) continue;
    if (!normSource.includes(normalize(quoted))) return true;
  }
  return false;
}

/** 원문에 없는 영어 인용이 든 항목을 제거 */
export function dropFabricatedQuotes(items: string[], source: string): string[] {
  return items.filter((it) => !hasFabricatedQuote(it, source));
}

/**
 * 원문에 그대로 있는 문장일 때만 돌려준다 (아니면 null).
 * "더 좋은 후보 문장"처럼 원문 인용이어야만 의미가 있는 필드에 사용.
 */
export function verbatimOrNull(quote: string | undefined, source: string): string | undefined {
  if (!quote) return undefined;
  const cleaned = quote.trim().replace(/^["“”'‘’]|["“”'‘’]$/g, "");
  if (!cleaned) return undefined;
  const englishWords = cleaned.match(/[A-Za-z']{2,}/g) ?? [];
  if (englishWords.length < 3) return cleaned; // 한국어 코멘트면 그대로 통과
  return normalize(source).includes(normalize(cleaned)) ? cleaned : undefined;
}
