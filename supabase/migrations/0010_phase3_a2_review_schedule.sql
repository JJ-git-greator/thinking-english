-- =====================================================================
-- Phase 3 A2: 망각 곡선 복습 시스템 (Spaced Repetition)
-- 학생이 푼 단락이 1일/3일/7일/21일/60일 간격으로 자동 재등장
-- =====================================================================

create type te_review_stage as enum ('new', 'd1', 'd3', 'd7', 'd21', 'd60', 'mastered');

create table te_paragraph_reviews (
  user_id uuid not null references te_profiles(id) on delete cascade,
  paragraph_id uuid not null references te_paragraphs(id) on delete cascade,
  stage te_review_stage not null default 'new',
  interval_days smallint not null default 1,
  next_review_at timestamptz not null default now() + interval '1 day',
  last_score smallint,                  -- 마지막 재구성 점수
  review_count smallint default 0,
  updated_at timestamptz default now(),
  primary key (user_id, paragraph_id)
);

create index idx_reviews_next on te_paragraph_reviews(user_id, next_review_at) where stage <> 'mastered';

alter table te_paragraph_reviews enable row level security;

create policy "reviews_self_all" on te_paragraph_reviews for all
  using (user_id = auth.uid())
  with check (user_id = auth.uid());

create policy "reviews_org_staff_read" on te_paragraph_reviews for select
  using (
    te_auth_role() in ('director','instructor')
    and exists (
      select 1 from te_profiles s
      where s.id = te_paragraph_reviews.user_id and s.org_id = te_auth_org_id()
    )
  );

-- 진도 집계용 컬럼 추가
alter table te_student_progress
  add column if not exists pending_reviews_today int default 0,
  add column if not exists mastered_paragraphs int default 0;
