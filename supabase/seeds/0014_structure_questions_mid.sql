-- =====================================================================
-- Structure 객관식 시드: 중(mid) 난이도 20지문 × 3단락 × 3문제 = 180문제
-- 각 단락 ord 0=subject, ord 1=verb, ord 2=structure
-- =====================================================================

-- ============ b0000001 The Trap of Sunk Costs ============
-- para 0
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는 무엇인가요?', 'The only honest question is whether the next hour will be enjoyable.',
  '[{"key":"1","text":"The only honest question"},{"key":"2","text":"whether the next hour"},{"key":"3","text":"the next hour"},{"key":"4","text":"enjoyable"}]', '1',
  '"is"의 주어는 "The only honest question". 뒤의 whether절은 보어.'
from te_paragraphs p where p.passage_id = 'b0000001-0000-0000-0000-000000000001' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"The money ____ gone whether they stay or leave." 빈칸에 알맞은 것은?', 'The money ___ gone whether they stay or leave.',
  '[{"key":"1","text":"are"},{"key":"2","text":"is"},{"key":"3","text":"were"},{"key":"4","text":"have"}]', '2',
  '주어 "money"는 불가산명사로 단수 취급 → is.'
from te_paragraphs p where p.passage_id = 'b0000001-0000-0000-0000-000000000001' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '밑줄 부분 "whether the next hour will be enjoyable"의 문장 내 역할은?', 'The only honest question is whether the next hour will be enjoyable.',
  '[{"key":"1","text":"주어"},{"key":"2","text":"보어 (주격보어)"},{"key":"3","text":"목적어"},{"key":"4","text":"부사구"}]', '2',
  'be동사 뒤의 whether절은 주어 "question"을 설명하는 주격보어.'
from te_paragraphs p where p.passage_id = 'b0000001-0000-0000-0000-000000000001' and p.ord = 0;

-- para 1
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'People keep reading a boring book because they finished half of it.',
  '[{"key":"1","text":"People"},{"key":"2","text":"a boring book"},{"key":"3","text":"they"},{"key":"4","text":"half of it"}]', '1',
  '주절의 동사 "keep"의 주어는 "People".'
from te_paragraphs p where p.passage_id = 'b0000001-0000-0000-0000-000000000001' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"The same logic ____ many decisions." 빈칸에 알맞은 것은?', 'The same logic ___ many decisions.',
  '[{"key":"1","text":"ruin"},{"key":"2","text":"ruins"},{"key":"3","text":"are ruining"},{"key":"4","text":"have ruined"}]', '2',
  '주어 "logic"은 단수 → 3인칭 단수 현재 ruins.'
from te_paragraphs p where p.passage_id = 'b0000001-0000-0000-0000-000000000001' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"because they finished half of it"의 역할은?', 'People keep reading a boring book because they finished half of it.',
  '[{"key":"1","text":"주어절"},{"key":"2","text":"이유를 나타내는 부사절"},{"key":"3","text":"명사절"},{"key":"4","text":"형용사절"}]', '2',
  'because가 이끄는 절은 이유를 나타내는 부사절.'
from te_paragraphs p where p.passage_id = 'b0000001-0000-0000-0000-000000000001' and p.ord = 1;

-- para 2
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'What is already spent cannot come back.',
  '[{"key":"1","text":"What"},{"key":"2","text":"What is already spent"},{"key":"3","text":"already"},{"key":"4","text":"back"}]', '2',
  '명사절 "What is already spent" 전체가 주어 (~한 것은).'
from te_paragraphs p where p.passage_id = 'b0000001-0000-0000-0000-000000000001' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"A good decision ____ forward, not backward." 빈칸에 알맞은 것은?', 'A good decision ___ forward, not backward.',
  '[{"key":"1","text":"look"},{"key":"2","text":"looks"},{"key":"3","text":"looking"},{"key":"4","text":"are looking"}]', '2',
  '주어 "decision"은 단수 → looks.'
from te_paragraphs p where p.passage_id = 'b0000001-0000-0000-0000-000000000001' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"so it should not steer the next step"에서 "so"의 역할은?', 'What is already spent cannot come back, so it should not steer the next step.',
  '[{"key":"1","text":"이유 종속접속사"},{"key":"2","text":"결과를 잇는 등위접속사"},{"key":"3","text":"명사절 접속사"},{"key":"4","text":"전치사"}]', '2',
  '"so"는 결과를 잇는 등위접속사 (그래서).'
from te_paragraphs p where p.passage_id = 'b0000001-0000-0000-0000-000000000001' and p.ord = 2;

-- ============ b0000002 Plastic That Disappears Into Water ============
-- para 0
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'When a plastic bottle reaches the ocean, the sun and salt slowly tear it apart.',
  '[{"key":"1","text":"a plastic bottle"},{"key":"2","text":"the ocean"},{"key":"3","text":"the sun and salt"},{"key":"4","text":"it"}]', '3',
  '주절 동사 "tear"의 주어는 "the sun and salt". 앞은 when 부사절.'
from te_paragraphs p where p.passage_id = 'b0000002-0000-0000-0000-000000000002' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"The sun and salt slowly ____ it apart." 빈칸에 알맞은 것은?', 'The sun and salt slowly ___ it apart.',
  '[{"key":"1","text":"tears"},{"key":"2","text":"tear"},{"key":"3","text":"is tearing"},{"key":"4","text":"has torn"}]', '2',
  '주어 "the sun and salt"는 복수 → tear.'
from te_paragraphs p where p.passage_id = 'b0000002-0000-0000-0000-000000000002' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"When a plastic bottle reaches the ocean"의 역할은?', 'When a plastic bottle reaches the ocean, the sun and salt slowly tear it apart.',
  '[{"key":"1","text":"시간을 나타내는 부사절"},{"key":"2","text":"주어 역할 명사절"},{"key":"3","text":"형용사절"},{"key":"4","text":"보어"}]', '1',
  'When절은 주절의 시점을 알려주는 부사절.'
from te_paragraphs p where p.passage_id = 'b0000002-0000-0000-0000-000000000002' and p.ord = 0;

-- para 1
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'Larger fish eat the small fish.',
  '[{"key":"1","text":"Larger"},{"key":"2","text":"Larger fish"},{"key":"3","text":"the small fish"},{"key":"4","text":"fish"}]', '2',
  '명사구 "Larger fish" 전체가 주어.'
from te_paragraphs p where p.passage_id = 'b0000002-0000-0000-0000-000000000002' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"Small fish ____ the tiny particles." 빈칸에 알맞은 것은?', 'Small fish ___ the tiny particles.',
  '[{"key":"1","text":"swallows"},{"key":"2","text":"swallow"},{"key":"3","text":"is swallowing"},{"key":"4","text":"has swallowed"}]', '2',
  'fish는 단복수 같은 형태이지만 여기선 복수 의미 → swallow.'
from te_paragraphs p where p.passage_id = 'b0000002-0000-0000-0000-000000000002' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"By the time the chain reaches our plates"의 역할은?', 'By the time the chain reaches our plates, the plastic has come back to us.',
  '[{"key":"1","text":"시간 부사절"},{"key":"2","text":"명사절(주어)"},{"key":"3","text":"형용사절"},{"key":"4","text":"전치사구 단독"}]', '1',
  '"By the time ~"은 시간 부사절 (~할 때쯤).'
from te_paragraphs p where p.passage_id = 'b0000002-0000-0000-0000-000000000002' and p.ord = 1;

-- para 2
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'The only real cure is producing less of the material that does not truly go away.',
  '[{"key":"1","text":"The only real cure"},{"key":"2","text":"producing less of the material"},{"key":"3","text":"the material"},{"key":"4","text":"the only real"}]', '1',
  'is의 주어는 "The only real cure". 뒤는 동명사 보어.'
from te_paragraphs p where p.passage_id = 'b0000002-0000-0000-0000-000000000002' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"The problem ____ be cleaned up after the fact." 빈칸에 알맞은 것은?', 'The problem ___ be cleaned up after the fact.',
  '[{"key":"1","text":"cannot"},{"key":"2","text":"have not"},{"key":"3","text":"are not"},{"key":"4","text":"do not"}]', '1',
  '뒤에 동사원형 be가 오므로 조동사 cannot.'
from te_paragraphs p where p.passage_id = 'b0000002-0000-0000-0000-000000000002' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"that does not truly go away"의 수식 대상은?', 'producing less of the material that does not truly go away.',
  '[{"key":"1","text":"producing"},{"key":"2","text":"less"},{"key":"3","text":"the material"},{"key":"4","text":"truly"}]', '3',
  '관계대명사 that이 이끄는 형용사절이 the material을 수식.'
from te_paragraphs p where p.passage_id = 'b0000002-0000-0000-0000-000000000002' and p.ord = 2;

-- ============ b0000003 Why We Notice What We Already Believe ============
-- para 0
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'The mind does not record everything it sees with equal weight.',
  '[{"key":"1","text":"The mind"},{"key":"2","text":"everything"},{"key":"3","text":"it"},{"key":"4","text":"equal weight"}]', '1',
  '주절의 동사 "record"의 주어는 "The mind".'
from te_paragraphs p where p.passage_id = 'b0000003-0000-0000-0000-000000000003' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"It ____ extra attention to facts." 빈칸에 알맞은 것은?', 'It ___ extra attention to facts.',
  '[{"key":"1","text":"pay"},{"key":"2","text":"pays"},{"key":"3","text":"are paying"},{"key":"4","text":"have paid"}]', '2',
  '주어 "It"은 단수 → pays.'
from te_paragraphs p where p.passage_id = 'b0000003-0000-0000-0000-000000000003' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"that match what we already think"의 수식 대상은?', 'facts that match what we already think',
  '[{"key":"1","text":"facts"},{"key":"2","text":"attention"},{"key":"3","text":"mind"},{"key":"4","text":"weight"}]', '1',
  '관계대명사 that 절이 facts를 수식.'
from te_paragraphs p where p.passage_id = 'b0000003-0000-0000-0000-000000000003' and p.ord = 0;

-- para 1
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'This bias is hard to feel from inside.',
  '[{"key":"1","text":"This bias"},{"key":"2","text":"hard"},{"key":"3","text":"to feel"},{"key":"4","text":"inside"}]', '1',
  '주어는 "This bias". 뒤는 형용사+to부정사 보어.'
