import Link from "next/link";
import { createClient } from "@/lib/supabase/server";

export default async function PassagesPage() {
  const supabase = createClient();

  const { data: passages } = await supabase
    .from("te_passages")
    .select("id, title, source, grade_level, difficulty, te_paragraphs(count)")
    .order("grade_level", { ascending: true });

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-3xl font-bold">지문 라이브러리</h1>
        <p className="text-gray-500 mt-1">학습할 지문을 선택하세요.</p>
      </div>

      <div className="grid sm:grid-cols-2 gap-4">
        {(passages ?? []).map((p) => (
          <Link
            key={p.id}
            href={`/learn/passages/${p.id}`}
            className="border rounded-lg bg-white p-5 hover:shadow-md transition"
          >
            <div className="flex items-start justify-between gap-2 mb-2">
              <h2 className="font-semibold">{p.title}</h2>
              <DifficultyBadge tier={p.difficulty} />
            </div>
            <div className="text-sm text-gray-500 space-y-1">
              <p>
                {p.source && <span>{p.source} · </span>}
                {p.grade_level &&
                  (p.grade_level <= 9
                    ? `중${p.grade_level - 6}`
                    : `고${p.grade_level - 9}`)}
              </p>
              <p>
                단락 {Array.isArray(p.te_paragraphs) ? p.te_paragraphs.length : 0}개
              </p>
            </div>
          </Link>
        ))}

        {(!passages || passages.length === 0) && (
          <div className="col-span-full text-center py-12 text-gray-400">
            아직 등록된 지문이 없습니다.
          </div>
        )}
      </div>
    </div>
  );
}

function DifficultyBadge({ tier }: { tier: string | null }) {
  if (!tier) return null;
  const map: Record<string, string> = {
    low: "bg-green-100 text-green-800",
    mid: "bg-yellow-100 text-yellow-800",
    high: "bg-orange-100 text-orange-800",
    elite: "bg-red-100 text-red-800",
  };
  const label: Record<string, string> = {
    low: "하",
    mid: "중",
    high: "상",
    elite: "극상",
  };
  return (
    <span className={`text-xs px-2 py-0.5 rounded-full font-medium ${map[tier]}`}>
      {label[tier]}
    </span>
  );
}
