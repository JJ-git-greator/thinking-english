-- =====================================================================
-- Structure 객관식 시드 — 하(low) 난이도 15지문의 모든 단락
-- 단락당 3문제: 주어 / 동사 / 구조
-- 단락 lookup: passage_id + ord
-- =====================================================================

-- ===== Passage 1: How Sleep Resets the Brain =========================
-- p0: "During deep sleep, the brain rinses itself with a special fluid that washes away the toxic proteins built up during the day. This cleaning process is most active at night, when the body is still."
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject',
  '다음 문장의 주어는?',
  'During deep sleep, the brain rinses itself with a special fluid.',
  '[{"key":"1","text":"deep sleep"},{"key":"2","text":"the brain"},{"key":"3","text":"itself"},{"key":"4","text":"a special fluid"}]',
  '2',
  '"During deep sleep"는 전치사구로 시작하는 부사구. 첫 명사구 the brain이 주어.'
from te_paragraphs p where p.passage_id = 'a0000001-0000-0000-0000-000000000001' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb',
  '다음 문장에서 주어 the brain과 일치하는 동사 형태는?',
  'During deep sleep, the brain rinses itself with a special fluid.',
  '[{"key":"1","text":"rinse (원형)"},{"key":"2","text":"rinses (3인칭 단수 현재)"},{"key":"3","text":"rinsed (과거)"},{"key":"4","text":"rinsing (현재분사)"}]',
  '2',
  '주어 the brain은 3인칭 단수, 시제는 일반 사실 진술의 현재형이므로 rinses.'
from te_paragraphs p where p.passage_id = 'a0000001-0000-0000-0000-000000000001' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure',
  '이 문장의 핵심 구조 특징은?',
  'The brain rinses itself with a special fluid that washes away the toxic proteins.',
  '[{"key":"1","text":"관계대명사 that이 a special fluid를 꾸민다"},{"key":"2","text":"도치 구문"},{"key":"3","text":"가정법"},{"key":"4","text":"분사구문"}]',
  '1',
  'that washes away ... 절이 선행사 a special fluid를 수식하는 관계절.'
from te_paragraphs p where p.passage_id = 'a0000001-0000-0000-0000-000000000001' and p.ord = 0;

-- p1
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?',
  'Without this nightly washing, the unwanted proteins begin to stack up.',
  '[{"key":"1","text":"nightly washing"},{"key":"2","text":"the unwanted proteins"},{"key":"3","text":"stack up"},{"key":"4","text":"begin"}]',
  '2',
  '"Without this nightly washing"는 전치사구. 그 뒤 주어 the unwanted proteins.'
from te_paragraphs p where p.passage_id = 'a0000001-0000-0000-0000-000000000001' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '주어 the unwanted proteins에 맞는 동사 형태는?',
  'The unwanted proteins begin to stack up.',
  '[{"key":"1","text":"begins (단수)"},{"key":"2","text":"begin (복수)"},{"key":"3","text":"began (과거)"},{"key":"4","text":"beginning"}]',
  '2',
  'proteins는 복수, 현재 시제 → begin.'
from te_paragraphs p where p.passage_id = 'a0000001-0000-0000-0000-000000000001' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '문장에 to부정사가 쓰인 이유는?',
  'The unwanted proteins begin to stack up.',
  '[{"key":"1","text":"begin이 to부정사를 받는 동사이기 때문"},{"key":"2","text":"수동태를 만들기 위해"},{"key":"3","text":"명령문이라"},{"key":"4","text":"가정법이라"}]',
  '1',
  'begin은 뒤에 to부정사(또는 -ing)를 취하는 동사.'
from te_paragraphs p where p.passage_id = 'a0000001-0000-0000-0000-000000000001' and p.ord = 1;

-- p2
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?',
  'This finding suggests that sleeping enough is not a sign of laziness.',
  '[{"key":"1","text":"This finding"},{"key":"2","text":"sleeping enough"},{"key":"3","text":"a sign"},{"key":"4","text":"laziness"}]',
  '1',
  '문장 첫 명사구 This finding이 주어.'
from te_paragraphs p where p.passage_id = 'a0000001-0000-0000-0000-000000000001' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '주어 This finding의 동사 형태는?',
  'This finding suggests that sleeping enough is not a sign of laziness.',
  '[{"key":"1","text":"suggest (원형)"},{"key":"2","text":"suggests (3인칭 단수)"},{"key":"3","text":"suggested (과거)"},{"key":"4","text":"suggesting"}]',
  '2',
  'finding은 3인칭 단수, 현재형 → suggests.'
