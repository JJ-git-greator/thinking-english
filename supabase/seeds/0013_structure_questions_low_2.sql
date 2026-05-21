-- =====================================================================
-- Structure 객관식 시드 — 하(low) 2차: 지문 4~15 (12지문 × 약 36단락 × 3문제)
-- =====================================================================

-- ===== Passage 4: Bees and the Hidden Map of Flowers =================
-- p0
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?',
  'A bee can fly two kilometers from its home and return without getting lost.',
  '[{"key":"1","text":"A bee"},{"key":"2","text":"home"},{"key":"3","text":"two kilometers"},{"key":"4","text":"getting lost"}]',
  '1', '문장 첫 명사 A bee.'
from te_paragraphs p where p.passage_id = 'a0000004-0000-0000-0000-000000000004' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '주어 A bee에 맞는 동사 형태는?',
  'A bee can fly two kilometers.',
  '[{"key":"1","text":"can fly (조동사 + 원형)"},{"key":"2","text":"can flies"},{"key":"3","text":"can flying"},{"key":"4","text":"can flew"}]',
  '1', '조동사 can 뒤에는 동사원형.'
from te_paragraphs p where p.passage_id = 'a0000004-0000-0000-0000-000000000004' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"without getting lost" 의 구조는?',
  'A bee can fly two kilometers from its home and return without getting lost.',
  '[{"key":"1","text":"전치사 without + 동명사"},{"key":"2","text":"분사구문"},{"key":"3","text":"가정법"},{"key":"4","text":"수동태"}]',
  '1', 'without 뒤에는 동명사(-ing) 형태.'
from te_paragraphs p where p.passage_id = 'a0000004-0000-0000-0000-000000000004' and p.ord = 0;

-- p1
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?',
  'The shape of the dance tells the other bees how far the flower is.',
  '[{"key":"1","text":"The shape"},{"key":"2","text":"the dance"},{"key":"3","text":"the other bees"},{"key":"4","text":"the flower"}]',
  '1', 'of the dance는 The shape를 꾸미는 전치사구. 주어는 The shape.'
from te_paragraphs p where p.passage_id = 'a0000004-0000-0000-0000-000000000004' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '주어 The shape에 맞는 동사는?',
  'The shape of the dance ___ the other bees.',
  '[{"key":"1","text":"tell"},{"key":"2","text":"tells (단수 주어)"},{"key":"3","text":"told"},{"key":"4","text":"telling"}]',
  '2', 'shape는 단수. dance에 끌려가지 말 것.'
from te_paragraphs p where p.passage_id = 'a0000004-0000-0000-0000-000000000004' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"how far the flower is" 의 역할은?',
  'The shape of the dance tells the other bees how far the flower is.',
  '[{"key":"1","text":"tells의 직접목적어 — 의문사절(명사절)"},{"key":"2","text":"부사절"},{"key":"3","text":"관계절"},{"key":"4","text":"부정사구"}]',
  '1', 'tells [the other bees] [how far ~]: 4형식의 직접목적어.'
from te_paragraphs p where p.passage_id = 'a0000004-0000-0000-0000-000000000004' and p.ord = 1;

-- p2
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?',
  'A creature smaller than a coin carries a map inside it.',
  '[{"key":"1","text":"A creature"},{"key":"2","text":"a coin"},{"key":"3","text":"a map"},{"key":"4","text":"it"}]',
  '1', '"smaller than a coin"은 형용사구로 A creature를 후치 수식.'
from te_paragraphs p where p.passage_id = 'a0000004-0000-0000-0000-000000000004' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '주어 A creature에 맞는 동사는?',
  'A creature smaller than a coin ___ a map inside it.',
  '[{"key":"1","text":"carry"},{"key":"2","text":"carries"},{"key":"3","text":"carried"},{"key":"4","text":"carrying"}]',
  '2', 'creature(단수) + 현재 → carries.'
from te_paragraphs p where p.passage_id = 'a0000004-0000-0000-0000-000000000004' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"smaller than a coin" 의 구조 특징은?',
  'A creature smaller than a coin carries a map inside it.',
  '[{"key":"1","text":"비교급 + than"},{"key":"2","text":"최상급"},{"key":"3","text":"가정법"},{"key":"4","text":"수동태"}]',
  '1', 'smaller(비교급) + than ~ : ~보다 작은.'
from te_paragraphs p where p.passage_id = 'a0000004-0000-0000-0000-000000000004' and p.ord = 2;


-- ===== Passage 5: The First Smartphone =================================
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?',
  'The first device that combined a phone with a small computer came out in 1994.',
  '[{"key":"1","text":"The first device"},{"key":"2","text":"a phone"},{"key":"3","text":"a small computer"},{"key":"4","text":"1994"}]',
  '1', '관계절 that combined ~ 가 The first device를 수식. 주어는 The first device.'
from te_paragraphs p where p.passage_id = 'a0000005-0000-0000-0000-000000000005' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '주어 The first device의 본동사는?',
  'The first device that combined a phone with a small computer came out in 1994.',
  '[{"key":"1","text":"combined (관계절 안)"},{"key":"2","text":"came out (본문장 동사)"},{"key":"3","text":"with"},{"key":"4","text":"out"}]',
  '2', 'combined는 관계절 안. 본동사는 came out.'
from te_paragraphs p where p.passage_id = 'a0000005-0000-0000-0000-000000000005' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"that combined a phone with a small computer" 의 역할은?',
  'The first device that combined a phone with a small computer came out in 1994.',
  '[{"key":"1","text":"관계절 — The first device를 수식"},{"key":"2","text":"명사절"},{"key":"3","text":"부사절"},{"key":"4","text":"가정법"}]',
  '1', '주격 관계대명사 that이 이끄는 형용사절.'
from te_paragraphs p where p.passage_id = 'a0000005-0000-0000-0000-000000000005' and p.ord = 0;

-- p1
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?',
  'The screen was green and could only show a few lines of text.',
  '[{"key":"1","text":"The screen"},{"key":"2","text":"green"},{"key":"3","text":"text"},{"key":"4","text":"a few lines"}]',
  '1', '첫 명사 The screen.'