from te_paragraphs p where p.passage_id = 'b0000003-0000-0000-0000-000000000003' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"The skipped facts never ____ a mark." 빈칸에 알맞은 것은?', 'The skipped facts never ___ a mark.',
  '[{"key":"1","text":"leaves"},{"key":"2","text":"leave"},{"key":"3","text":"is leaving"},{"key":"4","text":"has left"}]', '2',
  '주어 "facts"는 복수 → leave.'
from te_paragraphs p where p.passage_id = 'b0000003-0000-0000-0000-000000000003' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"so it seems like the world simply lined up with our view"에서 "so"의 역할은?', 'The skipped facts never leave a mark, so it seems like the world simply lined up with our view.',
  '[{"key":"1","text":"이유 종속접속사"},{"key":"2","text":"결과 등위접속사"},{"key":"3","text":"명사절 접속사"},{"key":"4","text":"전치사"}]', '2',
  '"so"는 결과를 잇는 등위접속사.'
from te_paragraphs p where p.passage_id = 'b0000003-0000-0000-0000-000000000003' and p.ord = 1;

-- para 2
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'The remedy is uncomfortable.',
  '[{"key":"1","text":"The remedy"},{"key":"2","text":"uncomfortable"},{"key":"3","text":"is"},{"key":"4","text":"the"}]', '1',
  '주어 "The remedy", 보어 "uncomfortable".'
from te_paragraphs p where p.passage_id = 'b0000003-0000-0000-0000-000000000003' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"We ____ to seek out the very evidence we would rather avoid." 빈칸에 알맞은 것은?', 'We ___ to seek out the very evidence we would rather avoid.',
  '[{"key":"1","text":"has"},{"key":"2","text":"have"},{"key":"3","text":"is having"},{"key":"4","text":"having"}]', '2',
  '주어 We는 1인칭 복수 → have.'
from te_paragraphs p where p.passage_id = 'b0000003-0000-0000-0000-000000000003' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"we would rather avoid"의 역할은? (앞 명사와의 관계)', 'the very evidence we would rather avoid',
  '[{"key":"1","text":"evidence를 수식하는 관계절 (관계대명사 생략)"},{"key":"2","text":"부사절"},{"key":"3","text":"주어절"},{"key":"4","text":"보어"}]', '1',
  '목적격 관계대명사 that/which가 생략된 형용사절이 evidence를 수식.'
from te_paragraphs p where p.passage_id = 'b0000003-0000-0000-0000-000000000003' and p.ord = 2;

-- ============ b0000004 How an Algorithm Builds a Bubble ============
-- para 0
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'An algorithm has one job: predict what will keep your eyes on the screen.',
  '[{"key":"1","text":"An algorithm"},{"key":"2","text":"one job"},{"key":"3","text":"your eyes"},{"key":"4","text":"the screen"}]', '1',
  '동사 "has"의 주어는 "An algorithm".'
from te_paragraphs p where p.passage_id = 'b0000004-0000-0000-0000-000000000004' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"It ____ from every pause, every replay, every scroll." 빈칸에 알맞은 것은?', 'It ___ from every pause, every replay, every scroll.',
  '[{"key":"1","text":"learn"},{"key":"2","text":"learns"},{"key":"3","text":"are learning"},{"key":"4","text":"have learned"}]', '2',
  '주어 It은 3인칭 단수 → learns.'
from te_paragraphs p where p.passage_id = 'b0000004-0000-0000-0000-000000000004' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"what will keep your eyes on the screen"의 역할은?', 'predict what will keep your eyes on the screen.',
  '[{"key":"1","text":"predict의 목적어 명사절"},{"key":"2","text":"부사절"},{"key":"3","text":"형용사절"},{"key":"4","text":"보어"}]', '1',
  '관계대명사 what이 이끄는 명사절이 predict의 목적어.'
from te_paragraphs p where p.passage_id = 'b0000004-0000-0000-0000-000000000004' and p.ord = 0;

-- para 1
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'The system shows what you already like, not what might broaden your view.',
  '[{"key":"1","text":"The system"},{"key":"2","text":"what you already like"},{"key":"3","text":"you"},{"key":"4","text":"your view"}]', '1',
  '동사 "shows"의 주어는 "The system".'
from te_paragraphs p where p.passage_id = 'b0000004-0000-0000-0000-000000000004' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"Over weeks, the predictions ____ accurate, but also narrow." 빈칸에 알맞은 것은?', 'Over weeks, the predictions ___ accurate, but also narrow.',
  '[{"key":"1","text":"becomes"},{"key":"2","text":"become"},{"key":"3","text":"is becoming"},{"key":"4","text":"has become"}]', '2',
  '주어 "predictions"는 복수 → become.'
from te_paragraphs p where p.passage_id = 'b0000004-0000-0000-0000-000000000004' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"what might broaden your view"의 역할은?', 'not what might broaden your view',
  '[{"key":"1","text":"shows의 목적어인 명사절"},{"key":"2","text":"부사절"},{"key":"3","text":"형용사절"},{"key":"4","text":"전치사구"}]', '1',
  '관계대명사 what절이 shows의 두 번째 목적어 (병렬).'
from te_paragraphs p where p.passage_id = 'b0000004-0000-0000-0000-000000000004' and p.ord = 1;

-- para 2
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'Breaking out of this bubble requires effort the system will not provide.',
  '[{"key":"1","text":"Breaking out of this bubble"},{"key":"2","text":"this bubble"},{"key":"3","text":"effort"},{"key":"4","text":"the system"}]', '1',
  '동명사구 "Breaking out of this bubble" 전체가 주어.'
from te_paragraphs p where p.passage_id = 'b0000004-0000-0000-0000-000000000004' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"You ____ to deliberately seek out voices the feed never serves you." 빈칸에 알맞은 것은?', 'You ___ to deliberately seek out voices the feed never serves you.',
  '[{"key":"1","text":"has"},{"key":"2","text":"have"},{"key":"3","text":"is"},{"key":"4","text":"having"}]', '2',
  '주어 You → have.'
from te_paragraphs p where p.passage_id = 'b0000004-0000-0000-0000-000000000004' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"the feed never serves you"의 역할은?', 'voices the feed never serves you',
  '[{"key":"1","text":"voices를 수식하는 관계절 (목적격 관계대명사 생략)"},{"key":"2","text":"부사절"},{"key":"3","text":"보어"},{"key":"4","text":"독립절"}]', '1',
  '목적격 관계대명사 생략된 형용사절이 voices 수식.'
from te_paragraphs p where p.passage_id = 'b0000004-0000-0000-0000-000000000004' and p.ord = 2;

-- ============ b0000005 The Silk Road Was More Than Silk ============
-- para 0
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'They carried ideas, religions, recipes, instruments, and diseases.',
  '[{"key":"1","text":"They"},{"key":"2","text":"ideas"},{"key":"3","text":"religions"},{"key":"4","text":"diseases"}]', '1',
  '동사 "carried"의 주어는 "They" (앞 문장의 traders).'
from te_paragraphs p where p.passage_id = 'b0000005-0000-0000-0000-000000000005' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"Traders ____ more than goods." 빈칸에 알맞은 것은?', 'Along the Silk Road, traders ___ more than goods.',
  '[{"key":"1","text":"carries"},{"key":"2","text":"carried"},{"key":"3","text":"is carrying"},{"key":"4","text":"has carried"}]', '2',
  '주어 traders는 복수, 과거 사실 → carried.'
from te_paragraphs p where p.passage_id = 'b0000005-0000-0000-0000-000000000005' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"Along the Silk Road"의 역할은?', 'Along the Silk Road, traders carried more than goods.',
  '[{"key":"1","text":"장소를 나타내는 전치사구 (부사 역할)"},{"key":"2","text":"주어"},{"key":"3","text":"보어"},{"key":"4","text":"명사절"}]', '1',
  '전치사구 "Along the Silk Road"는 장소를 나타내는 부사구.'
from te_paragraphs p where p.passage_id = 'b0000005-0000-0000-0000-000000000005' and p.ord = 0;

-- para 1
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'Whole faiths spread along the same routes that carried spices.',
  '[{"key":"1","text":"Whole faiths"},{"key":"2","text":"the same routes"},{"key":"3","text":"spices"},{"key":"4","text":"along"}]', '1',
  '동사 "spread"의 주어는 "Whole faiths".'
from te_paragraphs p where p.passage_id = 'b0000005-0000-0000-0000-000000000005' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"A piece of writing ____ copied into another in a market town." 빈칸에 알맞은 것은?', 'A piece of writing ___ copied into another in a market town.',
  '[{"key":"1","text":"were"},{"key":"2","text":"was"},{"key":"3","text":"are"},{"key":"4","text":"have"}]', '2',
  '주어 "A piece"는 단수, 수동태 과거 → was copied.'
from te_paragraphs p where p.passage_id = 'b0000005-0000-0000-0000-000000000005' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"that carried spices"의 수식 대상은?', 'the same routes that carried spices',
  '[{"key":"1","text":"faiths"},{"key":"2","text":"routes"},{"key":"3","text":"spices"},{"key":"4","text":"market town"}]', '2',
  '관계대명사 that 절이 routes를 수식.'
from te_paragraphs p where p.passage_id = 'b0000005-0000-0000-0000-000000000005' and p.ord = 1;

-- para 2
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'The lesson is that trade routes are never only about trade.',
  '[{"key":"1","text":"The lesson"},{"key":"2","text":"trade routes"},{"key":"3","text":"trade"},{"key":"4","text":"that"}]', '1',
  '주어는 "The lesson". 뒤의 that절은 보어.'
from te_paragraphs p where p.passage_id = 'b0000005-0000-0000-0000-000000000005' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"Trade routes ____ never only about trade." 빈칸에 알맞은 것은?', 'Trade routes ___ never only about trade.',
  '[{"key":"1","text":"is"},{"key":"2","text":"are"},{"key":"3","text":"has"},{"key":"4","text":"was"}]', '2',
  '주어 "routes"는 복수 → are.'
from te_paragraphs p where p.passage_id = 'b0000005-0000-0000-0000-000000000005' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"that trade routes are never only about trade"의 역할은?', 'The lesson is that trade routes are never only about trade.',
  '[{"key":"1","text":"보어 (주격보어 명사절)"},{"key":"2","text":"부사절"},{"key":"3","text":"관계절"},{"key":"4","text":"주어절"}]', '1',
  'be동사 뒤 that절은 The lesson을 설명하는 보어.'
