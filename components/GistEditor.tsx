"use client";

import { useMemo, useState } from "react";
import { splitSentences, type Sentence } from "@/lib/text";

type SelectionType = "main" | "support" | null;

export interface GistSelection {
  mainIdeaText: string | null;
  mainIdeaOffset: { start: number; end: number } | null;
  supportingText: string | null;
  supportingOffset: { start: number; end: number } | null;
}

interface Props {
  paragraphBody: string;
  initial?: GistSelection;
  onChange: (next: GistSelection) => void;
}

/**
 * Click-to-select sentence highlighter.
 * - First click → main idea (yellow highlight)
 * - Second click → supporting sentence (blue underline)
 * - Click an already-marked sentence to clear it.
 * - Mode switcher lets you re-pick either.
 */
export default function GistEditor({ paragraphBody, initial, onChange }: Props) {
  const sentences = useMemo(() => splitSentences(paragraphBody), [paragraphBody]);

  const [main, setMain] = useState<Sentence | null>(
    findInitial(sentences, initial?.mainIdeaOffset, initial?.mainIdeaText),
  );
  const [support, setSupport] = useState<Sentence | null>(
    findInitial(sentences, initial?.supportingOffset, initial?.supportingText),
  );
  const [mode, setMode] = useState<SelectionType>(main ? "support" : "main");

  function emit(nextMain: Sentence | null, nextSupport: Sentence | null) {
    onChange({
      mainIdeaText: nextMain?.text ?? null,
      mainIdeaOffset: nextMain ? { start: nextMain.start, end: nextMain.end } : null,
      supportingText: nextSupport?.text ?? null,
      supportingOffset: nextSupport
        ? { start: nextSupport.start, end: nextSupport.end }
        : null,
    });
  }

  function handleClick(s: Sentence) {
    // Clicking the already-selected one clears it
    if (main?.index === s.index) {
      setMain(null);
      setMode("main");
      emit(null, support);
      return;
    }
    if (support?.index === s.index) {
      setSupport(null);
      setMode("support");
      emit(main, null);
      return;
    }
    if (mode === "main") {
      // If we replace main with a sentence currently used as support, clear support
      const newSupport = support && support.index === s.index ? null : support;
      setMain(s);
      setSupport(newSupport);
      setMode("support");
      emit(s, newSupport);
    } else if (mode === "support") {
      const newMain = main && main.index === s.index ? null : main;
      setSupport(s);
      setMain(newMain);
      setMode(newMain ? "main" : "support");
      emit(newMain, s);
    }
  }

  return (
    <div className="space-y-4">
      <ModeBar mode={mode} setMode={setMode} hasMain={!!main} hasSupport={!!support} />

      <div className="text-lg leading-relaxed bg-white border rounded-lg p-5">
        {sentences.map((s, i) => {
          const isMain = main?.index === s.index;
          const isSupport = support?.index === s.index;
          const cls = isMain
            ? "sentence gist-main"
            : isSupport
              ? "sentence gist-support"
              : "sentence";
          return (
            <span key={s.index}>
              <span className={cls} onClick={() => handleClick(s)}>
                {s.text}
              </span>
              {i < sentences.length - 1 ? " " : ""}
            </span>
          );
        })}
      </div>

      <Legend main={main?.text} support={support?.text} />
    </div>
  );
}

function ModeBar({
  mode,
  setMode,
  hasMain,
  hasSupport,
}: {
  mode: SelectionType;
  setMode: (m: SelectionType) => void;
  hasMain: boolean;
  hasSupport: boolean;
}) {
  return (
    <div className="flex items-center gap-2 text-sm">
      <span className="text-gray-500">선택 모드:</span>
      <button
        onClick={() => setMode("main")}
        className={`px-3 py-1.5 rounded-md border ${
          mode === "main"
            ? "bg-brand-100 border-brand-300 text-brand-800"
            : "bg-white border-gray-200 text-gray-600"
        }`}
      >
        메인 아이디어 {hasMain ? "✓" : ""}
      </button>
      <button
        onClick={() => setMode("support")}
        className={`px-3 py-1.5 rounded-md border ${
          mode === "support"
            ? "bg-blue-100 border-blue-300 text-blue-800"
            : "bg-white border-gray-200 text-gray-600"
        }`}
      >
        서포팅 센텐스 {hasSupport ? "✓" : ""}
      </button>
    </div>
  );
}

function Legend({ main, support }: { main?: string; support?: string }) {
  return (
    <div className="text-sm text-gray-600 space-y-1">
      <p>
        <span className="gist-main">메인 아이디어</span>{" "}
        {main ? <span className="text-gray-800">"{main}"</span> : <em>아직 선택 안 됨</em>}
      </p>
      <p>
        <span className="gist-support">서포팅 센텐스</span>{" "}
        {support ? <span className="text-gray-800">"{support}"</span> : <em>아직 선택 안 됨</em>}
      </p>
    </div>
  );
}

function findInitial(
  sentences: Sentence[],
  offset: { start: number; end: number } | null | undefined,
  text: string | null | undefined,
): Sentence | null {
  if (!offset && !text) return null;
  if (offset) {
    const hit = sentences.find((s) => s.start === offset.start && s.end === offset.end);
    if (hit) return hit;
  }
  if (text) {
    const hit = sentences.find((s) => s.text === text);
    if (hit) return hit;
  }
  return null;
}