from te_paragraphs p where p.passage_id = 'a0000005-0000-0000-0000-000000000005' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"The screen was green" 의 was는?',
  'The screen was green.',
  '[{"key":"1","text":"과거 시제 + 단수 주어"},{"key":"2","text":"현재 시제"},{"key":"3","text":"현재완료"},{"key":"4","text":"수동태"}]',
  '1', 'be동사 과거형 was + 단수 주어.'
from te_paragraphs p where p.passage_id = 'a0000005-0000-0000-0000-000000000005' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"It cost as much as a small car." 의 비교 구조는?',
  'It cost as much as a small car.',
  '[{"key":"1","text":"as ~ as 동등 비교"},{"key":"2","text":"비교급 + than"},{"key":"3","text":"최상급"},{"key":"4","text":"가정법"}]',
  '1', 'as + 형용사/부사 + as: 동등 비교.'
from te_paragraphs p where p.passage_id = 'a0000005-0000-0000-0000-000000000005' and p.ord = 1;

-- p2
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?',
  'Most people in 1994 did not see why they would need such a thing.',
  '[{"key":"1","text":"Most people"},{"key":"2","text":"1994"},{"key":"3","text":"they"},{"key":"4","text":"such a thing"}]',
  '1', 'in 1994는 부사구. 주어는 Most people.'
from te_paragraphs p where p.passage_id = 'a0000005-0000-0000-0000-000000000005' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"Most people did not see ..." 의 시제는?',
  'Most people in 1994 did not see why they would need such a thing.',
  '[{"key":"1","text":"과거 + 부정"},{"key":"2","text":"현재 + 부정"},{"key":"3","text":"현재완료"},{"key":"4","text":"수동태"}]',
  '1', 'did + not + see = 과거 부정.'
from te_paragraphs p where p.passage_id = 'a0000005-0000-0000-0000-000000000005' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"why they would need such a thing" 의 역할은?',
  'Most people did not see why they would need such a thing.',
  '[{"key":"1","text":"see의 목적어 — 의문사절(명사절)"},{"key":"2","text":"부사절"},{"key":"3","text":"관계절"},{"key":"4","text":"분사구문"}]',
  '1', 'why로 시작하는 의문사절이 see의 목적어.'
from te_paragraphs p where p.passage_id = 'a0000005-0000-0000-0000-000000000005' and p.ord = 2;


-- ===== Passage 6: Why Music Helps Us Focus ============================
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?',
  'Some students find total silence helpful for difficult reading.',
  '[{"key":"1","text":"Some students"},{"key":"2","text":"total silence"},{"key":"3","text":"reading"},{"key":"4","text":"helpful"}]',
  '1', 'Some students가 주어.'
from te_paragraphs p where p.passage_id = 'a0000006-0000-0000-0000-000000000006' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '주어 Some students에 맞는 동사는?',
  'Some students ___ total silence helpful.',
  '[{"key":"1","text":"finds (단수)"},{"key":"2","text":"find (복수)"},{"key":"3","text":"finding"},{"key":"4","text":"found 만 가능"}]',
  '2', 'students(복수) + 현재 → find.'
from te_paragraphs p where p.passage_id = 'a0000006-0000-0000-0000-000000000006' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"find total silence helpful" 의 구조는?',
  'Some students find total silence helpful for difficult reading.',
  '[{"key":"1","text":"5형식: 주어 + find + 목적어 + 형용사(목적격 보어)"},{"key":"2","text":"4형식"},{"key":"3","text":"수동태"},{"key":"4","text":"가정법"}]',
  '1', 'find + O + OC(형용사): O가 ~하다고 여기다.'
from te_paragraphs p where p.passage_id = 'a0000006-0000-0000-0000-000000000006' and p.ord = 0;

-- p1
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?',
  'Silence usually wins for tasks that need clear thinking.',
  '[{"key":"1","text":"Silence"},{"key":"2","text":"tasks"},{"key":"3","text":"clear thinking"},{"key":"4","text":"need"}]',
  '1', 'Silence가 주어. that 절은 tasks를 꾸민다.'
from te_paragraphs p where p.passage_id = 'a0000006-0000-0000-0000-000000000006' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '주어 Silence에 맞는 동사는?',
  'Silence usually ___ for tasks that need clear thinking.',
  '[{"key":"1","text":"wins (단수)"},{"key":"2","text":"win (복수)"},{"key":"3","text":"won 만 가능"},{"key":"4","text":"winning"}]',
  '1', 'Silence(불가산, 단수 취급) → wins.'
from te_paragraphs p where p.passage_id = 'a0000006-0000-0000-0000-000000000006' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"tasks that need clear thinking" 에서 that의 역할은?',
  'Silence usually wins for tasks that need clear thinking.',
  '[{"key":"1","text":"주격 관계대명사 — tasks 수식"},{"key":"2","text":"명사절 접속사"},{"key":"3","text":"지시대명사"},{"key":"4","text":"부사절 접속사"}]',
  '1', 'that need ~ 가 tasks를 수식하는 형용사절.'
from te_paragraphs p where p.passage_id = 'a0000006-0000-0000-0000-000000000006' and p.ord = 1;

-- p2
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?',
  'The key is to match the sound to the task.',
  '[{"key":"1","text":"The key"},{"key":"2","text":"to match"},{"key":"3","text":"the sound"},{"key":"4","text":"the task"}]',
  '1', '첫 명사 The key.'
from te_paragraphs p where p.passage_id = 'a0000006-0000-0000-0000-000000000006' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"The key is to match ..." 에서 보어 자리에 오는 것은?',
  'The key is to match the sound to the task.',
  '[{"key":"1","text":"to부정사 — 명사적 용법"},{"key":"2","text":"동명사"},{"key":"3","text":"형용사"},{"key":"4","text":"부사"}]',
  '1', 'is 뒤의 to match가 주격 보어. to부정사의 명사적 용법.'
from te_paragraphs p where p.passage_id = 'a0000006-0000-0000-0000-000000000006' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"Loud lyrics during difficult reading often steal focus" 의 핵심 구조는?',
  'Loud lyrics during difficult reading often steal focus.',
  '[{"key":"1","text":"주어(Loud lyrics) + 전치사구(during ~) + 부사(often) + 동사"},{"key":"2","text":"수동태"},{"key":"3","text":"도치 구문"},{"key":"4","text":"가정법"}]',
  '1', '주어와 동사 사이에 부사구가 들어간 일반 평서문.'