from te_paragraphs p where p.passage_id = 'b0000005-0000-0000-0000-000000000005' and p.ord = 2;

-- ============ b0000006 When Painters Discovered Depth ============
-- para 0
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'In medieval art, distant people are sometimes drawn larger than nearby ones.',
  '[{"key":"1","text":"medieval art"},{"key":"2","text":"distant people"},{"key":"3","text":"nearby ones"},{"key":"4","text":"larger"}]', '2',
  'are drawn의 주어는 "distant people".'
from te_paragraphs p where p.passage_id = 'b0000006-0000-0000-0000-000000000006' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"The size ____ meaning, not distance." 빈칸에 알맞은 것은?', 'The size ___ meaning, not distance.',
  '[{"key":"1","text":"show"},{"key":"2","text":"showed"},{"key":"3","text":"have shown"},{"key":"4","text":"is showing"}]', '2',
  '주어 "size"는 단수, 과거 사실 → showed.'
from te_paragraphs p where p.passage_id = 'b0000006-0000-0000-0000-000000000006' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"because they were more important to the story"의 역할은?', 'distant people are sometimes drawn larger than nearby ones, because they were more important to the story.',
  '[{"key":"1","text":"이유 부사절"},{"key":"2","text":"주어절"},{"key":"3","text":"보어절"},{"key":"4","text":"형용사절"}]', '1',
  'because 절은 이유를 나타내는 부사절.'
from te_paragraphs p where p.passage_id = 'b0000006-0000-0000-0000-000000000006' and p.ord = 0;

-- para 1
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'Lines that ran away from the viewer met at a single hidden point.',
  '[{"key":"1","text":"Lines"},{"key":"2","text":"the viewer"},{"key":"3","text":"a single hidden point"},{"key":"4","text":"that"}]', '1',
  '동사 "met"의 주어는 "Lines". 사이의 that 절은 형용사절.'
from te_paragraphs p where p.passage_id = 'b0000006-0000-0000-0000-000000000006' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"In the Renaissance, painters ____ out the geometry of perspective." 빈칸에 알맞은 것은?', 'In the Renaissance, painters ___ out the geometry of perspective.',
  '[{"key":"1","text":"works"},{"key":"2","text":"worked"},{"key":"3","text":"is working"},{"key":"4","text":"has worked"}]', '2',
  '주어 painters는 복수, 과거 사실 → worked.'
from te_paragraphs p where p.passage_id = 'b0000006-0000-0000-0000-000000000006' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"that ran away from the viewer"의 역할은?', 'Lines that ran away from the viewer met at a single hidden point.',
  '[{"key":"1","text":"Lines를 수식하는 형용사절"},{"key":"2","text":"부사절"},{"key":"3","text":"명사절"},{"key":"4","text":"보어"}]', '1',
  '관계대명사 that이 이끄는 형용사절이 Lines를 수식.'
from te_paragraphs p where p.passage_id = 'b0000006-0000-0000-0000-000000000006' and p.ord = 1;

-- para 2
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'It was not that earlier artists could not see depth.',
  '[{"key":"1","text":"It"},{"key":"2","text":"earlier artists"},{"key":"3","text":"depth"},{"key":"4","text":"that"}]', '1',
  '가주어 It-진주어 that절 구문. 형식 주어는 It.'
from te_paragraphs p where p.passage_id = 'b0000006-0000-0000-0000-000000000006' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"When the goal changed, the technique ____." 빈칸에 알맞은 것은?', 'When the goal changed, the technique ___.',
  '[{"key":"1","text":"follow"},{"key":"2","text":"followed"},{"key":"3","text":"is following"},{"key":"4","text":"have followed"}]', '2',
  '시간 일치, 단수 주어 technique → followed.'
from te_paragraphs p where p.passage_id = 'b0000006-0000-0000-0000-000000000006' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"When the goal changed"의 역할은?', 'When the goal changed, the technique followed.',
  '[{"key":"1","text":"시간 부사절"},{"key":"2","text":"명사절"},{"key":"3","text":"형용사절"},{"key":"4","text":"보어"}]', '1',
  'When 절은 시간을 나타내는 부사절.'
from te_paragraphs p where p.passage_id = 'b0000006-0000-0000-0000-000000000006' and p.ord = 2;

-- ============ b0000007 A Sugar Pill That Heals ============
-- para 0
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'A patient who believes a pill will help often reports less pain.',
  '[{"key":"1","text":"A patient"},{"key":"2","text":"a pill"},{"key":"3","text":"less pain"},{"key":"4","text":"who"}]', '1',
  '주어는 "A patient", 그 뒤 who절은 형용사절.'
from te_paragraphs p where p.passage_id = 'b0000007-0000-0000-0000-000000000007' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"This ____ called the placebo effect." 빈칸에 알맞은 것은?', 'This ___ called the placebo effect.',
  '[{"key":"1","text":"are"},{"key":"2","text":"is"},{"key":"3","text":"have"},{"key":"4","text":"were"}]', '2',
  '주어 This는 단수, 수동태 → is called.'
from te_paragraphs p where p.passage_id = 'b0000007-0000-0000-0000-000000000007' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"who believes a pill will help"의 역할은?', 'A patient who believes a pill will help often reports less pain.',
  '[{"key":"1","text":"A patient을 수식하는 형용사절"},{"key":"2","text":"부사절"},{"key":"3","text":"보어"},{"key":"4","text":"명사절"}]', '1',
  '관계대명사 who 절이 A patient 수식.'
from te_paragraphs p where p.passage_id = 'b0000007-0000-0000-0000-000000000007' and p.ord = 0;

-- para 1
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'Brain scans show that expectation alone can trigger the release of natural painkillers.',
  '[{"key":"1","text":"Brain scans"},{"key":"2","text":"expectation"},{"key":"3","text":"the release"},{"key":"4","text":"natural painkillers"}]', '1',
  '동사 "show"의 주어는 "Brain scans".'
from te_paragraphs p where p.passage_id = 'b0000007-0000-0000-0000-000000000007' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"The body really ____." 빈칸에 알맞은 것은?', 'The healing is not imaginary; the body really ___.',
  '[{"key":"1","text":"shift"},{"key":"2","text":"shifts"},{"key":"3","text":"are shifting"},{"key":"4","text":"have shifted"}]', '2',
  '주어 "body"는 단수 → shifts.'
from te_paragraphs p where p.passage_id = 'b0000007-0000-0000-0000-000000000007' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"that expectation alone can trigger the release of natural painkillers"의 역할은?', 'Brain scans show that expectation alone can trigger the release of natural painkillers.',
  '[{"key":"1","text":"show의 목적어 명사절"},{"key":"2","text":"부사절"},{"key":"3","text":"형용사절"},{"key":"4","text":"보어"}]', '1',
  '접속사 that절이 동사 show의 목적어.'
from te_paragraphs p where p.passage_id = 'b0000007-0000-0000-0000-000000000007' and p.ord = 1;

-- para 2
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'This does not mean medicine is unnecessary.',
  '[{"key":"1","text":"This"},{"key":"2","text":"medicine"},{"key":"3","text":"unnecessary"},{"key":"4","text":"not"}]', '1',
  '동사 "does not mean"의 주어는 "This".'
from te_paragraphs p where p.passage_id = 'b0000007-0000-0000-0000-000000000007' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"Hope, trust, and ritual ____ quietly working alongside the chemistry." 빈칸에 알맞은 것은?', 'Hope, trust, and ritual ___ quietly working alongside the chemistry.',
  '[{"key":"1","text":"is"},{"key":"2","text":"are"},{"key":"3","text":"has"},{"key":"4","text":"was"}]', '2',
  '주어가 세 개로 복수 → are.'
from te_paragraphs p where p.passage_id = 'b0000007-0000-0000-0000-000000000007' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"medicine is unnecessary"의 역할은? (앞 문장에서)', 'This does not mean medicine is unnecessary.',
  '[{"key":"1","text":"mean의 목적어 명사절 (that 생략)"},{"key":"2","text":"부사절"},{"key":"3","text":"형용사절"},{"key":"4","text":"독립절"}]', '1',
  '접속사 that이 생략된 명사절이 mean의 목적어.'
from te_paragraphs p where p.passage_id = 'b0000007-0000-0000-0000-000000000007' and p.ord = 2;

-- ============ b0000008 When Villages Become Cities ============
-- para 0
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'In 1900, only one in seven people lived in a city.',
  '[{"key":"1","text":"1900"},{"key":"2","text":"one in seven people"},{"key":"3","text":"a city"},{"key":"4","text":"only"}]', '2',
  '"only one in seven people" 전체가 주어.'
from te_paragraphs p where p.passage_id = 'b0000008-0000-0000-0000-000000000008' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"Today more than half of the world ____ urban." 빈칸에 알맞은 것은?', 'Today more than half of the world ___ urban.',
  '[{"key":"1","text":"are"},{"key":"2","text":"is"},{"key":"3","text":"have"},{"key":"4","text":"were"}]', '2',
  '"half of the world" 단수 취급 → is.'
from te_paragraphs p where p.passage_id = 'b0000008-0000-0000-0000-000000000008' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"In 1900"의 역할은?', 'In 1900, only one in seven people lived in a city.',
  '[{"key":"1","text":"시간을 나타내는 전치사구"},{"key":"2","text":"주어"},{"key":"3","text":"보어"},{"key":"4","text":"형용사구"}]', '1',
  '전치사구 "In 1900"은 부사 역할 (시간).'
from te_paragraphs p where p.passage_id = 'b0000008-0000-0000-0000-000000000008' and p.ord = 0;

-- para 1
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'Cities make jobs and ideas easier to find.',
  '[{"key":"1","text":"Cities"},{"key":"2","text":"jobs and ideas"},{"key":"3","text":"easier"},{"key":"4","text":"find"}]', '1',
  '주어 Cities, 5형식 (목적어 jobs and ideas, 목적격보어 easier).'
from te_paragraphs p where p.passage_id = 'b0000008-0000-0000-0000-000000000008' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"The benefits and the costs ____ together." 빈칸에 알맞은 것은?', 'The benefits and the costs ___ together.',
  '[{"key":"1","text":"grows"},{"key":"2","text":"grow"},{"key":"3","text":"is growing"},{"key":"4","text":"has grown"}]', '2',
  '주어가 두 개로 복수 → grow.'
