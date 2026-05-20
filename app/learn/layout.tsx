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

  const gradeLabel = profile?.grade_level
    ? profile.grade_level <= 9
      ? `중${profile.grade_level - 6}`
      : `고${profile.grade_level - 9}`
    : null;

  return (
    <div className="min-h-screen bg-gray-50">
      <header className="border-b bg-white sticky top-0 z-10 shadow-sm">
        <div className="max-w-6xl mx-auto px-6 py-3 flex items-center justify-between">
          <div className="flex items-center gap-8">
            <Link href="/learn/review" className="font-bold text-xl tracking-tight">
              Thinking <span className="text-brand-600">English</span>
            </Link>
            <nav className="hidden sm:flex gap-1 text-sm">
              <NavLink href="/learn/review" label="오늘의 복습" />
              <NavLink href="/learn/passages" label="지문 학습" />
              <NavLink href="/learn/quiz" label="10문제 단위" />
            </nav>
          </div>
          <div className="flex items-center gap-3 text-sm">
            <div className="hidden sm:flex items-center gap-2">
              <span className="text-gray-700 font-medium">{profile?.display_name ?? "학생"}</span>
              {gradeLabel && (
                <span className="text-xs px-2 py-0.5 rounded-full bg-gray-100 text-gray-600">
                  {gradeLabel}
                </span>
              )}
              <span className="text-xs px-2 py-0.5 rounded-full bg-brand-50 text-brand-700">
                {profile?.org_id ? "학원생" : "개인"}
              </span>
            </div>
            <form action="/api/logout" method="post">
              <button className="text-xs text-gray-500 hover:text-gray-900 px-2 py-1">로그아웃</button>
            </form>
          </div>
        </div>
        {/* 모바일 네비 */}
        <nav className="sm:hidden flex border-t bg-white">
          <MobileLink href="/learn/review" label="복습" />
          <MobileLink href="/learn/passages" label="지문" />
          <MobileLink href="/learn/quiz" label="10문제" />
        </nav>
      </header>
      <main className="max-w-6xl mx-auto px-4 sm:px-6 py-6 sm:py-8">{children}</main>
    </div>
  );
}

function NavLink({ href, label }: { href: string; label: string }) {
  return (
    <Link
      href={href}
      className="px-3 py-2 rounded-md text-gray-600 hover:text-gray-900 hover:bg-gray-100 transition"
    >
      {label}
    </Link>
  );
}

function MobileLink({ href, label }: { href: string; label: string }) {
  return (
    <Link
      href={href}
      className="flex-1 text-center py-2.5 text-sm text-gray-600 hover:bg-gray-50"
    >
      {label}
    </Link>
  );
}