from te_paragraphs p where p.passage_id = 'a0000006-0000-0000-0000-000000000006' and p.ord = 2;


-- ===== Passage 7: The Lost Language of Whistles =======================
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?',
  'On the island of La Gomera, the valleys are too deep to shout across.',
  '[{"key":"1","text":"the island"},{"key":"2","text":"La Gomera"},{"key":"3","text":"the valleys"},{"key":"4","text":"too deep"}]',
  '3', '문두 전치사구를 건너뛰면 주어는 the valleys.'
from te_paragraphs p where p.passage_id = 'a0000007-0000-0000-0000-000000000007' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '주어 the valleys에 맞는 be동사는?',
  'The valleys ___ too deep to shout across.',
  '[{"key":"1","text":"is"},{"key":"2","text":"are (복수)"},{"key":"3","text":"was"},{"key":"4","text":"be"}]',
  '2', 'valleys(복수) → are.'
from te_paragraphs p where p.passage_id = 'a0000007-0000-0000-0000-000000000007' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"too deep to shout across" 의 구문은?',
  'The valleys are too deep to shout across.',
  '[{"key":"1","text":"too ~ to 부정사: 너무 ~해서 ~할 수 없다"},{"key":"2","text":"so ~ that 절"},{"key":"3","text":"as ~ as 동등 비교"},{"key":"4","text":"가정법"}]',
  '1', 'too + 형용사 + to부정사.'
from te_paragraphs p where p.passage_id = 'a0000007-0000-0000-0000-000000000007' and p.ord = 0;

-- p1
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?',
  'A skilled whistler can be understood from two kilometers away.',
  '[{"key":"1","text":"A skilled whistler"},{"key":"2","text":"two kilometers"},{"key":"3","text":"away"},{"key":"4","text":"can"}]',
  '1', '첫 명사구 A skilled whistler.'
from te_paragraphs p where p.passage_id = 'a0000007-0000-0000-0000-000000000007' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"can be understood" 의 형태는?',
  'A skilled whistler can be understood from two kilometers away.',
  '[{"key":"1","text":"조동사 + 수동태 (be + 과거분사)"},{"key":"2","text":"능동태"},{"key":"3","text":"가정법"},{"key":"4","text":"현재완료"}]',
  '1', 'can + be + understood = 조동사 + 수동태.'
from te_paragraphs p where p.passage_id = 'a0000007-0000-0000-0000-000000000007' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"The language is real, with grammar and meaning, not just signals." 의 구조 특징은?',
  'The language is real, with grammar and meaning, not just signals.',
  '[{"key":"1","text":"보어 real을 with + 명사구가 부가 설명"},{"key":"2","text":"가정법"},{"key":"3","text":"명령문"},{"key":"4","text":"도치 구문"}]',
  '1', 'real에 with grammar and meaning이 부가 설명을 더하는 평서문.'
from te_paragraphs p where p.passage_id = 'a0000007-0000-0000-0000-000000000007' and p.ord = 1;

-- p2
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?',
  'For a time, the young people forgot the skill.',
  '[{"key":"1","text":"a time"},{"key":"2","text":"the young people"},{"key":"3","text":"the skill"},{"key":"4","text":"forgot"}]',
  '2', '문두 전치사구를 건너뛰면 the young people.'
from te_paragraphs p where p.passage_id = 'a0000007-0000-0000-0000-000000000007' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"the young people forgot" 의 시제는?',
  'The young people forgot the skill.',
  '[{"key":"1","text":"과거"},{"key":"2","text":"현재"},{"key":"3","text":"현재완료"},{"key":"4","text":"미래"}]',
  '1', 'forgot은 forget의 과거형.'
from te_paragraphs p where p.passage_id = 'a0000007-0000-0000-0000-000000000007' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"because losing a language means losing a way of seeing the world." 에서 losing은?',
  'Losing a language means losing a way of seeing the world.',
  '[{"key":"1","text":"동명사 — 주어/목적어 자리"},{"key":"2","text":"현재분사"},{"key":"3","text":"명사"},{"key":"4","text":"형용사"}]',
  '1', 'Losing이 주어로 쓰인 동명사. means losing 의 losing도 목적어 동명사.'
from te_paragraphs p where p.passage_id = 'a0000007-0000-0000-0000-000000000007' and p.ord = 2;


-- ===== Passage 8: Coral Reef ==========================================
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?',
  'Coral reefs cover less than one percent of the ocean floor.',
  '[{"key":"1","text":"Coral reefs"},{"key":"2","text":"one percent"},{"key":"3","text":"the ocean floor"},{"key":"4","text":"less"}]',
  '1', 'Coral reefs.'
from te_paragraphs p where p.passage_id = 'a0000008-0000-0000-0000-000000000008' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '주어 Coral reefs에 맞는 동사는?',
  'Coral reefs ___ less than one percent of the ocean floor.',
  '[{"key":"1","text":"covers (단수)"},{"key":"2","text":"cover (복수)"},{"key":"3","text":"covered 만 가능"},{"key":"4","text":"covering"}]',
  '2', 'reefs(복수) → cover.'
from te_paragraphs p where p.passage_id = 'a0000008-0000-0000-0000-000000000008' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"Without them, much of ocean life would have nowhere to live." 의 구조는?',
  'Without them, much of ocean life would have nowhere to live.',
  '[{"key":"1","text":"가정법 — Without them은 if 절 대용"},{"key":"2","text":"명령문"},{"key":"3","text":"단순 평서문"},{"key":"4","text":"의문문"}]',
  '1', 'Without ~ + would: 가정법 현재. if not for them과 같은 의미.'
from te_paragraphs p where p.passage_id = 'a0000008-0000-0000-0000-000000000008' and p.ord = 0;

-- p1
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?',
  'They also break the energy of large waves before the waves reach the coast.',
  '[{"key":"1","text":"They"},{"key":"2","text":"the energy"},{"key":"3","text":"large waves"},{"key":"4","text":"the coast"}]',
  '1', '대명사 They가 주어.'
