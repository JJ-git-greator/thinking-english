-- =====================================================================
-- thinking-english Phase 2: S4 3회독 트래커 (2회독 = Structure 어법 노트)
-- - te_gist_notes에 structure 컬럼 2개 추가
-- - 학생 진도에 structure 카운터 추가
-- =====================================================================

alter table te_gist_notes
  add column if not exists structure_notes text,
  add column if not exists structure_done_at timestamptz;

alter table te_student_progress
  add column if not exists total_structure_notes int default 0;
