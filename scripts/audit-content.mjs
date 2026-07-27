/**
 * 콘텐츠 상태 점검 — 지문당 문제 수, 유형 분포, 무결성(보기 4개·정답 키·해설 인코딩),
 * 주어·동사 문장 좌표 검증. 콘텐츠 작업 후 항상 이걸로 확인한다.
 *
 * 실행: node scripts/audit-content.mjs
 */
import { loadEnv, supa, isMojibake } from "./lib/seed-questions.mjs";

const db = supa(loadEnv(process.cwd()));

const passages = await db.select("te_passages?select=id,title,body&limit=200");
const paragraphs = await db.select("te_paragraphs?select=passage_id,body&limit=2000");
const questions = await db.select(
  "te_questions?select=id,passage_id,topic,prompt,choices,correct_answer,explanation&limit=5000",
);
const sv = await db.select("te_sv_drill_sentences?select=*&limit=3000");
const chunks = await db.select("te_chunk_sentences?select=paragraph_id&limit=5000");
const structQ = await db.select("te_structure_questions?select=paragraph_id&limit=5000");

const count = (rows, key) =>
  rows.reduce((m, r) => m.set(r[key], (m.get(r[key]) ?? 0) + 1), new Map());

// ── 유형 문제 ────────────────────────────────────────────────────────────────
const qByPassage = count(questions, "passage_id");
const dist = {};
for (const p of passages) {
  const n = qByPassage.get(p.id) ?? 0;
  dist[n] = (dist[n] ?? 0) + 1;
}
console.log(`문제 ${questions.length}개 · 지문 ${passages.length}개`);
console.log("  지문당 문제 수 분포(문제수:지문수):", dist);
console.log("  유형별:", Object.fromEntries(count(questions, "topic")));

const badQ = questions.filter((q) => {
  const keys = (q.choices ?? []).map((c) => String(c.key));
  return (
    keys.length !== 4 ||
    new Set(keys).size !== 4 ||
    !keys.includes(String(q.correct_answer)) ||
    !q.explanation ||
    isMojibake(q.explanation) ||
    isMojibake(q.prompt)
  );
});
console.log(`  무결성 이상: ${badQ.length}${badQ.length ? " → " + badQ.slice(0, 3).map((q) => q.id).join(", ") : ""}`);

// ── 주어·동사 ────────────────────────────────────────────────────────────────
const svByPassage = count(sv, "passage_id");
const svDist = {};
for (const p of passages) {
  const n = svByPassage.get(p.id) ?? 0;
  svDist[n] = (svDist[n] ?? 0) + 1;
}
let svBad = 0;
for (const s of sv) {
  const t = s.tokens ?? [];
  const ok =
    s.subject_start >= 0 &&
    s.subject_end < t.length &&
    s.verb_start >= 0 &&
    s.verb_end < t.length &&
    s.subject_end < s.verb_start &&
    t.join(" ") === String(s.full_sentence).replace(/\s+/g, " ").trim();
  if (!ok) svBad++;
}
console.log(`\n주어·동사 문장 ${sv.length}개`);
console.log("  지문당 분포(문장수:지문수):", svDist);
console.log(`  좌표/토큰 이상: ${svBad}`);

// ── 나머지 ───────────────────────────────────────────────────────────────────
console.log(
  `\n직독직해 문장 ${chunks.length}개 (단락 ${paragraphs.length}개 중 ${new Set(chunks.map((c) => c.paragraph_id)).size}개 커버)`,
);
console.log(`문장 구조 문제 ${structQ.length}개`);
