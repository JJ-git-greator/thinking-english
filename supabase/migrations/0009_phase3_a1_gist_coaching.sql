-- =====================================================================
-- Phase 3 A1: Gist 선택 AI 코칭
-- te_gist_notes에 학생 근거 + AI 평가 결과 컬럼 추가
-- =====================================================================

alter table te_gist_notes
  add column if not exists main_reasoning text,
  add column if not exists supporting_reasoning text,
  add column if not exists ai_evaluation jsonb,
  add column if not exists ai_model text,
  add column if not exists evaluated_at timestamptz;