from te_paragraphs p where p.passage_id = 'b0000008-0000-0000-0000-000000000008' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"easier to find"의 역할은?', 'Cities make jobs and ideas easier to find.',
  '[{"key":"1","text":"목적격 보어 (목적어 jobs and ideas를 설명)"},{"key":"2","text":"주격 보어"},{"key":"3","text":"부사구"},{"key":"4","text":"독립된 절"}]', '1',
  'make + 목적어 + 형용사 → 5형식의 목적격보어.'
from te_paragraphs p where p.passage_id = 'b0000008-0000-0000-0000-000000000008' and p.ord = 1;

-- para 2
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'The future of urban life is not whether to grow but how.',
  '[{"key":"1","text":"The future of urban life"},{"key":"2","text":"urban life"},{"key":"3","text":"whether"},{"key":"4","text":"how"}]', '1',
  'is의 주어는 "The future of urban life".'
from te_paragraphs p where p.passage_id = 'b0000008-0000-0000-0000-000000000008' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"Cities that plan ahead ____ differently from cities that grow only because people arrive." 빈칸에 알맞은 것은?', 'Cities that plan ahead ___ differently from cities that grow only because people arrive.',
  '[{"key":"1","text":"lives"},{"key":"2","text":"live"},{"key":"3","text":"is living"},{"key":"4","text":"has lived"}]', '2',
  '주어 Cities는 복수 → live.'
from te_paragraphs p where p.passage_id = 'b0000008-0000-0000-0000-000000000008' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"that plan ahead"의 역할은?', 'Cities that plan ahead live differently.',
  '[{"key":"1","text":"Cities를 수식하는 형용사절"},{"key":"2","text":"부사절"},{"key":"3","text":"명사절(주어)"},{"key":"4","text":"보어"}]', '1',
  '관계대명사 that 절이 Cities를 수식.'
from te_paragraphs p where p.passage_id = 'b0000008-0000-0000-0000-000000000008' and p.ord = 2;

-- ============ b0000009 The Old Argument About Free Choice ============
-- para 0
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'Genes, culture, hunger, sleep, and the mood of the moment all push the decision in directions we barely notice.',
  '[{"key":"1","text":"Genes, culture, hunger, sleep, and the mood of the moment"},{"key":"2","text":"the decision"},{"key":"3","text":"directions"},{"key":"4","text":"we"}]', '1',
  '여러 명사가 and로 묶인 복합 주어.'
from te_paragraphs p where p.passage_id = 'b0000009-0000-0000-0000-000000000009' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"Every choice we make ____ on a long history." 빈칸에 알맞은 것은?', 'Every choice we make ___ on a long history.',
  '[{"key":"1","text":"rest"},{"key":"2","text":"rests"},{"key":"3","text":"are resting"},{"key":"4","text":"have rested"}]', '2',
  '주어 "Every choice"는 단수 → rests.'
from te_paragraphs p where p.passage_id = 'b0000009-0000-0000-0000-000000000009' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"we barely notice"의 역할은?', 'in directions we barely notice',
  '[{"key":"1","text":"directions를 수식하는 관계절 (관계대명사 생략)"},{"key":"2","text":"부사절"},{"key":"3","text":"보어"},{"key":"4","text":"독립절"}]', '1',
  '목적격 관계대명사 that/which가 생략된 형용사절.'
from te_paragraphs p where p.passage_id = 'b0000009-0000-0000-0000-000000000009' and p.ord = 0;

-- para 1
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'Some philosophers argue this leaves no room for a free choice at all.',
  '[{"key":"1","text":"Some philosophers"},{"key":"2","text":"this"},{"key":"3","text":"no room"},{"key":"4","text":"a free choice"}]', '1',
  '주절의 동사 argue의 주어는 "Some philosophers".'
from te_paragraphs p where p.passage_id = 'b0000009-0000-0000-0000-000000000009' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"Others ____ freedom is not freedom from causes." 빈칸에 알맞은 것은?', 'Others ___ freedom is not freedom from causes.',
  '[{"key":"1","text":"says"},{"key":"2","text":"say"},{"key":"3","text":"is saying"},{"key":"4","text":"has said"}]', '2',
  '주어 Others는 복수 → say.'
from te_paragraphs p where p.passage_id = 'b0000009-0000-0000-0000-000000000009' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"this leaves no room for a free choice at all"의 역할은?', 'Some philosophers argue this leaves no room for a free choice at all.',
  '[{"key":"1","text":"argue의 목적어 명사절 (that 생략)"},{"key":"2","text":"부사절"},{"key":"3","text":"형용사절"},{"key":"4","text":"보어"}]', '1',
  '접속사 that이 생략된 명사절이 argue의 목적어.'
from te_paragraphs p where p.passage_id = 'b0000009-0000-0000-0000-000000000009' and p.ord = 1;

-- para 2
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'A decision made with awareness still feels different from one made on autopilot.',
  '[{"key":"1","text":"A decision"},{"key":"2","text":"awareness"},{"key":"3","text":"one"},{"key":"4","text":"autopilot"}]', '1',
  '주어는 "A decision". made 이하는 수식어.'
from te_paragraphs p where p.passage_id = 'b0000009-0000-0000-0000-000000000009' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"Whichever side you take, the question itself ____ the way you act." 빈칸에 알맞은 것은?', 'Whichever side you take, the question itself ___ the way you act.',
  '[{"key":"1","text":"sharpen"},{"key":"2","text":"sharpens"},{"key":"3","text":"are sharpening"},{"key":"4","text":"have sharpened"}]', '2',
  '주어 "the question"은 단수 → sharpens.'
from te_paragraphs p where p.passage_id = 'b0000009-0000-0000-0000-000000000009' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"made with awareness"의 역할은?', 'A decision made with awareness still feels different.',
  '[{"key":"1","text":"A decision을 수식하는 과거분사구 (형용사 역할)"},{"key":"2","text":"동사"},{"key":"3","text":"부사구"},{"key":"4","text":"독립절"}]', '1',
  '과거분사구가 A decision을 뒤에서 수식.'
from te_paragraphs p where p.passage_id = 'b0000009-0000-0000-0000-000000000009' and p.ord = 2;

-- ============ b000000a High Context, Low Context ============
-- para 0
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'People rely on the words to carry the meaning.',
  '[{"key":"1","text":"People"},{"key":"2","text":"the words"},{"key":"3","text":"the meaning"},{"key":"4","text":"to carry"}]', '1',
  '동사 rely의 주어는 People.'
from te_paragraphs p where p.passage_id = 'b000000a-0000-0000-0000-00000000000a' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"A clear, direct sentence ____ polite." 빈칸에 알맞은 것은?', 'In a low-context culture, a clear, direct sentence ___ polite.',
  '[{"key":"1","text":"are"},{"key":"2","text":"is"},{"key":"3","text":"have"},{"key":"4","text":"were"}]', '2',
  '주어 "a clear, direct sentence"는 단수 → is.'
from te_paragraphs p where p.passage_id = 'b000000a-0000-0000-0000-00000000000a' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"In a low-context culture"의 역할은?', 'In a low-context culture, a clear, direct sentence is polite.',
  '[{"key":"1","text":"전치사구로 부사 역할"},{"key":"2","text":"주어"},{"key":"3","text":"보어"},{"key":"4","text":"명사절"}]', '1',
  '전치사구가 부사 역할 (조건/장소).'
from te_paragraphs p where p.passage_id = 'b000000a-0000-0000-0000-00000000000a' and p.ord = 0;

-- para 1
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'Listeners read the relationship, the tone, and the silence as carefully as the words themselves.',
  '[{"key":"1","text":"Listeners"},{"key":"2","text":"the relationship"},{"key":"3","text":"the words themselves"},{"key":"4","text":"the silence"}]', '1',
  '동사 read의 주어는 "Listeners".'
from te_paragraphs p where p.passage_id = 'b000000a-0000-0000-0000-00000000000a' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"A direct sentence ____ feel rude." 빈칸에 알맞은 것은?', 'In a high-context culture, a direct sentence ___ feel rude.',
  '[{"key":"1","text":"can"},{"key":"2","text":"have"},{"key":"3","text":"are"},{"key":"4","text":"is"}]', '1',
  '뒤에 동사원형 feel이 오므로 조동사 can.'
from te_paragraphs p where p.passage_id = 'b000000a-0000-0000-0000-00000000000a' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"as carefully as the words themselves"의 역할은?', 'Listeners read ... as carefully as the words themselves.',
  '[{"key":"1","text":"부사 비교구문 (as ~ as)"},{"key":"2","text":"명사절"},{"key":"3","text":"형용사절"},{"key":"4","text":"주어"}]', '1',
  'as 부사 as 의 동등비교 구문.'
from te_paragraphs p where p.passage_id = 'b000000a-0000-0000-0000-00000000000a' and p.ord = 1;

-- para 2
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'Misunderstandings often come from style, not from disagreement.',
  '[{"key":"1","text":"Misunderstandings"},{"key":"2","text":"style"},{"key":"3","text":"disagreement"},{"key":"4","text":"often"}]', '1',
  '동사 come의 주어는 "Misunderstandings".'
from te_paragraphs p where p.passage_id = 'b000000a-0000-0000-0000-00000000000a' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"A speaker from one tradition ____ saying yes." 빈칸에 알맞은 것은?', 'A speaker from one tradition ___ saying yes.',
  '[{"key":"1","text":"may be"},{"key":"2","text":"may are"},{"key":"3","text":"are"},{"key":"4","text":"have"}]', '1',
  '"may + be ~ing" 진행 추측. 주어 단수 + 조동사 may + be.'
from te_paragraphs p where p.passage_id = 'b000000a-0000-0000-0000-00000000000a' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"while the listener from another tradition hears no"의 역할은?', 'A speaker may be saying yes while the listener from another tradition hears no.',
  '[{"key":"1","text":"대조를 나타내는 부사절"},{"key":"2","text":"명사절"},{"key":"3","text":"형용사절"},{"key":"4","text":"보어"}]', '1',
  '"while"은 대조/시간 부사절. 여기선 대조 의미.'
from te_paragraphs p where p.passage_id = 'b000000a-0000-0000-0000-00000000000a' and p.ord = 2;

