import Link from "next/link";
import { createClient } from "@/lib/supabase/server";

interface Props {
  searchParams?: { tab?: string; added?: string };
}

export default async function LibraryPage({ searchParams }: Props) {
  const tab = searchParams?.tab === "questions" ? "questions" : "passages";

  const supabase = createClient();
  const { data: userResp } = await supabase.auth.getUser();
  const userId = userResp.user!.id;
  const { data: me } = await supabase
    .from("te_profiles")
    .select("org_id, role")
    .eq("id", userId)
    .single();

  // Fetch passages visible to this user (org + public)
  const { data: passages } = await supabase
    .from("te_passages")
    .select("id, title, source, grade_level, difficulty, org_id, created_at, te_paragraphs(count)")
    .order("created_at", { ascending: false });

  const { data: questions } = await supabase
    .from("te_questions")
    .select("id, prompt, topic, difficulty, grade_level, org_id, te_passages(title)")
    .order("created_at", { ascending: false });

  return (
    <div className="space-y-6">
      <div className="flex items-baseline justify-between">
        <div>
          <h1 className="text-3xl font-bold">콘텐츠 라이브러리</h1>
          <p className="text-gray-500 mt-1">학원 사설 콘텐츠 + 공용 콘텐츠</p>
        </div>
      </div>

      {searchParams?.added === "passage" && (
        <div className="text-sm bg-green-50 border border-green-200 text-green-800 rounded-md p-3">
          새 지문이 추가되었습니다.
        </div>
      )}
      {searchParams?.added === "question" && (
        <div className="text-sm bg-green-50 border border-green-200 text-green-800 rounded-md p-3">
          새 문제가 추가되었습니다.
        </div>
      )}

      <div className="grid grid-cols-2 gap-2 p-1 bg-gray-100 rounded-lg w-fit">
        <Link
          href="/academy/library?tab=passages"
          className={`px-4 py-2 rounded-md text-sm font-medium transition ${
            tab === "passages" ? "bg-white shadow-sm" : "text-gray-600"
          }`}
        >
          지문 ({passages?.length ?? 0})
        </Link>
        <Link
          href="/academy/library?tab=questions"
          className={`px-4 py-2 rounded-md text-sm font-medium transition ${
            tab === "questions" ? "bg-white shadow-sm" : "text-gray-600"
          }`}
        >
          문제 ({questions?.length ?? 0})
        </Link>
      </div>

      {tab === "passages" ? (
        <PassagesPanel
          passages={passages ?? []}
          myOrgId={me!.org_id}
          isDirector={me!.role === "director"}
        />
      ) : (
        <QuestionsPanel
          questions={questions ?? []}
          myOrgId={me!.org_id}
          isDirector={me!.role === "director"}
        />
      )}
    </div>
  );
}

function PassagesPanel({
  passages,
  myOrgId,
  isDirector,
}: {
  passages: any[];
  myOrgId: string | null;
  isDirector: boolean;
}) {
  return (
    <div className="space-y-3">
      <div className="flex justify-end">
        <Link
          href="/academy/library/passages/new"
          className="px-4 py-2 rounded-md bg-brand-600 text-white text-sm font-semibold hover:bg-brand-700"
        >
          + 새 지문 추가
        </Link>
      </div>

      {passages.length === 0 && (
        <p className="text-center text-gray-400 py-10">등록된 지문이 없습니다.</p>
      )}

      <div className="grid sm:grid-cols-2 gap-3">
        {passages.map((p) => (
          <div key={p.id} className="bg-white border rounded-lg p-5">
            <div className="flex items-start justify-between gap-2 mb-2">
              <h3 className="font-semibold">{p.title}</h3>
              <Scope orgId={p.org_id} myOrgId={myOrgId} />
            </div>
            <div className="text-sm text-gray-500 space-y-1">
              <p>
                {p.source && <span>{p.source} · </span>}
                {p.grade_level &&
                  (p.grade_level <= 9
                    ? `중${p.grade_level - 6}`
                    : `고${p.grade_level - 9}`)}
                {p.difficulty && ` · ${difficultyLabel(p.difficulty)}`}
              </p>
              <p className="text-xs text-gray-400">
                단락 {Array.isArray(p.te_paragraphs) ? p.te_paragraphs.length : 0}개
              </p>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}

function QuestionsPanel({
  questions,
  myOrgId,
  isDirector,
}: {
  questions: any[];
  myOrgId: string | null;
  isDirector: boolean;
}) {
  return (
    <div className="space-y-3">
      <div className="flex justify-end">
        <Link
          href="/academy/library/questions/new"
          className="px-4 py-2 rounded-md bg-brand-600 text-white text-sm font-semibold hover:bg-brand-700"
        >
          + 새 문제 추가
        </Link>
      </div>

      {questions.length === 0 && (
        <p className="text-center text-gray-400 py-10">등록된 문제가 없습니다.</p>
      )}

      <div className="space-y-2">
        {questions.map((q) => {
          const passage = Array.isArray(q.te_passages) ? q.te_passages[0] : q.te_passages;
          return (
            <div key={q.id} className="bg-white border rounded-lg p-4">
              <div className="flex items-start justify-between gap-2 mb-1">
                <span className="text-xs px-2 py-0.5 rounded-full bg-gray-100 text-gray-700 font-medium">
                  {topicLabel(q.topic)}
                </span>
                <Scope orgId={q.org_id} myOrgId={myOrgId} />
              </div>
              <p className="text-sm text-gray-700 line-clamp-2 mt-1">{q.prompt}</p>
              <p className="text-xs text-gray-400 mt-1">
                {passage?.title ?? "지문 없음"}
                {q.difficulty && ` · ${difficultyLabel(q.difficulty)}`}
                {q.grade_level &&
                  ` · ${q.grade_level <= 9 ? `중${q.grade_level - 6}` : `고${q.grade_level - 9}`}`}
              </p>
            </div>
          );
        })}
      </div>
    </div>
  );
}

function Scope({ orgId, myOrgId }: { orgId: string | null; myOrgId: string | null }) {
  if (orgId === null) {
    return (
      <span className="text-xs px-2 py-0.5 rounded-full bg-blue-100 text-blue-800">
        공용
      </span>
    );
  }
  if (orgId === myOrgId) {
    return (
      <span className="text-xs px-2 py-0.5 rounded-full bg-brand-100 text-brand-800">
        우리 학원
      </span>
    );
  }
  return null;
}

function difficultyLabel(d: string): string {
  return { low: "하", mid: "중", high: "상", elite: "극상" }[d] ?? d;
}
function topicLabel(t: string): string {
  return (
    {
      main_idea: "주제",
      blank: "빈칸",
      vocabulary: "어휘",
      grammar: "어법",
    }[t] ?? t
  );
}