from te_paragraphs p where p.passage_id = 'a0000008-0000-0000-0000-000000000008' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"They also break ..." 에서 break의 형태는?',
  'They also break the energy of large waves.',
  '[{"key":"1","text":"현재 시제, 복수 주어와 일치"},{"key":"2","text":"명령문"},{"key":"3","text":"수동태"},{"key":"4","text":"과거"}]',
  '1', 'They(복수) + 현재 → break.'
from te_paragraphs p where p.passage_id = 'a0000008-0000-0000-0000-000000000008' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"before the waves reach the coast" 의 역할은?',
  'They break the energy of large waves before the waves reach the coast.',
  '[{"key":"1","text":"시간 부사절 — before가 접속사"},{"key":"2","text":"명사절"},{"key":"3","text":"관계절"},{"key":"4","text":"분사구문"}]',
  '1', 'before가 시간 접속사로 부사절을 이끔.'
from te_paragraphs p where p.passage_id = 'a0000008-0000-0000-0000-000000000008' and p.ord = 1;

-- p2
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?',
  'A reef is not just beautiful.',
  '[{"key":"1","text":"A reef"},{"key":"2","text":"beautiful"},{"key":"3","text":"just"},{"key":"4","text":"not"}]',
  '1', 'A reef.'
from te_paragraphs p where p.passage_id = 'a0000008-0000-0000-0000-000000000008' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"A reef is not just beautiful." 의 is는?',
  'A reef is not just beautiful.',
  '[{"key":"1","text":"단수 주어 + 현재 시제"},{"key":"2","text":"복수 주어"},{"key":"3","text":"과거"},{"key":"4","text":"수동태"}]',
  '1', 'reef(단수) + 현재 be동사 is.'
from te_paragraphs p where p.passage_id = 'a0000008-0000-0000-0000-000000000008' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"When it dies, much more dies with it." 의 구조는?',
  'When it dies, much more dies with it.',
  '[{"key":"1","text":"When 시간 부사절 + 주절"},{"key":"2","text":"도치"},{"key":"3","text":"가정법"},{"key":"4","text":"명령문"}]',
  '1', 'When 부사절 + 주절의 일반 구조.'
from te_paragraphs p where p.passage_id = 'a0000008-0000-0000-0000-000000000008' and p.ord = 2;


-- ===== Passage 9: Compliment ==========================================
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?',
  'When a person hears a sincere compliment, scans of the brain show the same areas lighting up.',
  '[{"key":"1","text":"a person"},{"key":"2","text":"a sincere compliment"},{"key":"3","text":"scans of the brain"},{"key":"4","text":"the same areas"}]',
  '3', 'When 부사절 안 주어는 a person. 주절 주어는 scans of the brain.'
from te_paragraphs p where p.passage_id = 'a0000009-0000-0000-0000-000000000009' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '주절 주어 scans of the brain에 맞는 동사는?',
  'Scans of the brain ___ the same areas lighting up.',
  '[{"key":"1","text":"shows (단수)"},{"key":"2","text":"show (복수)"},{"key":"3","text":"shown"},{"key":"4","text":"showing"}]',
  '2', 'scans(복수)가 주어. of the brain에 끌려 단수로 쓰지 말 것.'
from te_paragraphs p where p.passage_id = 'a0000009-0000-0000-0000-000000000009' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"the same areas lighting up" 의 lighting은?',
  'Scans of the brain show the same areas lighting up.',
  '[{"key":"1","text":"현재분사 — 목적어 the same areas를 후치 수식"},{"key":"2","text":"동명사"},{"key":"3","text":"동사 본동사"},{"key":"4","text":"명사"}]',
  '1', '지각/관찰 동사 뒤 목적어 + 현재분사 구문.'
from te_paragraphs p where p.passage_id = 'a0000009-0000-0000-0000-000000000009' and p.ord = 0;

-- p1
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?',
  'This means kind words are not just words.',
  '[{"key":"1","text":"This"},{"key":"2","text":"kind words"},{"key":"3","text":"just words"},{"key":"4","text":"means"}]',
  '1', 'This가 주어.'
from te_paragraphs p where p.passage_id = 'a0000009-0000-0000-0000-000000000009' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '주어 This에 맞는 동사는?',
  'This ___ kind words are not just words.',
  '[{"key":"1","text":"mean"},{"key":"2","text":"means (단수 주어)"},{"key":"3","text":"meant"},{"key":"4","text":"meaning"}]',
  '2', 'This(단수) + 현재 → means.'
from te_paragraphs p where p.passage_id = 'a0000009-0000-0000-0000-000000000009' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"This means kind words are not just words" 에서 that이 생략된 위치는?',
  'This means kind words are not just words.',
  '[{"key":"1","text":"means 뒤 — 명사절 접속사 that 생략"},{"key":"2","text":"are 뒤"},{"key":"3","text":"문장 끝"},{"key":"4","text":"This 앞"}]',
  '1', 'means 뒤에 명사절 접속사 that이 생략됨.'
from te_paragraphs p where p.passage_id = 'a0000009-0000-0000-0000-000000000009' and p.ord = 1;

-- p2
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?',
  'A short honest compliment costs nothing.',
  '[{"key":"1","text":"A short honest compliment"},{"key":"2","text":"nothing"},{"key":"3","text":"costs"},{"key":"4","text":"short"}]',
  '1', '명사구 A short honest compliment.'
from te_paragraphs p where p.passage_id = 'a0000009-0000-0000-0000-000000000009' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '주어 A short honest compliment에 맞는 동사는?',
  'A short honest compliment ___ nothing.',
  '[{"key":"1","text":"cost (복수)"},{"key":"2","text":"costs (단수)"},{"key":"3","text":"costing"},{"key":"4","text":"is cost"}]',
  '2', 'compliment(단수) + 현재 → costs.'
from te_paragraphs p where p.passage_id = 'a0000009-0000-0000-0000-000000000009' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"yet it gives a real gift to the listener" 에서 yet의 역할은?',
  'A short honest compliment costs nothing, yet it gives a real gift to the listener.',
  '[{"key":"1","text":"등위접속사 — 그러나, 하지만"},{"key":"2","text":"부사"},{"key":"3","text":"명사"},{"key":"4","text":"전치사"}]',
  '1', '여기서 yet은 but과 유사한 등위접속사로 두 절을 대조 연결.'
from te_paragraphs p where p.passage_id = 'a0000009-0000-0000-0000-000000000009' and p.ord = 2;