-- ============ b000000b The Body Clock Inside You ============
-- para 0
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'Their bodies still cycled close to a twenty-four-hour rhythm.',
  '[{"key":"1","text":"Their bodies"},{"key":"2","text":"a twenty-four-hour rhythm"},{"key":"3","text":"close"},{"key":"4","text":"still"}]', '1',
  '동사 cycled의 주어는 "Their bodies".'
from te_paragraphs p where p.passage_id = 'b000000b-0000-0000-0000-00000000000b' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"Volunteers ____ for weeks in caves with no sunlight." 빈칸에 알맞은 것은?', 'In experiments, volunteers ___ for weeks in caves with no sunlight.',
  '[{"key":"1","text":"has lived"},{"key":"2","text":"have lived"},{"key":"3","text":"is living"},{"key":"4","text":"lives"}]', '2',
  '주어 volunteers 복수 + 현재완료 → have lived.'
from te_paragraphs p where p.passage_id = 'b000000b-0000-0000-0000-00000000000b' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"with no sunlight and no clocks"의 역할은?', 'in caves with no sunlight and no clocks',
  '[{"key":"1","text":"caves를 수식하는 전치사구"},{"key":"2","text":"부사절"},{"key":"3","text":"명사절"},{"key":"4","text":"독립절"}]', '1',
  '전치사구 with ~ 가 caves를 수식 (형용사 역할).'
from te_paragraphs p where p.passage_id = 'b000000b-0000-0000-0000-00000000000b' and p.ord = 0;

-- para 1
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'This internal clock controls more than sleep.',
  '[{"key":"1","text":"This internal clock"},{"key":"2","text":"more than sleep"},{"key":"3","text":"sleep"},{"key":"4","text":"more"}]', '1',
  '동사 controls의 주어는 "This internal clock".'
from te_paragraphs p where p.passage_id = 'b000000b-0000-0000-0000-00000000000b' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"It ____ the timing of hormone release, body temperature, and ..." 빈칸에 알맞은 것은?', 'It ___ the timing of hormone release, body temperature, and the strength of the immune system.',
  '[{"key":"1","text":"set"},{"key":"2","text":"sets"},{"key":"3","text":"are setting"},{"key":"4","text":"have set"}]', '2',
  '주어 It은 단수 → sets.'
from te_paragraphs p where p.passage_id = 'b000000b-0000-0000-0000-00000000000b' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"at different hours of the day"의 역할은?', 'the strength of the immune system at different hours of the day',
  '[{"key":"1","text":"시간을 나타내는 전치사구 (부사)"},{"key":"2","text":"주어"},{"key":"3","text":"보어"},{"key":"4","text":"명사절"}]', '1',
  '시간을 나타내는 부사구.'
from te_paragraphs p where p.passage_id = 'b000000b-0000-0000-0000-00000000000b' and p.ord = 1;

-- para 2
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'Working long night shifts forces the body to fight its own clock.',
  '[{"key":"1","text":"Working long night shifts"},{"key":"2","text":"the body"},{"key":"3","text":"its own clock"},{"key":"4","text":"shifts"}]', '1',
  '동명사구 "Working long night shifts" 전체가 주어.'
from te_paragraphs p where p.passage_id = 'b000000b-0000-0000-0000-00000000000b' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"Over years, the fight ____ measurable health costs." 빈칸에 알맞은 것은?', 'Over years, the fight ___ measurable health costs.',
  '[{"key":"1","text":"have"},{"key":"2","text":"has"},{"key":"3","text":"are having"},{"key":"4","text":"having"}]', '2',
  '주어 the fight 단수 → has.'
from te_paragraphs p where p.passage_id = 'b000000b-0000-0000-0000-00000000000b' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"to fight its own clock"의 역할은?', 'Working long night shifts forces the body to fight its own clock.',
  '[{"key":"1","text":"force의 목적격 보어 (to부정사)"},{"key":"2","text":"주어"},{"key":"3","text":"형용사절"},{"key":"4","text":"부사절"}]', '1',
  'force + 목적어 + to부정사 구문의 목적격보어.'
from te_paragraphs p where p.passage_id = 'b000000b-0000-0000-0000-00000000000b' and p.ord = 2;

-- ============ b000000c What You Give Up by Choosing ============
-- para 0
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'You are also choosing not to have any other flavor in the case.',
  '[{"key":"1","text":"You"},{"key":"2","text":"any other flavor"},{"key":"3","text":"the case"},{"key":"4","text":"to have"}]', '1',
  '주어 You, 동사 are choosing.'
from te_paragraphs p where p.passage_id = 'b000000c-0000-0000-0000-00000000000c' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"When you pick chocolate ice cream, you ____ not only choosing chocolate." 빈칸에 알맞은 것은?', 'When you pick chocolate ice cream, you ___ not only choosing chocolate.',
  '[{"key":"1","text":"is"},{"key":"2","text":"are"},{"key":"3","text":"has"},{"key":"4","text":"have"}]', '2',
  '주어 you 진행형 → are choosing.'
from te_paragraphs p where p.passage_id = 'b000000c-0000-0000-0000-00000000000c' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"When you pick chocolate ice cream"의 역할은?', 'When you pick chocolate ice cream, you are not only choosing chocolate.',
  '[{"key":"1","text":"시간 부사절"},{"key":"2","text":"명사절"},{"key":"3","text":"형용사절"},{"key":"4","text":"보어"}]', '1',
  'When 절은 시간/조건의 부사절.'
from te_paragraphs p where p.passage_id = 'b000000c-0000-0000-0000-00000000000c' and p.ord = 0;

-- para 1
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'Economists call the value of the option you gave up the opportunity cost.',
  '[{"key":"1","text":"Economists"},{"key":"2","text":"the value"},{"key":"3","text":"the option"},{"key":"4","text":"the opportunity cost"}]', '1',
  '동사 call의 주어는 "Economists".'
from te_paragraphs p where p.passage_id = 'b000000c-0000-0000-0000-00000000000c' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"It ____ invisible." 빈칸에 알맞은 것은?', 'It ___ invisible, so most people forget to count it.',
  '[{"key":"1","text":"are"},{"key":"2","text":"is"},{"key":"3","text":"have"},{"key":"4","text":"were"}]', '2',
  '주어 It 단수 → is.'
from te_paragraphs p where p.passage_id = 'b000000c-0000-0000-0000-00000000000c' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"you gave up"의 역할은?', 'the value of the option you gave up',
  '[{"key":"1","text":"option을 수식하는 관계절 (관계대명사 생략)"},{"key":"2","text":"부사절"},{"key":"3","text":"보어"},{"key":"4","text":"독립절"}]', '1',
  '목적격 관계대명사 that/which 생략, 형용사절이 option 수식.'
from te_paragraphs p where p.passage_id = 'b000000c-0000-0000-0000-00000000000c' and p.ord = 1;

-- para 2
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'Big decisions become clearer once we ask what we are giving up.',
  '[{"key":"1","text":"Big decisions"},{"key":"2","text":"we"},{"key":"3","text":"clearer"},{"key":"4","text":"once"}]', '1',
  '주절의 동사 become의 주어는 "Big decisions".'
from te_paragraphs p where p.passage_id = 'b000000c-0000-0000-0000-00000000000c' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"The choice that looked obvious sometimes ____ to a quieter alternative." 빈칸에 알맞은 것은?', 'The choice that looked obvious sometimes ___ to a quieter alternative.',
  '[{"key":"1","text":"lose"},{"key":"2","text":"loses"},{"key":"3","text":"are losing"},{"key":"4","text":"have lost"}]', '2',
  '주어 "The choice" 단수 → loses.'
from te_paragraphs p where p.passage_id = 'b000000c-0000-0000-0000-00000000000c' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"once we ask what we are giving up"의 역할은?', 'Big decisions become clearer once we ask what we are giving up.',
  '[{"key":"1","text":"시간/조건 부사절"},{"key":"2","text":"명사절"},{"key":"3","text":"형용사절"},{"key":"4","text":"보어"}]', '1',
  'once는 "~하자마자/~할 때"의 부사절 접속사.'
from te_paragraphs p where p.passage_id = 'b000000c-0000-0000-0000-00000000000c' and p.ord = 2;

-- ============ b000000d The Most Wanted Thing Online ============
-- para 0
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'Advertisers are the customers, and the user is the product whose attention is sold.',
  '[{"key":"1","text":"Advertisers"},{"key":"2","text":"the customers"},{"key":"3","text":"the user"},{"key":"4","text":"attention"}]', '1',
  '첫 절의 동사 are의 주어는 "Advertisers".'
from te_paragraphs p where p.passage_id = 'b000000d-0000-0000-0000-00000000000d' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"When a service ____ free, the user is usually not the customer." 빈칸에 알맞은 것은?', 'When a service ___ free, the user is usually not the customer.',
  '[{"key":"1","text":"are"},{"key":"2","text":"is"},{"key":"3","text":"have"},{"key":"4","text":"were"}]', '2',
  '주어 "a service" 단수 → is.'
from te_paragraphs p where p.passage_id = 'b000000d-0000-0000-0000-00000000000d' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"whose attention is sold"의 역할은?', 'the product whose attention is sold',
  '[{"key":"1","text":"the product를 수식하는 형용사절 (소유격 관계대명사)"},{"key":"2","text":"부사절"},{"key":"3","text":"보어"},{"key":"4","text":"명사절"}]', '1',
  '소유격 관계대명사 whose가 the product을 수식.'
from te_paragraphs p where p.passage_id = 'b000000d-0000-0000-0000-00000000000d' and p.ord = 0;

-- para 1
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'Attention is a limited resource.',
  '[{"key":"1","text":"Attention"},{"key":"2","text":"a limited resource"},{"key":"3","text":"limited"},{"key":"4","text":"resource"}]', '1',
  'be동사 is의 주어는 Attention.'
from te_paragraphs p where p.passage_id = 'b000000d-0000-0000-0000-00000000000d' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"There ____ only so many hours in a day." 빈칸에 알맞은 것은?', 'There ___ only so many hours in a day.',
  '[{"key":"1","text":"is"},{"key":"2","text":"are"},{"key":"3","text":"has"},{"key":"4","text":"was"}]', '2',
  'there 구문에서는 뒤의 명사에 일치. "hours"가 복수 → are.'
