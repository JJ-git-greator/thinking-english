import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "Thinking English — 사고력 영어 학습",
  description: "Gist 노트테이킹과 역방향 재구성으로 키우는 사고력 영어",
};

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="ko">
      <body>{children}</body>
    </html>
  );
}