-- ===== Passage 10: Cities Hotter ======================================
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?',
  'A city is mostly concrete, asphalt, and stone.',
  '[{"key":"1","text":"A city"},{"key":"2","text":"concrete"},{"key":"3","text":"asphalt"},{"key":"4","text":"stone"}]',
  '1', 'A city.'
from te_paragraphs p where p.passage_id = 'a000000a-0000-0000-0000-00000000000a' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"A city is mostly concrete..." 의 동사 is는?',
  'A city is mostly concrete, asphalt, and stone.',
  '[{"key":"1","text":"단수 주어 + 현재 be"},{"key":"2","text":"복수"},{"key":"3","text":"과거"},{"key":"4","text":"수동태"}]',
  '1', 'city(단수) + 현재.'
from te_paragraphs p where p.passage_id = 'a000000a-0000-0000-0000-00000000000a' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"A forest, made of leaves and damp soil, does the opposite." 에서 made of ~ 는?',
  'A forest, made of leaves and damp soil, does the opposite.',
  '[{"key":"1","text":"과거분사 — A forest 후치 수식"},{"key":"2","text":"본동사"},{"key":"3","text":"명사"},{"key":"4","text":"부사"}]',
  '1', 'made of ~ 가 A forest를 꾸미는 분사구.'
from te_paragraphs p where p.passage_id = 'a000000a-0000-0000-0000-00000000000a' and p.ord = 0;

-- p1
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?',
  'On a hot afternoon, the temperature inside a city can be five to seven degrees higher than the temperature in a forest.',
  '[{"key":"1","text":"a hot afternoon"},{"key":"2","text":"the temperature inside a city"},{"key":"3","text":"five to seven degrees"},{"key":"4","text":"a forest"}]',
  '2', '문두 전치사구를 건너뛰면 주어는 the temperature inside a city.'
from te_paragraphs p where p.passage_id = 'a000000a-0000-0000-0000-00000000000a' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"can be five to seven degrees higher" 의 형태는?',
  'The temperature can be five to seven degrees higher than the temperature in a forest.',
  '[{"key":"1","text":"조동사 + be동사 + 비교급"},{"key":"2","text":"수동태"},{"key":"3","text":"가정법"},{"key":"4","text":"현재완료"}]',
  '1', 'can(조동사) + be + 비교급(higher).'
from te_paragraphs p where p.passage_id = 'a000000a-0000-0000-0000-00000000000a' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"higher than the temperature in a forest" 의 구조는?',
  'The temperature is higher than the temperature in a forest.',
  '[{"key":"1","text":"비교급 + than"},{"key":"2","text":"동등 비교"},{"key":"3","text":"최상급"},{"key":"4","text":"가정법"}]',
  '1', 'higher + than: 비교급 구문.'
from te_paragraphs p where p.passage_id = 'a000000a-0000-0000-0000-00000000000a' and p.ord = 1;

-- p2
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?',
  'Planting trees, painting rooftops white, and adding small parks can lower these numbers.',
  '[{"key":"1","text":"Planting trees, painting rooftops white, and adding small parks (동명사구)"},{"key":"2","text":"trees"},{"key":"3","text":"rooftops"},{"key":"4","text":"small parks"}]',
  '1', '동명사구 세 개가 등위로 연결된 명사구 주어.'
from te_paragraphs p where p.passage_id = 'a000000a-0000-0000-0000-00000000000a' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"Planting trees, painting rooftops white, and adding small parks can ___ these numbers." 에 맞는 동사는?',
  'Planting ..., painting ..., and adding ... can ___ these numbers.',
  '[{"key":"1","text":"lower (조동사 뒤 원형)"},{"key":"2","text":"lowers"},{"key":"3","text":"lowered"},{"key":"4","text":"lowering"}]',
  '1', '조동사 can 뒤에는 동사원형.'
from te_paragraphs p where p.passage_id = 'a000000a-0000-0000-0000-00000000000a' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"requires planning before the next summer arrives" 의 동명사는?',
  'It requires planning before the next summer arrives.',
  '[{"key":"1","text":"planning — requires의 목적어 동명사"},{"key":"2","text":"분사"},{"key":"3","text":"명사"},{"key":"4","text":"형용사"}]',
  '1', 'require는 to부정사가 아닌 동명사를 목적어로 자주 취함.'
from te_paragraphs p where p.passage_id = 'a000000a-0000-0000-0000-00000000000a' and p.ord = 2;


-- ===== Passage 11: Oldest Toy =========================================
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?',
  'Almost every old civilization made simple round balls for children.',
  '[{"key":"1","text":"Almost every old civilization"},{"key":"2","text":"simple round balls"},{"key":"3","text":"children"},{"key":"4","text":"every"}]',
  '1', 'every civilization이 단수 주어.'
from te_paragraphs p where p.passage_id = 'a000000b-0000-0000-0000-00000000000b' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', 'every + 단수명사가 주어일 때 동사는?',
  'Almost every old civilization ___ simple round balls.',
  '[{"key":"1","text":"make (복수)"},{"key":"2","text":"makes / made (단수)"},{"key":"3","text":"making"},{"key":"4","text":"are made"}]',
  '2', 'every + 단수명사는 단수 취급 → makes/made.'
from te_paragraphs p where p.passage_id = 'a000000b-0000-0000-0000-00000000000b' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"The materials changed, but the idea did not." 의 구조는?',
  'The materials changed, but the idea did not.',
  '[{"key":"1","text":"두 절을 등위접속사 but으로 연결"},{"key":"2","text":"종속절"},{"key":"3","text":"가정법"},{"key":"4","text":"수동태"}]',
  '1', '두 평서문을 but으로 연결한 등위 구조.'
from te_paragraphs p where p.passage_id = 'a000000b-0000-0000-0000-00000000000b' and p.ord = 0;

-- p1
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?',
  'A ball teaches the body how to throw, catch, and predict.',
  '[{"key":"1","text":"A ball"},{"key":"2","text":"the body"},{"key":"3","text":"throw"},{"key":"4","text":"predict"}]',
  '1', '첫 명사구 A ball.'