from te_paragraphs p where p.passage_id = 'b000000d-0000-0000-0000-00000000000d' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"and many apps fight for the same ones"의 역할은?', 'There are only so many hours in a day, and many apps fight for the same ones.',
  '[{"key":"1","text":"등위 접속사 and로 연결된 독립절"},{"key":"2","text":"부사절"},{"key":"3","text":"형용사절"},{"key":"4","text":"명사절"}]', '1',
  '등위접속사 and로 두 독립절이 연결됨.'
from te_paragraphs p where p.passage_id = 'b000000d-0000-0000-0000-00000000000d' and p.ord = 1;

-- para 2
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'Endless scrolling is not free time; it is paid time, paid in something we cannot earn back.',
  '[{"key":"1","text":"Endless scrolling"},{"key":"2","text":"free time"},{"key":"3","text":"paid time"},{"key":"4","text":"something"}]', '1',
  '첫 절의 동사 is의 주어는 "Endless scrolling".'
from te_paragraphs p where p.passage_id = 'b000000d-0000-0000-0000-00000000000d' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"Once we ____ attention as a currency, the choice becomes more serious." 빈칸에 알맞은 것은?', 'Once we ___ attention as a currency, the choice of how to spend it becomes more serious.',
  '[{"key":"1","text":"sees"},{"key":"2","text":"see"},{"key":"3","text":"is seeing"},{"key":"4","text":"has seen"}]', '2',
  '주어 we → see.'
from te_paragraphs p where p.passage_id = 'b000000d-0000-0000-0000-00000000000d' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"we cannot earn back"의 역할은?', 'paid in something we cannot earn back',
  '[{"key":"1","text":"something을 수식하는 관계절 (관계대명사 생략)"},{"key":"2","text":"부사절"},{"key":"3","text":"보어"},{"key":"4","text":"독립절"}]', '1',
  '목적격 관계대명사 that이 생략된 형용사절이 something을 수식.'
from te_paragraphs p where p.passage_id = 'b000000d-0000-0000-0000-00000000000d' and p.ord = 2;

-- ============ b000000e Animals That Pretend ============
-- para 0
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'A harmless hoverfly wears the same yellow and black stripes as a stinging wasp.',
  '[{"key":"1","text":"A harmless hoverfly"},{"key":"2","text":"the same yellow and black stripes"},{"key":"3","text":"a stinging wasp"},{"key":"4","text":"stripes"}]', '1',
  '동사 wears의 주어는 "A harmless hoverfly".'
from te_paragraphs p where p.passage_id = 'b000000e-0000-0000-0000-00000000000e' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"Birds that have been stung once ____ both insects." 빈칸에 알맞은 것은?', 'Birds that have been stung once ___ both insects.',
  '[{"key":"1","text":"avoids"},{"key":"2","text":"avoid"},{"key":"3","text":"is avoiding"},{"key":"4","text":"has avoided"}]', '2',
  '주어 Birds 복수 → avoid.'
from te_paragraphs p where p.passage_id = 'b000000e-0000-0000-0000-00000000000e' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"that have been stung once"의 역할은?', 'Birds that have been stung once avoid both insects.',
  '[{"key":"1","text":"Birds를 수식하는 형용사절"},{"key":"2","text":"부사절"},{"key":"3","text":"명사절"},{"key":"4","text":"보어"}]', '1',
  '관계대명사 that 절이 Birds를 수식.'
from te_paragraphs p where p.passage_id = 'b000000e-0000-0000-0000-00000000000e' and p.ord = 0;

-- para 1
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'A stick insect looks like a twig, a leaf insect like a torn leaf.',
  '[{"key":"1","text":"A stick insect"},{"key":"2","text":"a twig"},{"key":"3","text":"a leaf insect"},{"key":"4","text":"a torn leaf"}]', '1',
  '첫 절의 동사 looks의 주어는 "A stick insect".'
from te_paragraphs p where p.passage_id = 'b000000e-0000-0000-0000-00000000000e' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"Stillness ____ the disguise." 빈칸에 알맞은 것은?', 'Stillness ___ the disguise.',
  '[{"key":"1","text":"complete"},{"key":"2","text":"completes"},{"key":"3","text":"are completing"},{"key":"4","text":"have completed"}]', '2',
  '주어 Stillness 불가산명사로 단수 → completes.'
from te_paragraphs p where p.passage_id = 'b000000e-0000-0000-0000-00000000000e' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"a leaf insect like a torn leaf"의 구조는? (생략된 요소)', 'A stick insect looks like a twig, a leaf insect like a torn leaf.',
  '[{"key":"1","text":"동사 looks가 생략됨 (병렬 구조)"},{"key":"2","text":"주어가 생략됨"},{"key":"3","text":"전치사가 생략됨"},{"key":"4","text":"생략 없음"}]', '1',
  '병렬 구조에서 반복되는 동사 looks가 생략.'
from te_paragraphs p where p.passage_id = 'b000000e-0000-0000-0000-00000000000e' and p.ord = 1;

-- para 2
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'Mimicry shows that evolution does not need to invent new tools.',
  '[{"key":"1","text":"Mimicry"},{"key":"2","text":"evolution"},{"key":"3","text":"new tools"},{"key":"4","text":"that"}]', '1',
  '동사 shows의 주어는 Mimicry.'
from te_paragraphs p where p.passage_id = 'b000000e-0000-0000-0000-00000000000e' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"Borrowing the appearance of something dangerous ____ just as well." 빈칸에 알맞은 것은?', 'Borrowing the appearance of something dangerous, or of nothing at all, ___ just as well.',
  '[{"key":"1","text":"work"},{"key":"2","text":"works"},{"key":"3","text":"are working"},{"key":"4","text":"have worked"}]', '2',
  '주어가 동명사구 (Borrowing ~) 단수 취급 → works.'
from te_paragraphs p where p.passage_id = 'b000000e-0000-0000-0000-00000000000e' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"that evolution does not need to invent new tools"의 역할은?', 'Mimicry shows that evolution does not need to invent new tools.',
  '[{"key":"1","text":"shows의 목적어 명사절"},{"key":"2","text":"부사절"},{"key":"3","text":"형용사절"},{"key":"4","text":"보어"}]', '1',
  '접속사 that 명사절이 shows의 목적어.'
from te_paragraphs p where p.passage_id = 'b000000e-0000-0000-0000-00000000000e' and p.ord = 2;

-- ============ b000000f Why New Cities Mix Everything ============
-- para 0
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'A traditional city zoned for cars made every trip long.',
  '[{"key":"1","text":"A traditional city"},{"key":"2","text":"cars"},{"key":"3","text":"every trip"},{"key":"4","text":"long"}]', '1',
  '동사 made의 주어는 "A traditional city".'
from te_paragraphs p where p.passage_id = 'b000000f-0000-0000-0000-00000000000f' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"Going to the store, to school, or to work ____ a separate journey." 빈칸에 알맞은 것은?', 'Going to the store, to school, or to work ___ a separate journey.',
  '[{"key":"1","text":"require"},{"key":"2","text":"required"},{"key":"3","text":"are requiring"},{"key":"4","text":"have required"}]', '2',
  '동명사구 주어, 과거 사실 → required.'
from te_paragraphs p where p.passage_id = 'b000000f-0000-0000-0000-00000000000f' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"zoned for cars"의 역할은?', 'A traditional city zoned for cars made every trip long.',
  '[{"key":"1","text":"A traditional city를 수식하는 과거분사구"},{"key":"2","text":"동사"},{"key":"3","text":"부사절"},{"key":"4","text":"보어"}]', '1',
  '과거분사구가 A traditional city를 뒤에서 수식 (수동적 의미).'
from te_paragraphs p where p.passage_id = 'b000000f-0000-0000-0000-00000000000f' and p.ord = 0;

-- para 1
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'A mixed-use street puts shops on the ground floor, offices above, and apartments on top.',
  '[{"key":"1","text":"A mixed-use street"},{"key":"2","text":"shops"},{"key":"3","text":"offices"},{"key":"4","text":"apartments"}]', '1',
  '동사 puts의 주어는 "A mixed-use street".'
from te_paragraphs p where p.passage_id = 'b000000f-0000-0000-0000-00000000000f' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"Daily life ____ happen within a few minutes of walking." 빈칸에 알맞은 것은?', 'Daily life ___ happen within a few minutes of walking.',
  '[{"key":"1","text":"can"},{"key":"2","text":"has"},{"key":"3","text":"are"},{"key":"4","text":"is"}]', '1',
  '뒤에 동사원형 happen이 오므로 조동사 can.'
from te_paragraphs p where p.passage_id = 'b000000f-0000-0000-0000-00000000000f' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"shops on the ground floor, offices above, and apartments on top"의 구조는?', 'A mixed-use street puts shops on the ground floor, offices above, and apartments on top.',
  '[{"key":"1","text":"명사+장소 표현이 and로 병렬 연결된 puts의 목적어"},{"key":"2","text":"세 개의 독립절"},{"key":"3","text":"부사절"},{"key":"4","text":"명사절"}]', '1',
  '세 명사구가 등위접속사 and로 병렬 연결되어 puts의 목적어 역할.'
from te_paragraphs p where p.passage_id = 'b000000f-0000-0000-0000-00000000000f' and p.ord = 1;

-- para 2
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'The change does more than save time.',
  '[{"key":"1","text":"The change"},{"key":"2","text":"more than"},{"key":"3","text":"time"},{"key":"4","text":"save"}]', '1',
  '동사 does의 주어는 The change.'
from te_paragraphs p where p.passage_id = 'b000000f-0000-0000-0000-00000000000f' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"Streets ____ with people throughout the day." 빈칸에 알맞은 것은?', 'Streets ___ with people throughout the day.',
  '[{"key":"1","text":"fills"},{"key":"2","text":"fill"},{"key":"3","text":"is filling"},{"key":"4","text":"has filled"}]', '2',
  '주어 Streets 복수 → fill.'
from te_paragraphs p where p.passage_id = 'b000000f-0000-0000-0000-00000000000f' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"which makes them safer and livelier in ways that empty zoned areas never become"의 역할은?', 'Streets fill with people throughout the day, which makes them safer and livelier.',
  '[{"key":"1","text":"앞 문장 전체를 수식하는 계속적 용법 관계절"},{"key":"2","text":"부사절"},{"key":"3","text":"명사절"},{"key":"4","text":"보어"}]', '1',
  '계속적 용법의 관계대명사 which가 앞 절 전체를 받음.'
