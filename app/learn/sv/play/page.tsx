import Link from "next/link";
import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import PlayWorkspace from "./PlayWorkspace";

type Tier = "all" | "low" | "mid" | "high" | "elite";

export default async function SvPlayPage({
  searchParams,
}: {
  searchParams?: { tier?: string; count?: string };
}) {
  const supabase = createClient();
  const { data: userResp } = await supabase.auth.getUser();
  if (!userResp.user) redirect("/login");

  const tier: Tier = (["all", "low", "mid", "high", "elite"] as Tier[]).includes(
    searchParams?.tier as Tier,
  )
    ? (searchParams!.tier as Tier)
    : "all";
  const count = Math.min(50, Math.max(5, parseInt(searchParams?.count ?? "10") || 10));

  let query = supabase
    .from("te_sv_drill_sentences")
    .select("id, full_sentence, tokens, subject_start, subject_end, verb_start, verb_end, difficulty, passage_id");
  if (tier !== "all") query = query.eq("difficulty", tier);

  // Supabase에는 ORDER BY random()을 직접 못 쓰므로 전부 가져와서 JS에서 셔플
  const { data: all } = await query.limit(200);

  if (!all || all.length === 0) {
    return (
      <div className="space-y-6">
        <Link
          href="/learn/sv"
          className="inline-flex items-center text-sm text-gray-500 hover:text-gray-900"
        >
          ← 주어·동사 찾기
        </Link>
        <div className="bg-amber-50 border border-amber-200 rounded-xl p-8 text-center space-y-2">
          <div className="text-4xl">🌱</div>
          <p className="text-gray-700 font-semibold">이 난이도에 문장이 없어요</p>
          <Link
            href="/learn/sv"
            className="inline-block mt-2 px-4 py-2 rounded-md bg-orange-500 text-white text-sm font-semibold hover:bg-orange-600"
          >
            난이도 다시 고르기
          </Link>
        </div>
      </div>
    );
  }

  // 셔플 후 count만큼 자르기
  const shuffled = [...all].sort(() => Math.random() - 0.5).slice(0, count);

  // 문장마다 어느 종류 (subject/verb)를 물을지 미리 결정 (서버에서 결정해야 새로고침 시 안 바뀜)
  const items = shuffled.map((s) => ({
    id: s.id,
    full_sentence: s.full_sentence,
    tokens: s.tokens as string[],
    subject_start: s.subject_start,
    subject_end: s.subject_end,
    verb_start: s.verb_start,
    verb_end: s.verb_end,
    kind: (Math.random() < 0.5 ? "subject" : "verb") as "subject" | "verb",
  }));

  return (
    <div className="space-y-6">
      <Link
        href="/learn/sv"
        className="inline-flex items-center text-sm text-gray-500 hover:text-gray-900"
      >
        ← 주어·동사 찾기
      </Link>
      <PlayWorkspace items={items} />
    </div>
  );
}