from te_paragraphs p where p.passage_id = 'a000000b-0000-0000-0000-00000000000b' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '주어 A ball에 맞는 동사는?',
  'A ball ___ the body how to throw, catch, and predict.',
  '[{"key":"1","text":"teach"},{"key":"2","text":"teaches"},{"key":"3","text":"taught 만 가능"},{"key":"4","text":"teaching"}]',
  '2', 'ball(단수) + 현재 → teaches.'
from te_paragraphs p where p.passage_id = 'a000000b-0000-0000-0000-00000000000b' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"how to throw, catch, and predict" 의 구조는?',
  'A ball teaches the body how to throw, catch, and predict.',
  '[{"key":"1","text":"how + to부정사 — 명사구 (방법)"},{"key":"2","text":"관계절"},{"key":"3","text":"분사구"},{"key":"4","text":"가정법"}]',
  '1', 'how + to부정사: ~하는 방법.'
from te_paragraphs p where p.passage_id = 'a000000b-0000-0000-0000-00000000000b' and p.ord = 1;

-- p2
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?',
  'Simple things last because they teach the most.',
  '[{"key":"1","text":"Simple things"},{"key":"2","text":"they"},{"key":"3","text":"the most"},{"key":"4","text":"because"}]',
  '1', 'Simple things가 주어.'
from te_paragraphs p where p.passage_id = 'a000000b-0000-0000-0000-00000000000b' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '주어 Simple things에 맞는 동사는?',
  'Simple things ___ because they teach the most.',
  '[{"key":"1","text":"lasts"},{"key":"2","text":"last (복수)"},{"key":"3","text":"lasting"},{"key":"4","text":"is lasted"}]',
  '2', 'things(복수) → last.'
from te_paragraphs p where p.passage_id = 'a000000b-0000-0000-0000-00000000000b' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"because they teach the most" 의 역할은?',
  'Simple things last because they teach the most.',
  '[{"key":"1","text":"이유 부사절 (because가 접속사)"},{"key":"2","text":"명사절"},{"key":"3","text":"관계절"},{"key":"4","text":"분사구문"}]',
  '1', 'because는 이유 부사절을 이끄는 접속사.'
from te_paragraphs p where p.passage_id = 'a000000b-0000-0000-0000-00000000000b' and p.ord = 2;


-- ===== Passage 12: Next-day food ======================================
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?',
  'When a stew sits in the fridge overnight, the flavors do not stay still.',
  '[{"key":"1","text":"a stew"},{"key":"2","text":"the fridge"},{"key":"3","text":"the flavors"},{"key":"4","text":"still"}]',
  '3', 'When 부사절 주어는 a stew. 주절 주어는 the flavors.'
from te_paragraphs p where p.passage_id = 'a000000c-0000-0000-0000-00000000000c' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '주어 the flavors에 맞는 동사는?',
  'The flavors ___ stay still.',
  '[{"key":"1","text":"does not"},{"key":"2","text":"do not (복수)"},{"key":"3","text":"is not"},{"key":"4","text":"are not"}]',
  '2', 'flavors(복수) → do not.'
from te_paragraphs p where p.passage_id = 'a000000c-0000-0000-0000-00000000000c' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"When a stew sits in the fridge overnight" 의 역할은?',
  'When a stew sits in the fridge overnight, the flavors do not stay still.',
  '[{"key":"1","text":"시간 부사절"},{"key":"2","text":"명사절"},{"key":"3","text":"관계절"},{"key":"4","text":"분사구문"}]',
  '1', 'When + 절: 시간 부사절.'
from te_paragraphs p where p.passage_id = 'a000000c-0000-0000-0000-00000000000c' and p.ord = 0;

-- p1
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?',
  'Sharp flavors that taste loud on the first day soften.',
  '[{"key":"1","text":"Sharp flavors"},{"key":"2","text":"the first day"},{"key":"3","text":"that"},{"key":"4","text":"taste"}]',
  '1', '관계절 "that ~ first day"가 Sharp flavors를 수식. 본동사 soften의 주어는 Sharp flavors.'
from te_paragraphs p where p.passage_id = 'a000000c-0000-0000-0000-00000000000c' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '주어 Sharp flavors의 본동사는?',
  'Sharp flavors that taste loud on the first day soften.',
  '[{"key":"1","text":"taste (관계절 안)"},{"key":"2","text":"soften (본문장 동사)"},{"key":"3","text":"sharpen"},{"key":"4","text":"loud"}]',
  '2', '관계절은 수식어. 본동사는 soften.'
from te_paragraphs p where p.passage_id = 'a000000c-0000-0000-0000-00000000000c' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"The next-day version is smoother and more balanced." 의 구조는?',
  'The next-day version is smoother and more balanced.',
  '[{"key":"1","text":"비교급 두 개를 and로 연결"},{"key":"2","text":"최상급"},{"key":"3","text":"동등 비교"},{"key":"4","text":"가정법"}]',
  '1', 'smoother(비교급) and more balanced(비교급).'
from te_paragraphs p where p.passage_id = 'a000000c-0000-0000-0000-00000000000c' and p.ord = 1;

-- p2
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?',
  'Good cooks know this.',
  '[{"key":"1","text":"Good cooks"},{"key":"2","text":"this"},{"key":"3","text":"know"},{"key":"4","text":"good"}]',
  '1', 'Good cooks.'
from te_paragraphs p where p.passage_id = 'a000000c-0000-0000-0000-00000000000c' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '주어 Good cooks에 맞는 동사는?',
  'Good cooks ___ this.',
  '[{"key":"1","text":"knows"},{"key":"2","text":"know (복수)"},{"key":"3","text":"knowing"},{"key":"4","text":"is known"}]',
  '2', 'cooks(복수) → know.'
from te_paragraphs p where p.passage_id = 'a000000c-0000-0000-0000-00000000000c' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"Many recipes are written so that the dish is made one day and served the next, on purpose." 의 so that의 역할은?',
  'Many recipes are written so that the dish is made one day and served the next.',
  '[{"key":"1","text":"목적 부사절 — ~하기 위해서"},{"key":"2","text":"결과"},{"key":"3","text":"가정법"},{"key":"4","text":"관계절"}]',
  '1', 'so that ~: ~하기 위해서(목적). 또는 결과로도 쓰이지만 여기선 목적.'
from te_paragraphs p where p.passage_id = 'a000000c-0000-0000-0000-00000000000c' and p.ord = 2;