from te_paragraphs p where p.passage_id = 'b000000f-0000-0000-0000-00000000000f' and p.ord = 2;

-- ============ b0000010 A Sad Song in Every Language ============
-- para 0
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'Listeners around the world tend to call it sad.',
  '[{"key":"1","text":"Listeners"},{"key":"2","text":"the world"},{"key":"3","text":"it"},{"key":"4","text":"sad"}]', '1',
  '동사 tend의 주어는 Listeners.'
from te_paragraphs p where p.passage_id = 'b0000010-0000-0000-0000-000000000010' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"When sad music ____ played slowly with low notes." 빈칸에 알맞은 것은?', 'When sad music ___ played slowly with low notes.',
  '[{"key":"1","text":"are"},{"key":"2","text":"is"},{"key":"3","text":"have"},{"key":"4","text":"were"}]', '2',
  '주어 "music" 불가산 단수, 수동태 → is played.'
from te_paragraphs p where p.passage_id = 'b0000010-0000-0000-0000-000000000010' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"to call it sad"의 역할은?', 'Listeners around the world tend to call it sad.',
  '[{"key":"1","text":"tend의 보어 (to부정사)"},{"key":"2","text":"부사절"},{"key":"3","text":"형용사절"},{"key":"4","text":"독립절"}]', '1',
  '"tend to + 동사원형" 구문. to call이 tend의 보어 역할.'
from te_paragraphs p where p.passage_id = 'b0000010-0000-0000-0000-000000000010' and p.ord = 0;

-- para 1
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'Researchers suspect that some musical patterns echo the sound of the human body.',
  '[{"key":"1","text":"Researchers"},{"key":"2","text":"some musical patterns"},{"key":"3","text":"the sound"},{"key":"4","text":"the human body"}]', '1',
  '동사 suspect의 주어는 Researchers.'
from te_paragraphs p where p.passage_id = 'b0000010-0000-0000-0000-000000000010' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"Slow tempos ____ a sleeping heartbeat." 빈칸에 알맞은 것은?', 'Slow tempos ___ a sleeping heartbeat.',
  '[{"key":"1","text":"resembles"},{"key":"2","text":"resemble"},{"key":"3","text":"is resembling"},{"key":"4","text":"has resembled"}]', '2',
  '주어 "tempos" 복수 → resemble.'
from te_paragraphs p where p.passage_id = 'b0000010-0000-0000-0000-000000000010' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"that some musical patterns echo the sound of the human body"의 역할은?', 'Researchers suspect that some musical patterns echo the sound of the human body.',
  '[{"key":"1","text":"suspect의 목적어 명사절"},{"key":"2","text":"부사절"},{"key":"3","text":"형용사절"},{"key":"4","text":"보어"}]', '1',
  '접속사 that 명사절이 suspect의 목적어.'
from te_paragraphs p where p.passage_id = 'b0000010-0000-0000-0000-000000000010' and p.ord = 1;

-- para 2
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'The body, it turns out, is a universal listener.',
  '[{"key":"1","text":"The body"},{"key":"2","text":"it"},{"key":"3","text":"a universal listener"},{"key":"4","text":"out"}]', '1',
  'is의 주어는 "The body". 사이의 "it turns out"은 삽입절.'
from te_paragraphs p where p.passage_id = 'b0000010-0000-0000-0000-000000000010' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"A small core ____ to be shared." 빈칸에 알맞은 것은?', 'A small core ___ to be shared.',
  '[{"key":"1","text":"seem"},{"key":"2","text":"seems"},{"key":"3","text":"are seeming"},{"key":"4","text":"have seemed"}]', '2',
  '주어 "A small core" 단수 → seems.'
from te_paragraphs p where p.passage_id = 'b0000010-0000-0000-0000-000000000010' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"it turns out"의 역할은?', 'The body, it turns out, is a universal listener.',
  '[{"key":"1","text":"문장에 삽입된 절"},{"key":"2","text":"주절"},{"key":"3","text":"부사절"},{"key":"4","text":"관계절"}]', '1',
  '"it turns out"은 주절에 삽입된 절 (~인 것으로 드러난다).'
from te_paragraphs p where p.passage_id = 'b0000010-0000-0000-0000-000000000010' and p.ord = 2;

-- ============ b0000011 How a Shared Language Spread ============
-- para 0
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'A simpler shared form emerged from the mix.',
  '[{"key":"1","text":"A simpler shared form"},{"key":"2","text":"the mix"},{"key":"3","text":"shared"},{"key":"4","text":"form"}]', '1',
  '동사 emerged의 주어는 "A simpler shared form".'
from te_paragraphs p where p.passage_id = 'b0000011-0000-0000-0000-000000000011' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"No one ____ to learn three new languages just to sell goods." 빈칸에 알맞은 것은?', 'No one ___ to learn three new languages just to sell goods.',
  '[{"key":"1","text":"want"},{"key":"2","text":"wanted"},{"key":"3","text":"are wanting"},{"key":"4","text":"have wanted"}]', '2',
  '"No one"은 단수 취급, 과거 사실 → wanted.'
from te_paragraphs p where p.passage_id = 'b0000011-0000-0000-0000-000000000011' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"just to sell goods"의 역할은?', 'No one wanted to learn three new languages just to sell goods.',
  '[{"key":"1","text":"목적을 나타내는 to부정사 부사구"},{"key":"2","text":"주어"},{"key":"3","text":"보어"},{"key":"4","text":"형용사구"}]', '1',
  '"to sell"은 목적을 나타내는 부사적 용법.'
from te_paragraphs p where p.passage_id = 'b0000011-0000-0000-0000-000000000011' and p.ord = 0;

-- para 1
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'A trade language usually has a small vocabulary and simple grammar.',
  '[{"key":"1","text":"A trade language"},{"key":"2","text":"a small vocabulary"},{"key":"3","text":"simple grammar"},{"key":"4","text":"usually"}]', '1',
  '동사 has의 주어는 "A trade language".'
from te_paragraphs p where p.passage_id = 'b0000011-0000-0000-0000-000000000011' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"It ____ built for usefulness, not for poetry." 빈칸에 알맞은 것은?', 'It ___ built for usefulness, not for poetry.',
  '[{"key":"1","text":"are"},{"key":"2","text":"is"},{"key":"3","text":"have"},{"key":"4","text":"were"}]', '2',
  '주어 It 단수, 수동태 → is built.'
from te_paragraphs p where p.passage_id = 'b0000011-0000-0000-0000-000000000011' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"for usefulness, not for poetry"의 구조는?', 'It is built for usefulness, not for poetry.',
  '[{"key":"1","text":"for 전치사구 두 개가 대조되며 부사 역할"},{"key":"2","text":"주어와 보어"},{"key":"3","text":"명사절 두 개"},{"key":"4","text":"독립절"}]', '1',
  '"for ~, not for ~" 대조되는 두 전치사구.'
from te_paragraphs p where p.passage_id = 'b0000011-0000-0000-0000-000000000011' and p.ord = 1;

-- para 2
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'Sometimes such a language fades when the trade route closes.',
  '[{"key":"1","text":"such a language"},{"key":"2","text":"the trade route"},{"key":"3","text":"Sometimes"},{"key":"4","text":"closes"}]', '1',
  '주절 동사 fades의 주어는 "such a language".'
from te_paragraphs p where p.passage_id = 'b0000011-0000-0000-0000-000000000011' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"Sometimes, surprisingly, it ____ roots and becomes a native language." 빈칸에 알맞은 것은?', 'Sometimes, surprisingly, it ___ roots and becomes a native language.',
  '[{"key":"1","text":"grow"},{"key":"2","text":"grows"},{"key":"3","text":"are growing"},{"key":"4","text":"have grown"}]', '2',
  '주어 it 단수 → grows. 뒤의 becomes와 시제 일치.'
from te_paragraphs p where p.passage_id = 'b0000011-0000-0000-0000-000000000011' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"when the trade route closes"의 역할은?', 'Sometimes such a language fades when the trade route closes.',
  '[{"key":"1","text":"시간 부사절"},{"key":"2","text":"명사절"},{"key":"3","text":"형용사절"},{"key":"4","text":"보어"}]', '1',
  'when 절은 시간을 나타내는 부사절.'
from te_paragraphs p where p.passage_id = 'b0000011-0000-0000-0000-000000000011' and p.ord = 2;

-- ============ b0000012 Why Tomorrow Feels Less Real ============
-- para 0
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'The future second candy feels less real than the candy in front of them.',
  '[{"key":"1","text":"The future second candy"},{"key":"2","text":"the candy"},{"key":"3","text":"front"},{"key":"4","text":"them"}]', '1',
  '동사 feels의 주어는 "The future second candy".'
from te_paragraphs p where p.passage_id = 'b0000012-0000-0000-0000-000000000012' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"Many ____ choose the one candy." 빈칸에 알맞은 것은?', 'Many ___ choose the one candy.',
  '[{"key":"1","text":"will"},{"key":"2","text":"is"},{"key":"3","text":"are"},{"key":"4","text":"has"}]', '1',
  '뒤에 동사원형 choose가 오므로 조동사 will.'
from te_paragraphs p where p.passage_id = 'b0000012-0000-0000-0000-000000000012' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"in front of them"의 역할은?', 'the candy in front of them',
  '[{"key":"1","text":"candy를 수식하는 전치사구 (형용사 역할)"},{"key":"2","text":"부사절"},{"key":"3","text":"보어"},{"key":"4","text":"주어"}]', '1',
  '전치사구가 candy를 뒤에서 수식.'
from te_paragraphs p where p.passage_id = 'b0000012-0000-0000-0000-000000000012' and p.ord = 0;

-- para 1
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'Adults make the same mistake on bigger scales.',
  '[{"key":"1","text":"Adults"},{"key":"2","text":"the same mistake"},{"key":"3","text":"bigger scales"},{"key":"4","text":"on"}]', '1',
  '동사 make의 주어는 Adults.'
from te_paragraphs p where p.passage_id = 'b0000012-0000-0000-0000-000000000012' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"They ____ exercise that pays off next year for comfort tonight." 빈칸에 알맞은 것은?', 'They ___ exercise that pays off next year for comfort tonight.',
  '[{"key":"1","text":"skips"},{"key":"2","text":"skip"},{"key":"3","text":"is skipping"},{"key":"4","text":"has skipped"}]', '2',
  '주어 They 복수 → skip.'
