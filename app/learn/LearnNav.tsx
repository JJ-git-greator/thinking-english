"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";

interface Props {
  displayName: string;
  gradeLabel: string | null;
  isAcademyStudent: boolean;
}

const NAV_ITEMS = [
  { href: "/learn/review", label: "오늘의 복습", short: "복습", emoji: "🔁" },
  { href: "/learn/passages", label: "단락 깊이 읽기", short: "깊이 읽기", emoji: "📖" },
  { href: "/learn/chunks", label: "직독직해", short: "직독직해", emoji: "📝" },
  { href: "/learn/quiz", label: "유형 집중 훈련", short: "유형 훈련", emoji: "🎯" },
];

export default function LearnNav({ displayName, gradeLabel, isAcademyStudent }: Props) {
  const pathname = usePathname();

  const isActive = (href: string) => pathname.startsWith(href);

  return (
    <header className="border-b bg-white sticky top-0 z-10 shadow-sm">
      <div className="max-w-6xl mx-auto px-4 sm:px-6 py-3 flex items-center justify-between gap-4">
        <div className="flex items-center gap-8 min-w-0">
          <Link
            href="/learn/review"
            className="font-bold text-xl tracking-tight shrink-0 active:scale-95 transition"
          >
            Thinking <span className="text-brand-600">English</span>
          </Link>
          {/* 데스크탑 네비 */}
          <nav className="hidden sm:flex gap-1 text-sm">
            {NAV_ITEMS.map((item) => {
              const active = isActive(item.href);
              return (
                <Link
                  key={item.href}
                  href={item.href}
                  className={`px-3 py-2 rounded-md transition active:scale-95 ${
                    active
                      ? "bg-brand-50 text-brand-700 font-semibold"
                      : "text-gray-600 hover:text-gray-900 hover:bg-gray-100"
                  }`}
                >
                  {item.label}
                </Link>
              );
            })}
          </nav>
        </div>
        <div className="flex items-center gap-3 text-sm shrink-0">
          <div className="hidden sm:flex items-center gap-2">
            <span className="text-gray-700 font-medium truncate max-w-[100px]">
              {displayName}
            </span>
            {gradeLabel && (
              <span className="text-xs px-2 py-0.5 rounded-full bg-gray-100 text-gray-600">
                {gradeLabel}
              </span>
            )}
            <span className="text-xs px-2 py-0.5 rounded-full bg-brand-50 text-brand-700">
              {isAcademyStudent ? "학원생" : "개인"}
            </span>
          </div>
          <form action="/api/logout" method="post">
            <button className="text-xs text-gray-500 hover:text-gray-900 px-2 py-1 active:scale-95 transition">
              로그아웃
            </button>
          </form>
        </div>
      </div>

      {/* 모바일 네비 — 활성 표시 + 아이콘 + 새 이름 */}
      <nav className="sm:hidden flex border-t bg-white">
        {NAV_ITEMS.map((item) => {
          const active = isActive(item.href);
          return (
            <Link
              key={item.href}
              href={item.href}
              className={`flex-1 text-center py-2.5 text-xs transition active:scale-95 ${
                active
                  ? "text-brand-700 bg-brand-50 font-semibold border-t-2 border-brand-500 -mt-px"
                  : "text-gray-600 hover:bg-gray-50 border-t-2 border-transparent"
              }`}
            >
              <span className="text-base block mb-0.5">{item.emoji}</span>
              <span>{item.short}</span>
            </Link>
          );
        })}
      </nav>
    </header>
  );
}