-- ===== Passage 13: Soccer ball math ====================================
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?',
  'A soccer ball is built from twenty white six-sided pieces and twelve black five-sided pieces.',
  '[{"key":"1","text":"A soccer ball"},{"key":"2","text":"twenty white six-sided pieces"},{"key":"3","text":"twelve black five-sided pieces"},{"key":"4","text":"is"}]',
  '1', '첫 명사구 A soccer ball.'
from te_paragraphs p where p.passage_id = 'a000000d-0000-0000-0000-00000000000d' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"is built from ..." 의 형태는?',
  'A soccer ball is built from twenty white six-sided pieces.',
  '[{"key":"1","text":"수동태 (be + 과거분사)"},{"key":"2","text":"능동태"},{"key":"3","text":"가정법"},{"key":"4","text":"현재완료"}]',
  '1', 'is + built(과거분사) = 수동태.'
from te_paragraphs p where p.passage_id = 'a000000d-0000-0000-0000-00000000000d' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"Together, these shapes wrap a ball almost perfectly." 의 구조는?',
  'Together, these shapes wrap a ball almost perfectly.',
  '[{"key":"1","text":"부사(Together) + 주어 + 동사 + 목적어 + 부사"},{"key":"2","text":"도치 구문"},{"key":"3","text":"가정법"},{"key":"4","text":"명령문"}]',
  '1', 'Together는 도입 부사. 일반 평서문.'
from te_paragraphs p where p.passage_id = 'a000000d-0000-0000-0000-00000000000d' and p.ord = 0;

-- p1
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?',
  'This pattern is not chosen for looks alone.',
  '[{"key":"1","text":"This pattern"},{"key":"2","text":"looks"},{"key":"3","text":"alone"},{"key":"4","text":"not"}]',
  '1', 'This pattern.'
from te_paragraphs p where p.passage_id = 'a000000d-0000-0000-0000-00000000000d' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"This pattern is not chosen" 의 형태는?',
  'This pattern is not chosen for looks alone.',
  '[{"key":"1","text":"수동태 부정형"},{"key":"2","text":"능동태"},{"key":"3","text":"명령문"},{"key":"4","text":"가정법"}]',
  '1', 'is not + 과거분사 = 수동태 부정.'
from te_paragraphs p where p.passage_id = 'a000000d-0000-0000-0000-00000000000d' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"It is one of the few ways to cover a round surface with flat pieces." 의 to부정사는?',
  'It is one of the few ways to cover a round surface with flat pieces.',
  '[{"key":"1","text":"형용사적 용법 — ways 수식"},{"key":"2","text":"명사적 용법"},{"key":"3","text":"부사적 용법"},{"key":"4","text":"동명사"}]',
  '1', 'ways to cover ~: ~하는 방법들 (to부정사가 명사를 꾸미는 형용사적 용법).'
from te_paragraphs p where p.passage_id = 'a000000d-0000-0000-0000-00000000000d' and p.ord = 1;

-- p2
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?',
  'Mathematicians have studied this shape since long before soccer existed.',
  '[{"key":"1","text":"Mathematicians"},{"key":"2","text":"this shape"},{"key":"3","text":"soccer"},{"key":"4","text":"long"}]',
  '1', 'Mathematicians.'
from te_paragraphs p where p.passage_id = 'a000000d-0000-0000-0000-00000000000d' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"Mathematicians have studied ..." 의 형태는?',
  'Mathematicians have studied this shape since long before soccer existed.',
  '[{"key":"1","text":"현재완료 (have + 과거분사)"},{"key":"2","text":"단순 과거"},{"key":"3","text":"수동태"},{"key":"4","text":"가정법"}]',
  '1', 'have + studied = 현재완료. since와 자주 어울림.'
from te_paragraphs p where p.passage_id = 'a000000d-0000-0000-0000-00000000000d' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"Sport and math, far apart at first glance, often meet on the same field." 에서 far apart at first glance는?',
  'Sport and math, far apart at first glance, often meet on the same field.',
  '[{"key":"1","text":"삽입구 — 주어를 부가 설명"},{"key":"2","text":"본동사"},{"key":"3","text":"명사절"},{"key":"4","text":"관계절"}]',
  '1', '쉼표 사이의 형용사구 삽입.'
from te_paragraphs p where p.passage_id = 'a000000d-0000-0000-0000-00000000000d' and p.ord = 2;


-- ===== Passage 14: Slow reading =======================================
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?',
  'Speed reading promises to push a thousand words a minute through the brain.',
  '[{"key":"1","text":"Speed reading"},{"key":"2","text":"a thousand words"},{"key":"3","text":"the brain"},{"key":"4","text":"a minute"}]',
  '1', 'Speed reading.'
from te_paragraphs p where p.passage_id = 'a000000e-0000-0000-0000-00000000000e' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"promises to push" 의 to push는?',
  'Speed reading promises to push a thousand words a minute through the brain.',
  '[{"key":"1","text":"promise의 목적어 — to부정사"},{"key":"2","text":"동명사"},{"key":"3","text":"분사"},{"key":"4","text":"명사"}]',
  '1', 'promise는 to부정사를 목적어로 취함.'
from te_paragraphs p where p.passage_id = 'a000000e-0000-0000-0000-00000000000e' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"Comprehension drops sharply past a certain point." 의 구조는?',
  'Comprehension drops sharply past a certain point.',
  '[{"key":"1","text":"주어 + 동사 + 부사 + 전치사구"},{"key":"2","text":"수동태"},{"key":"3","text":"가정법"},{"key":"4","text":"도치"}]',
  '1', 'Comprehension drops + sharply(부사) + past a certain point(전치사구).'
from te_paragraphs p where p.passage_id = 'a000000e-0000-0000-0000-00000000000e' and p.ord = 0;

-- p1
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?',
  'A reader who slows down and pauses on hard sentences often finishes the book more slowly.',
  '[{"key":"1","text":"A reader"},{"key":"2","text":"hard sentences"},{"key":"3","text":"the book"},{"key":"4","text":"more slowly"}]',
  '1', '주격 관계절 "who slows down ..."가 A reader를 수식. 본동사 finishes의 주어는 A reader.'
