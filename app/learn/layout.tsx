import Link from "next/link";
import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";

export default async function LearnLayout({ children }: { children: React.ReactNode }) {
  const supabase = createClient();
  const { data: userResp } = await supabase.auth.getUser();
  if (!userResp.user) redirect("/login");

  const { data: profile } = await supabase
    .from("te_profiles")
    .select("display_name, role, org_id, grade_level")
    .eq("id", userResp.user.id)
    .maybeSingle();

  return (
    <div className="min-h-screen">
      <header className="border-b bg-white">
        <div className="max-w-5xl mx-auto px-6 py-4 flex items-center justify-between">
          <div className="flex items-center gap-6">
            <Link href="/learn/passages" className="font-bold text-lg">
              Thinking <span className="text-brand-600">English</span>
            </Link>
            <nav className="flex gap-4 text-sm text-gray-600">
              <Link href="/learn/passages" className="hover:text-gray-900">
                지문 학습
              </Link>
              <Link href="/learn/quiz" className="hover:text-gray-900">
                10문제 컷팅
              </Link>
            </nav>
          </div>
          <div className="flex items-center gap-4 text-sm">
            <span className="text-gray-600">
              {profile?.display_name ?? "학생"}
              {profile?.grade_level
                ? ` · ${profile.grade_level <= 9 ? `중${profile.grade_level - 6}` : `고${profile.grade_level - 9}`}`
                : ""}
              {profile?.org_id ? " · 학원생" : " · 개인"}
            </span>
            <form action="/api/logout" method="post">
              <button className="text-gray-500 hover:text-gray-900">로그아웃</button>
            </form>
          </div>
        </div>
      </header>
      <main className="max-w-5xl mx-auto px-6 py-8">{children}</main>
    </div>
  );
}