from te_paragraphs p where p.passage_id = 'a0000001-0000-0000-0000-000000000001' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '문장에서 that이 하는 역할은?',
  'This finding suggests that sleeping enough is not a sign of laziness.',
  '[{"key":"1","text":"명사절 접속사 — suggest의 목적어절을 이끔"},{"key":"2","text":"관계대명사"},{"key":"3","text":"지시대명사"},{"key":"4","text":"강조 어구"}]',
  '1',
  'suggest의 목적어로 that절(명사절)이 옴.'
from te_paragraphs p where p.passage_id = 'a0000001-0000-0000-0000-000000000001' and p.ord = 2;


-- ===== Passage 2: The Quiet Power of Walking =========================
-- p0
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?',
  'A short walk seems almost too easy to be useful.',
  '[{"key":"1","text":"A short walk"},{"key":"2","text":"too easy"},{"key":"3","text":"useful"},{"key":"4","text":"seems"}]',
  '1',
  '첫 명사구 A short walk이 주어.'
from te_paragraphs p where p.passage_id = 'a0000002-0000-0000-0000-000000000002' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '주어 A short walk에 맞는 동사는?',
  'A short walk seems almost too easy.',
  '[{"key":"1","text":"seem (원형)"},{"key":"2","text":"seems (3인칭 단수)"},{"key":"3","text":"seemed"},{"key":"4","text":"seeming"}]',
  '2',
  'walk(단수) + 현재 시제 → seems.'
from te_paragraphs p where p.passage_id = 'a0000002-0000-0000-0000-000000000002' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"too easy to be useful"의 구조는?',
  'A short walk seems almost too easy to be useful.',
  '[{"key":"1","text":"too ~ to 부정사: 너무 ~해서 ~할 수 없다"},{"key":"2","text":"so ~ that 절"},{"key":"3","text":"비교급"},{"key":"4","text":"가정법"}]',
  '1',
  'too + 형용사 + to부정사 구문.'
from te_paragraphs p where p.passage_id = 'a0000002-0000-0000-0000-000000000002' and p.ord = 0;

-- p1
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?',
  'Walking also changes how we think.',
  '[{"key":"1","text":"Walking"},{"key":"2","text":"how"},{"key":"3","text":"we"},{"key":"4","text":"think"}]',
  '1',
  '동명사 Walking이 주어.'
from te_paragraphs p where p.passage_id = 'a0000002-0000-0000-0000-000000000002' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '주어 Walking의 동사 형태는?',
  'Walking also changes how we think.',
  '[{"key":"1","text":"change (원형)"},{"key":"2","text":"changes (3인칭 단수)"},{"key":"3","text":"changed"},{"key":"4","text":"changing"}]',
  '2',
  '동명사 주어는 단수 취급 → changes.'
from te_paragraphs p where p.passage_id = 'a0000002-0000-0000-0000-000000000002' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"how we think"의 역할은?',
  'Walking also changes how we think.',
  '[{"key":"1","text":"changes의 목적어 — 의문사절(명사절)"},{"key":"2","text":"부사절"},{"key":"3","text":"관계절"},{"key":"4","text":"가정법"}]',
  '1',
  'how로 시작하는 의문사절이 동사의 목적어.'
from te_paragraphs p where p.passage_id = 'a0000002-0000-0000-0000-000000000002' and p.ord = 1;

-- p2
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?',
  'The lesson is simple.',
  '[{"key":"1","text":"The lesson"},{"key":"2","text":"is"},{"key":"3","text":"simple"},{"key":"4","text":"lesson"}]',
  '1',
  '첫 명사구 The lesson이 주어.'
from te_paragraphs p where p.passage_id = 'a0000002-0000-0000-0000-000000000002' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '주어 The lesson에 맞는 be동사는?',
  'The lesson is simple.',
  '[{"key":"1","text":"are"},{"key":"2","text":"is"},{"key":"3","text":"were"},{"key":"4","text":"be"}]',
  '2',
  'lesson(단수) + 현재 → is.'
from te_paragraphs p where p.passage_id = 'a0000002-0000-0000-0000-000000000002' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"When a problem feels stuck, the answer may not be more thinking but a quiet walk." 의 구조 특징은?',
  'When a problem feels stuck, the answer may not be more thinking but a quiet walk.',
  '[{"key":"1","text":"When으로 시작하는 부사절 + 주절"},{"key":"2","text":"도치 구문"},{"key":"3","text":"가정법 과거"},{"key":"4","text":"분사구문"}]',
  '1',
  'When ~ 부사절 + 주절 (the answer may not be ...).'