from te_paragraphs p where p.passage_id = 'a000000e-0000-0000-0000-00000000000e' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '주어 A reader에 맞는 본동사 형태는?',
  'A reader ___ the book more slowly but ___ far more of it.',
  '[{"key":"1","text":"finish, remember"},{"key":"2","text":"finishes, remembers (단수)"},{"key":"3","text":"finished, remembered"},{"key":"4","text":"finishing, remembering"}]',
  '2', 'reader(단수) + 현재 → finishes, remembers.'
from te_paragraphs p where p.passage_id = 'a000000e-0000-0000-0000-00000000000e' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"who slows down and pauses on hard sentences" 의 역할은?',
  'A reader who slows down and pauses on hard sentences often finishes the book more slowly.',
  '[{"key":"1","text":"주격 관계절 — A reader 수식"},{"key":"2","text":"명사절"},{"key":"3","text":"부사절"},{"key":"4","text":"분사구문"}]',
  '1', '주격 관계대명사 who가 이끄는 형용사절.'
from te_paragraphs p where p.passage_id = 'a000000e-0000-0000-0000-00000000000e' and p.ord = 1;

-- p2
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?',
  'The real goal of reading is not to finish first.',
  '[{"key":"1","text":"The real goal"},{"key":"2","text":"reading"},{"key":"3","text":"to finish"},{"key":"4","text":"first"}]',
  '1', 'of reading은 수식어. The real goal이 주어.'
from te_paragraphs p where p.passage_id = 'a000000e-0000-0000-0000-00000000000e' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"The real goal of reading is not to finish first." 의 is는?',
  'The real goal of reading is not to finish first.',
  '[{"key":"1","text":"단수 주어 + 현재 be (goal이 단수)"},{"key":"2","text":"복수 주어"},{"key":"3","text":"과거"},{"key":"4","text":"수동태"}]',
  '1', 'goal(단수) → is.'
from te_paragraphs p where p.passage_id = 'a000000e-0000-0000-0000-00000000000e' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"is not to finish first" 에서 to finish의 역할은?',
  'The real goal of reading is not to finish first.',
  '[{"key":"1","text":"to부정사 — 주격 보어 (명사적 용법)"},{"key":"2","text":"형용사적 용법"},{"key":"3","text":"부사적 용법"},{"key":"4","text":"동명사"}]',
  '1', 'is 뒤 보어로 to finish (to부정사 명사적 용법).'
from te_paragraphs p where p.passage_id = 'a000000e-0000-0000-0000-00000000000e' and p.ord = 2;


-- ===== Passage 15: Animals & weather ==================================
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?',
  'Before weather forecasts, farmers watched the world around them.',
  '[{"key":"1","text":"weather forecasts"},{"key":"2","text":"farmers"},{"key":"3","text":"the world"},{"key":"4","text":"them"}]',
  '2', '전치사구 Before weather forecasts를 건너뛰면 farmers.'
from te_paragraphs p where p.passage_id = 'a000000f-0000-0000-0000-00000000000f' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"farmers watched" 의 시제는?',
  'Farmers watched the world around them.',
  '[{"key":"1","text":"과거"},{"key":"2","text":"현재"},{"key":"3","text":"현재완료"},{"key":"4","text":"미래"}]',
  '1', 'watched (과거형).'
from te_paragraphs p where p.passage_id = 'a000000f-0000-0000-0000-00000000000f' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"Birds flying low often meant rain." 에서 flying low는?',
  'Birds flying low often meant rain.',
  '[{"key":"1","text":"현재분사구 — Birds 후치 수식"},{"key":"2","text":"동명사"},{"key":"3","text":"본동사"},{"key":"4","text":"명사"}]',
  '1', '주어 Birds를 꾸미는 현재분사구.'
from te_paragraphs p where p.passage_id = 'a000000f-0000-0000-0000-00000000000f' and p.ord = 0;

-- p1
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?',
  'These signs were not magic.',
  '[{"key":"1","text":"These signs"},{"key":"2","text":"magic"},{"key":"3","text":"not"},{"key":"4","text":"were"}]',
  '1', 'These signs.'
from te_paragraphs p where p.passage_id = 'a000000f-0000-0000-0000-00000000000f' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"These signs were not magic." 의 동사는?',
  'These signs were not magic.',
  '[{"key":"1","text":"was (단수)"},{"key":"2","text":"were (복수, 과거)"},{"key":"3","text":"are"},{"key":"4","text":"is"}]',
  '2', 'signs(복수) + 과거 → were.'
from te_paragraphs p where p.passage_id = 'a000000f-0000-0000-0000-00000000000f' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"Animals feel changes faster than people do" 의 do의 역할은?',
  'Animals feel changes faster than people do.',
  '[{"key":"1","text":"feel을 대신하는 대동사"},{"key":"2","text":"본동사"},{"key":"3","text":"강조"},{"key":"4","text":"수동태 조동사"}]',
  '1', 'than 뒤의 do는 앞의 feel을 대신하는 대동사.'
from te_paragraphs p where p.passage_id = 'a000000f-0000-0000-0000-00000000000f' and p.ord = 1;

-- p2
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?',
  'Modern tools can read the sky from satellites.',
  '[{"key":"1","text":"Modern tools"},{"key":"2","text":"the sky"},{"key":"3","text":"satellites"},{"key":"4","text":"can"}]',
  '1', 'Modern tools.'
from te_paragraphs p where p.passage_id = 'a000000f-0000-0000-0000-00000000000f' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"can read" 의 형태는?',
  'Modern tools can read the sky from satellites.',
  '[{"key":"1","text":"조동사 + 동사원형"},{"key":"2","text":"조동사 + 3인칭 단수"},{"key":"3","text":"수동태"},{"key":"4","text":"가정법"}]',
  '1', 'can + read(원형).'
from te_paragraphs p where p.passage_id = 'a000000f-0000-0000-0000-00000000000f' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"in places where the wind speaks before the radio does" 의 where절은?',
  'It still works in places where the wind speaks before the radio does.',
  '[{"key":"1","text":"관계부사 where 절 — places 수식"},{"key":"2","text":"명사절"},{"key":"3","text":"가정법"},{"key":"4","text":"분사구문"}]',
  '1', '관계부사 where가 장소 명사 places를 수식.'
from te_paragraphs p where p.passage_id = 'a000000f-0000-0000-0000-00000000000f' and p.ord = 2;