from te_paragraphs p where p.passage_id = 'b0000012-0000-0000-0000-000000000012' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"that pays off next year"의 수식 대상은?', 'exercise that pays off next year',
  '[{"key":"1","text":"exercise"},{"key":"2","text":"They"},{"key":"3","text":"comfort"},{"key":"4","text":"tonight"}]', '1',
  '관계대명사 that 절이 exercise를 수식.'
from te_paragraphs p where p.passage_id = 'b0000012-0000-0000-0000-000000000012' and p.ord = 1;

-- para 2
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'The future self becomes a person worth keeping a promise to.',
  '[{"key":"1","text":"The future self"},{"key":"2","text":"a person"},{"key":"3","text":"a promise"},{"key":"4","text":"worth"}]', '1',
  '동사 becomes의 주어는 "The future self".'
from te_paragraphs p where p.passage_id = 'b0000012-0000-0000-0000-000000000012' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"Knowing about this bias ____ not erase it." 빈칸에 알맞은 것은?', 'Knowing about this bias ___ not erase it.',
  '[{"key":"1","text":"do"},{"key":"2","text":"does"},{"key":"3","text":"are"},{"key":"4","text":"have"}]', '2',
  '동명사구 주어 단수 취급 → does not erase.'
from te_paragraphs p where p.passage_id = 'b0000012-0000-0000-0000-000000000012' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"worth keeping a promise to"의 역할은?', 'a person worth keeping a promise to',
  '[{"key":"1","text":"a person을 수식하는 형용사구"},{"key":"2","text":"부사절"},{"key":"3","text":"명사절"},{"key":"4","text":"주어"}]', '1',
  '"worth + 동명사" 형용사구가 a person을 뒤에서 수식.'
from te_paragraphs p where p.passage_id = 'b0000012-0000-0000-0000-000000000012' and p.ord = 2;

-- ============ b0000013 Two Prisoners and a Choice ============
-- para 0
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'If both prisoners stay silent, both get a light sentence.',
  '[{"key":"1","text":"both prisoners"},{"key":"2","text":"both"},{"key":"3","text":"a light sentence"},{"key":"4","text":"silent"}]', '2',
  '주절의 동사 get의 주어는 "both" (대명사). 앞은 if 부사절.'
from te_paragraphs p where p.passage_id = 'b0000013-0000-0000-0000-000000000013' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"The betrayer ____ free and the silent one suffers most." 빈칸에 알맞은 것은?', 'The betrayer ___ free and the silent one suffers most.',
  '[{"key":"1","text":"walk"},{"key":"2","text":"walks"},{"key":"3","text":"is walking"},{"key":"4","text":"have walked"}]', '2',
  '주어 "The betrayer" 단수 → walks.'
from te_paragraphs p where p.passage_id = 'b0000013-0000-0000-0000-000000000013' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"If both prisoners stay silent"의 역할은?', 'If both prisoners stay silent, both get a light sentence.',
  '[{"key":"1","text":"조건 부사절"},{"key":"2","text":"명사절"},{"key":"3","text":"형용사절"},{"key":"4","text":"보어"}]', '1',
  'If 절은 조건을 나타내는 부사절.'
from te_paragraphs p where p.passage_id = 'b0000013-0000-0000-0000-000000000013' and p.ord = 0;

-- para 1
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'Cooperation would have been better for everyone.',
  '[{"key":"1","text":"Cooperation"},{"key":"2","text":"everyone"},{"key":"3","text":"better"},{"key":"4","text":"would"}]', '1',
  '동사 would have been의 주어는 Cooperation.'
from te_paragraphs p where p.passage_id = 'b0000013-0000-0000-0000-000000000013' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"Betraying always ____." 빈칸에 알맞은 것은?', 'Looking at the choice alone, betraying always ___.',
  '[{"key":"1","text":"pay"},{"key":"2","text":"pays"},{"key":"3","text":"are paying"},{"key":"4","text":"have paid"}]', '2',
  '동명사 주어 betraying은 단수 취급 → pays.'
from te_paragraphs p where p.passage_id = 'b0000013-0000-0000-0000-000000000013' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"Looking at the choice alone"의 역할은?', 'Looking at the choice alone, betraying always pays.',
  '[{"key":"1","text":"분사구문 (부사 역할)"},{"key":"2","text":"주어"},{"key":"3","text":"보어"},{"key":"4","text":"명사절"}]', '1',
  '현재분사로 시작하는 분사구문이 부사 역할.'
from te_paragraphs p where p.passage_id = 'b0000013-0000-0000-0000-000000000013' and p.ord = 1;

-- para 2
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'This puzzle appears far outside prisons.',
  '[{"key":"1","text":"This puzzle"},{"key":"2","text":"prisons"},{"key":"3","text":"far"},{"key":"4","text":"outside"}]', '1',
  '동사 appears의 주어는 This puzzle.'
from te_paragraphs p where p.passage_id = 'b0000013-0000-0000-0000-000000000013' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"Countries deciding on pollution, neighbors deciding on noise, students deciding on group projects all ____ a version of the same trap." 빈칸에 알맞은 것은?', 'Countries deciding on pollution, neighbors deciding on noise, students deciding on group projects all ___ a version of the same trap.',
  '[{"key":"1","text":"faces"},{"key":"2","text":"face"},{"key":"3","text":"is facing"},{"key":"4","text":"has faced"}]', '2',
  '병렬 주어 (Countries, neighbors, students) 복수 → face.'
from te_paragraphs p where p.passage_id = 'b0000013-0000-0000-0000-000000000013' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"deciding on pollution"의 역할은?', 'Countries deciding on pollution',
  '[{"key":"1","text":"Countries를 수식하는 현재분사구"},{"key":"2","text":"동사"},{"key":"3","text":"부사절"},{"key":"4","text":"보어"}]', '1',
  '현재분사구가 Countries를 뒤에서 수식 (능동 의미).'
from te_paragraphs p where p.passage_id = 'b0000013-0000-0000-0000-000000000013' and p.ord = 2;

-- ============ b0000014 The Missing Mass of the Universe ============
-- para 0
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'The stars spin too fast for the visible matter alone to hold them together.',
  '[{"key":"1","text":"The stars"},{"key":"2","text":"the visible matter"},{"key":"3","text":"them"},{"key":"4","text":"together"}]', '1',
  '동사 spin의 주어는 "The stars".'
from te_paragraphs p where p.passage_id = 'b0000014-0000-0000-0000-000000000014' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"Something invisible ____ add the extra pull." 빈칸에 알맞은 것은?', 'Something invisible ___ add the extra pull.',
  '[{"key":"1","text":"must"},{"key":"2","text":"are"},{"key":"3","text":"has"},{"key":"4","text":"is"}]', '1',
  '뒤에 동사원형 add가 오므로 조동사 must (강한 추측).'
from te_paragraphs p where p.passage_id = 'b0000014-0000-0000-0000-000000000014' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"for the visible matter alone to hold them together"의 역할은?', 'too fast for the visible matter alone to hold them together',
  '[{"key":"1","text":"too ~ to 구문에 결합된 의미상 주어 + to부정사"},{"key":"2","text":"명사절"},{"key":"3","text":"형용사절"},{"key":"4","text":"독립절"}]', '1',
  'too 형용사 + for 의미상주어 + to부정사 구문.'
from te_paragraphs p where p.passage_id = 'b0000014-0000-0000-0000-000000000014' and p.ord = 0;

-- para 1
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'It does not give off light, and it ignores almost everything except gravity.',
  '[{"key":"1","text":"It"},{"key":"2","text":"light"},{"key":"3","text":"everything"},{"key":"4","text":"gravity"}]', '1',
  '두 절 모두 주어가 It (앞의 unseen material을 받음).'
from te_paragraphs p where p.passage_id = 'b0000014-0000-0000-0000-000000000014' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"The unseen material ____ called dark matter." 빈칸에 알맞은 것은?', 'The unseen material ___ called dark matter.',
  '[{"key":"1","text":"are"},{"key":"2","text":"is"},{"key":"3","text":"have"},{"key":"4","text":"were"}]', '2',
  '주어 "material" 단수, 수동태 → is called.'
from te_paragraphs p where p.passage_id = 'b0000014-0000-0000-0000-000000000014' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"except gravity"의 역할은?', 'it ignores almost everything except gravity',
  '[{"key":"1","text":"everything을 수식하는 전치사구"},{"key":"2","text":"보어"},{"key":"3","text":"주어"},{"key":"4","text":"부사절"}]', '1',
  '전치사 except가 이끄는 구가 everything을 수식.'
from te_paragraphs p where p.passage_id = 'b0000014-0000-0000-0000-000000000014' and p.ord = 1;

-- para 2
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'Most of what holds the cosmos together is hidden in plain sight.',
  '[{"key":"1","text":"Most of what holds the cosmos together"},{"key":"2","text":"the cosmos"},{"key":"3","text":"plain sight"},{"key":"4","text":"hidden"}]', '1',
  '주어는 "Most of what holds the cosmos together" 전체. 동사 is.'
from te_paragraphs p where p.passage_id = 'b0000014-0000-0000-0000-000000000014' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"About eighty-five percent of all matter in the universe ____ thought to be dark." 빈칸에 알맞은 것은?', 'About eighty-five percent of all matter in the universe ___ thought to be dark.',
  '[{"key":"1","text":"are"},{"key":"2","text":"is"},{"key":"3","text":"have"},{"key":"4","text":"were"}]', '2',
  '"X percent of 불가산명사"는 단수 → is.'
from te_paragraphs p where p.passage_id = 'b0000014-0000-0000-0000-000000000014' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"what holds the cosmos together"의 역할은?', 'Most of what holds the cosmos together is hidden in plain sight.',
  '[{"key":"1","text":"of의 목적어 명사절 (관계대명사 what)"},{"key":"2","text":"부사절"},{"key":"3","text":"형용사절"},{"key":"4","text":"독립절"}]', '1',
  '관계대명사 what이 이끄는 명사절이 전치사 of의 목적어.'
from te_paragraphs p where p.passage_id = 'b0000014-0000-0000-0000-000000000014' and p.ord = 2;
