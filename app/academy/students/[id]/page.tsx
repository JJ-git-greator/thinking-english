import Link from "next/link";
import { notFound, redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { type LevelTier } from "@/lib/leveling";
import LevelEditor from "./LevelEditor";

export default async function StudentDetail({
  params,
}: {
  params: { id: string };
}) {
  const supabase = createClient();
  const { data: userResp } = await supabase.auth.getUser();
  if (!userResp.user) redirect("/login");

  const { data: me } = await supabase
    .from("te_profiles")
    .select("org_id, role")
    .eq("id", userResp.user.id)
    .single();

  const { data: student } = await supabase
    .from("te_profiles")
    .select("id, display_name, grade_level, level_tier, org_id")
    .eq("id", params.id)
    .maybeSingle();

  if (!student || student.org_id !== me!.org_id) notFound();

  const { data: progress } = await supabase
    .from("te_student_progress")
    .select("*")
    .eq("user_id", student.id)
    .maybeSingle();

  const { data: attempts } = await supabase
    .from("te_reconstruction_attempts")
    .select(
      "id, paragraph_id, ai_score, ai_subscores, ai_feedback, student_text, created_at, te_paragraphs(ord, te_passages(title))",
    )
    .eq("user_id", student.id)
    .order("created_at", { ascending: false })
    .limit(20);

  return (
    <div className="space-y-8">
      <div>
        <Link href="/academy/dashboard" className="text-sm text-gray-500 hover:text-gray-900">
          ← 대시보드
        </Link>
        <h1 className="text-3xl font-bold mt-2">{student.display_name}</h1>
        <p className="text-gray-500 mt-1">
          {student.grade_level
            ? student.grade_level <= 9
              ? `중${student.grade_level - 6}`
              : `고${student.grade_level - 9}`
            : "학년 미설정"}
          {student.level_tier ? ` · 레벨 ${student.level_tier}` : ""}
        </p>
      </div>

      <LevelEditor studentId={student.id} initial={(student.level_tier as LevelTier | null) ?? null} />

      <div className="grid grid-cols-4 gap-4">
        <StatCard label="Gist 노트" value={`${progress?.total_gist_notes ?? 0}`} />
        <StatCard label="재구성 시도" value={`${progress?.total_reconstructions ?? 0}`} />
        <StatCard
          label="평균 점수"
          value={
            progress?.avg_reconstruction_score != null
              ? `${Number(progress.avg_reconstruction_score).toFixed(1)}`
              : "—"
          }
        />
        <StatCard
          label="최근 활동"
          value={
            progress?.last_active_at
              ? new Date(progress.last_active_at).toLocaleDateString("ko-KR")
              : "—"
          }
        />
      </div>

      <section className="space-y-3">
        <h2 className="text-xl font-semibold">최근 재구성 시도</h2>

        {(!attempts || attempts.length === 0) && (
          <p className="text-gray-400 text-center py-8">아직 재구성 시도가 없습니다.</p>
        )}

        {attempts?.map((a) => {
          const para = Array.isArray(a.te_paragraphs) ? a.te_paragraphs[0] : a.te_paragraphs;
          const passage = para && (Array.isArray(para.te_passages) ? para.te_passages[0] : para.te_passages);
          const feedback = a.ai_feedback ?? ({} as any);
          return (
            <div key={a.id} className="bg-white border rounded-lg p-5 space-y-3">
              <div className="flex items-start justify-between">
                <div>
                  <div className="text-sm text-gray-500">
                    {passage?.title} · 단락 {(para?.ord ?? 0) + 1}
                  </div>
                  <div className="text-xs text-gray-400">
                    {new Date(a.created_at).toLocaleString("ko-KR")}
                  </div>
                </div>
                <div className="text-3xl font-bold text-accent-600">{a.ai_score}</div>
              </div>

              <div className="text-sm">
                <div className="text-gray-500 mb-1">학생 답안</div>
                <p className="text-gray-700 italic">{a.student_text}</p>
              </div>

              {feedback?.weaknesses?.length > 0 && (
                <div className="text-sm">
                  <div className="text-amber-700 font-medium mb-1">개선할 점</div>
                  <ul className="list-disc ml-5 text-gray-700 space-y-0.5">
                    {feedback.weaknesses.map((w: string, i: number) => (
                      <li key={i}>{w}</li>
                    ))}
                  </ul>
                </div>
              )}
            </div>
          );
        })}
      </section>
    </div>
  );
}

function StatCard({ label, value }: { label: string; value: string }) {
  return (
    <div className="bg-white border rounded-lg p-4">
      <div className="text-xs text-gray-500">{label}</div>
      <div className="text-2xl font-bold mt-1">{value}</div>
    </div>
  );
}