from te_paragraphs p where p.passage_id = 'a0000002-0000-0000-0000-000000000002' and p.ord = 2;


-- ===== Passage 3: Why We Remember Stories Better Than Facts ==========
-- p0
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?',
  'Our brains were built long before there were books or tests.',
  '[{"key":"1","text":"Our brains"},{"key":"2","text":"books"},{"key":"3","text":"tests"},{"key":"4","text":"there"}]',
  '1',
  'Our brains가 주어, were built이 수동태 동사.'
from te_paragraphs p where p.passage_id = 'a0000003-0000-0000-0000-000000000003' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"Our brains were built"는 어떤 형태?',
  'Our brains were built long before there were books or tests.',
  '[{"key":"1","text":"현재 수동태"},{"key":"2","text":"과거 수동태 (were + 과거분사)"},{"key":"3","text":"현재완료"},{"key":"4","text":"능동태 과거"}]',
  '2',
  'were + built(과거분사) = 과거 수동태.'
from te_paragraphs p where p.passage_id = 'a0000003-0000-0000-0000-000000000003' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"long before there were books"의 구조는?',
  'Our brains were built long before there were books or tests.',
  '[{"key":"1","text":"부사절 (시간) — before가 접속사"},{"key":"2","text":"관계절"},{"key":"3","text":"명사절"},{"key":"4","text":"가정법"}]',
  '1',
  'before가 시간 부사절을 이끄는 접속사.'
from te_paragraphs p where p.passage_id = 'a0000003-0000-0000-0000-000000000003' and p.ord = 0;

-- p1
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '"A list of facts is hard to hold." 의 주어는?',
  'A list of facts is hard to hold.',
  '[{"key":"1","text":"A list"},{"key":"2","text":"facts"},{"key":"3","text":"hard"},{"key":"4","text":"hold"}]',
  '1',
  'of facts는 전치사구로 list를 꾸미는 부속. 핵심 주어는 A list.'
from te_paragraphs p where p.passage_id = 'a0000003-0000-0000-0000-000000000003' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"A list of facts ___ hard to hold." 빈칸 동사는?',
  'A list of facts is hard to hold.',
  '[{"key":"1","text":"is (list가 단수)"},{"key":"2","text":"are (facts가 복수니까)"},{"key":"3","text":"were"},{"key":"4","text":"have"}]',
  '1',
  '주어는 list(단수). 뒤의 facts에 끌려가지 말 것.'
from te_paragraphs p where p.passage_id = 'a0000003-0000-0000-0000-000000000003' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"the same fact wrapped in a story" 의 wrapped는?',
  'The same fact wrapped in a story is remembered longer.',
  '[{"key":"1","text":"과거분사 — fact를 꾸미는 분사구"},{"key":"2","text":"동사 과거형"},{"key":"3","text":"현재분사"},{"key":"4","text":"명사"}]',
  '1',
  'wrapped는 the same fact를 후치 수식하는 과거분사구.'
from te_paragraphs p where p.passage_id = 'a0000003-0000-0000-0000-000000000003' and p.ord = 1;

-- p2
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?',
  'This is why a good teacher does not only give information.',
  '[{"key":"1","text":"This"},{"key":"2","text":"why"},{"key":"3","text":"a good teacher"},{"key":"4","text":"information"}]',
  '1',
  '주어는 This.'
from te_paragraphs p where p.passage_id = 'a0000003-0000-0000-0000-000000000003' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"a good teacher does not only give" 에서 부정형은?',
  'A good teacher does not only give information.',
  '[{"key":"1","text":"do not give"},{"key":"2","text":"does not give (단수 주어)"},{"key":"3","text":"is not give"},{"key":"4","text":"not giving"}]',
  '2',
  'teacher(단수) + 일반동사 부정 → does not give.'
from te_paragraphs p where p.passage_id = 'a0000003-0000-0000-0000-000000000003' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"This is why ..." 의 의미·구조는?',
  'This is why a good teacher does not only give information.',
  '[{"key":"1","text":"이유 강조 — 그래서 ~이다"},{"key":"2","text":"가정법"},{"key":"3","text":"의문문"},{"key":"4","text":"명령문"}]',
  '1',
  'This is why ~: "이것이 ~한 이유다" 형태로 자주 결론을 정리.'
from te_paragraphs p where p.passage_id = 'a0000003-0000-0000-0000-000000000003' and p.ord = 2;
