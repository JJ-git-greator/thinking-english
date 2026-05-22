-- =====================================================================
-- 직독직해 청크 시드 v2 — 하(low) 5지문, 의미단위 원칙 재적용
-- 원칙: 주어 한 덩어리 / 동사+목적어 한 덩어리 / 부사구 별개 / 절은 통째
-- =====================================================================

-- 이전 청크 데이터 전체 삭제 (te_chunk_attempts도 FK cascade로 삭제됨)
delete from te_chunk_sentences;

-- ============ a0000001 How Sleep Resets the Brain ============
-- para 0
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'During deep sleep, the brain rinses itself with a special fluid that washes away the toxic proteins built up during the day.',
  '[
    {"en":"During deep sleep,","ko":"깊은 수면 동안,"},
    {"en":"the brain rinses itself","ko":"뇌는 스스로를 씻어낸다"},
    {"en":"with a special fluid","ko":"특별한 액체로"},
    {"en":"that washes away the toxic proteins","ko":"독성 단백질을 씻어내는"},
    {"en":"built up during the day.","ko":"낮 동안 쌓인."}
  ]'::jsonb,
  '관계대명사절 통째, 과거분사구는 후치수식이라 분리'
from te_paragraphs p where p.passage_id = 'a0000001-0000-0000-0000-000000000001' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 1,
  'This cleaning process is most active at night, when the body is still.',
  '[
    {"en":"This cleaning process is most active","ko":"이 청소 과정은 가장 활발하다"},
    {"en":"at night,","ko":"밤에,"},
    {"en":"when the body is still.","ko":"몸이 가만히 있을 때."}
  ]'::jsonb,
  '관계부사 when 절 통째'
from te_paragraphs p where p.passage_id = 'a0000001-0000-0000-0000-000000000001' and p.ord = 0;

-- para 1
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Without this nightly washing, the unwanted proteins begin to stack up.',
  '[
    {"en":"Without this nightly washing,","ko":"이 밤의 청소가 없으면,"},
    {"en":"the unwanted proteins","ko":"원치 않는 단백질들이"},
    {"en":"begin to stack up.","ko":"쌓이기 시작한다."}
  ]'::jsonb,
  'Without 가정 부사구'
from te_paragraphs p where p.passage_id = 'a0000001-0000-0000-0000-000000000001' and p.ord = 1;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 1,
  'Over time, they can damage the cells that store memories and slow down thinking.',
  '[
    {"en":"Over time,","ko":"시간이 지나면서,"},
    {"en":"they can damage the cells","ko":"그것들은 세포를 손상시킬 수 있다"},
    {"en":"that store memories","ko":"기억을 저장하는"},
    {"en":"and slow down thinking.","ko":"그리고 사고를 늦춘다."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'a0000001-0000-0000-0000-000000000001' and p.ord = 1;

-- para 2
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'This finding suggests that sleeping enough is not a sign of laziness.',
  '[
    {"en":"This finding suggests","ko":"이 발견은 시사한다"},
    {"en":"that sleeping enough","ko":"충분히 자는 것이"},
    {"en":"is not a sign of laziness.","ko":"게으름의 표시가 아니라는 것을."}
  ]'::jsonb,
  'that 명사절. 절 내부도 주어/동사 단위로'
from te_paragraphs p where p.passage_id = 'a0000001-0000-0000-0000-000000000001' and p.ord = 2;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 1,
  'It is one of the most active things the brain does, and skipping it has real costs.',
  '[
    {"en":"It is one of the most active things","ko":"그것은 가장 활발한 활동 중 하나이다"},
    {"en":"the brain does,","ko":"뇌가 하는 것 중에서,"},
    {"en":"and skipping it has real costs.","ko":"그리고 그것을 건너뛰는 것은 진짜 비용을 치른다."}
  ]'::jsonb,
  '관계대명사 생략된 절은 the brain does까지 한 덩어리'
from te_paragraphs p where p.passage_id = 'a0000001-0000-0000-0000-000000000001' and p.ord = 2;

-- ============ a0000002 The Quiet Power of Walking ============
-- para 0
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'A short walk seems almost too easy to be useful.',
  '[
    {"en":"A short walk seems","ko":"짧은 산책은 보인다"},
    {"en":"almost too easy to be useful.","ko":"거의 너무 쉬워서 유용할 수 없는 것처럼."}
  ]'::jsonb,
  'too ~ to 구문은 한 덩어리'
from te_paragraphs p where p.passage_id = 'a0000002-0000-0000-0000-000000000002' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 1,
  'Yet researchers have found that thirty minutes of walking can lift mood as much as some medicines for sadness.',
  '[
    {"en":"Yet researchers have found","ko":"그러나 연구자들은 발견했다"},
    {"en":"that thirty minutes of walking","ko":"30분의 걷기가"},
    {"en":"can lift mood","ko":"기분을 끌어올릴 수 있다는 것을"},
    {"en":"as much as some medicines for sadness.","ko":"우울증 약 일부만큼이나."}
  ]'::jsonb,
  'as much as 비교구 통째'
from te_paragraphs p where p.passage_id = 'a0000002-0000-0000-0000-000000000002' and p.ord = 0;

-- para 1
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Many writers and scientists report that their best ideas arrive while they are moving, not while they are sitting at a desk.',
  '[
    {"en":"Many writers and scientists report","ko":"많은 작가와 과학자들이 보고한다"},
    {"en":"that their best ideas arrive","ko":"그들의 최고 아이디어가 도착한다고"},
    {"en":"while they are moving,","ko":"움직이고 있을 때,"},
    {"en":"not while they are sitting at a desk.","ko":"책상에 앉아 있을 때가 아니라."}
  ]'::jsonb,
  'while 부사절 통째'
from te_paragraphs p where p.passage_id = 'a0000002-0000-0000-0000-000000000002' and p.ord = 1;

-- para 2
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'When a problem feels stuck, the answer may not be more thinking but a quiet walk outside.',
  '[
    {"en":"When a problem feels stuck,","ko":"문제가 막힌 것처럼 느껴질 때,"},
    {"en":"the answer may not be more thinking","ko":"해답은 더 많은 생각이 아닐 수 있다"},
    {"en":"but a quiet walk outside.","ko":"오히려 밖에서의 조용한 산책일 수 있다."}
  ]'::jsonb,
  'not A but B'
from te_paragraphs p where p.passage_id = 'a0000002-0000-0000-0000-000000000002' and p.ord = 2;

-- ============ a0000003 Why We Remember Stories Better Than Facts ============
-- para 0
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Our brains were built long before there were books or tests.',
  '[
    {"en":"Our brains were built","ko":"우리 뇌는 만들어졌다"},
    {"en":"long before there were books or tests.","ko":"책이나 시험이 있기 훨씬 전에."}
  ]'::jsonb,
  'long before 부사절 통째'
from te_paragraphs p where p.passage_id = 'a0000003-0000-0000-0000-000000000003' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 1,
  'They were built around campfires, where people shared what happened during the day.',
  '[
    {"en":"They were built","ko":"그것들은 만들어졌다"},
    {"en":"around campfires,","ko":"모닥불 주위에서,"},
    {"en":"where people shared","ko":"그곳에서 사람들이 공유했다"},
    {"en":"what happened during the day.","ko":"낮 동안 일어난 일을."}
  ]'::jsonb,
  'where 관계부사절, what 명사절'
from te_paragraphs p where p.passage_id = 'a0000003-0000-0000-0000-000000000003' and p.ord = 0;

-- para 1
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'A story has characters, problems, and endings, and our minds catch onto these shapes naturally.',
  '[
    {"en":"A story has characters, problems, and endings,","ko":"이야기는 인물, 문제, 결말을 가지고 있다,"},
    {"en":"and our minds catch onto these shapes","ko":"그리고 우리 마음은 이런 모양을 잡아챈다"},
    {"en":"naturally.","ko":"자연스럽게."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'a0000003-0000-0000-0000-000000000003' and p.ord = 1;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 1,
  'The same fact wrapped in a story is remembered longer.',
  '[
    {"en":"The same fact","ko":"같은 사실이"},
    {"en":"wrapped in a story","ko":"이야기로 감싸진"},
    {"en":"is remembered longer.","ko":"더 오래 기억된다."}
  ]'::jsonb,
  '과거분사구 후치수식'
from te_paragraphs p where p.passage_id = 'a0000003-0000-0000-0000-000000000003' and p.ord = 1;

-- para 2
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'The teacher tells the information as a story, so the lesson stays.',
  '[
    {"en":"The teacher tells the information","ko":"선생님은 정보를 전달한다"},
    {"en":"as a story,","ko":"이야기로,"},
    {"en":"so the lesson stays.","ko":"그래서 그 수업이 남는다."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'a0000003-0000-0000-0000-000000000003' and p.ord = 2;

-- ============ a0000004 Bees and the Hidden Map of Flowers ============
-- para 0
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'A bee can fly two kilometers from its home and return without getting lost.',
  '[
    {"en":"A bee can fly two kilometers","ko":"벌은 2킬로미터를 날 수 있다"},
    {"en":"from its home","ko":"집으로부터"},
    {"en":"and return without getting lost.","ko":"그리고 길을 잃지 않고 돌아온다."}
  ]'::jsonb,
  '동사+목적어 묶음, and 뒤 동사구 통째'
from te_paragraphs p where p.passage_id = 'a0000004-0000-0000-0000-000000000004' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 1,
  'To do this, it remembers the angle of the sun and adjusts as the sun moves across the sky.',
  '[
    {"en":"To do this,","ko":"이걸 하기 위해,"},
    {"en":"it remembers the angle of the sun","ko":"벌은 태양의 각도를 기억한다"},
    {"en":"and adjusts","ko":"그리고 조정한다"},
    {"en":"as the sun moves across the sky.","ko":"태양이 하늘을 가로질러 움직일 때마다."}
  ]'::jsonb,
  'as 부사절 통째'
from te_paragraphs p where p.passage_id = 'a0000004-0000-0000-0000-000000000004' and p.ord = 0;

-- para 1
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'When a bee finds a new flower, it does a small dance back at the hive.',
  '[
    {"en":"When a bee finds a new flower,","ko":"벌이 새로운 꽃을 발견하면,"},
    {"en":"it does a small dance","ko":"벌은 작은 춤을 춘다"},
    {"en":"back at the hive.","ko":"벌집으로 돌아와서."}
  ]'::jsonb,
  'When 부사절 통째'
from te_paragraphs p where p.passage_id = 'a0000004-0000-0000-0000-000000000004' and p.ord = 1;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 1,
  'The shape of the dance tells the other bees how far the flower is and in which direction.',
  '[
    {"en":"The shape of the dance","ko":"춤의 모양이"},
    {"en":"tells the other bees","ko":"다른 벌들에게 알려준다"},
    {"en":"how far the flower is","ko":"꽃이 얼마나 먼지"},
    {"en":"and in which direction.","ko":"그리고 어느 방향에 있는지."}
  ]'::jsonb,
  '간접의문문 두 개 병렬'
from te_paragraphs p where p.passage_id = 'a0000004-0000-0000-0000-000000000004' and p.ord = 1;

-- para 2
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'A creature smaller than a coin carries a map, a clock, and a language inside it.',
  '[
    {"en":"A creature smaller than a coin","ko":"동전보다 작은 한 생물이"},
    {"en":"carries a map, a clock, and a language","ko":"지도, 시계, 언어를 품고 있다"},
    {"en":"inside it.","ko":"그 안에."}
  ]'::jsonb,
  '주어구 통째 (비교 형용사구 후치수식 포함)'
from te_paragraphs p where p.passage_id = 'a0000004-0000-0000-0000-000000000004' and p.ord = 2;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 1,
  'Nature often hides large skills in small bodies.',
  '[
    {"en":"Nature often hides large skills","ko":"자연은 종종 큰 능력을 숨긴다"},
    {"en":"in small bodies.","ko":"작은 몸 안에."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'a0000004-0000-0000-0000-000000000004' and p.ord = 2;

-- ============ a0000005 The First Smartphone Was Not What You Think ============
-- para 0
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'The first device that combined a phone with a small computer came out in 1994.',
  '[
    {"en":"The first device","ko":"첫 번째 기기는"},
    {"en":"that combined a phone with a small computer","ko":"전화기를 작은 컴퓨터와 결합한"},
    {"en":"came out in 1994.","ko":"1994년에 나왔다."}
  ]'::jsonb,
  '관계대명사절 통째'
from te_paragraphs p where p.passage_id = 'a0000005-0000-0000-0000-000000000005' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 1,
  'It was the size of a brick, and it weighed almost half a kilogram.',
  '[
    {"en":"It was the size of a brick,","ko":"그것은 벽돌 크기였다,"},
    {"en":"and it weighed almost half a kilogram.","ko":"그리고 거의 0.5킬로그램의 무게가 나갔다."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'a0000005-0000-0000-0000-000000000005' and p.ord = 0;

-- para 1
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Yet it could send email, check the calendar, and play simple games.',
  '[
    {"en":"Yet it could send email,","ko":"그러나 그것은 이메일을 보낼 수 있었다,"},
    {"en":"check the calendar,","ko":"달력을 확인하고,"},
    {"en":"and play simple games.","ko":"그리고 간단한 게임을 할 수 있었다."}
  ]'::jsonb,
  '동사구 세 개 병렬'
from te_paragraphs p where p.passage_id = 'a0000005-0000-0000-0000-000000000005' and p.ord = 1;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 1,
  'It cost as much as a small car.',
  '[
    {"en":"It cost","ko":"그것은 들었다"},
    {"en":"as much as a small car.","ko":"작은 차 한 대만큼이나."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'a0000005-0000-0000-0000-000000000005' and p.ord = 1;

-- para 2
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Most people in 1994 did not see why they would need such a thing.',
  '[
    {"en":"Most people in 1994","ko":"1994년 대부분의 사람들은"},
    {"en":"did not see","ko":"보지 못했다"},
    {"en":"why they would need such a thing.","ko":"왜 그런 것이 필요할지를."}
  ]'::jsonb,
  '간접의문문 why 절 통째'
from te_paragraphs p where p.passage_id = 'a0000005-0000-0000-0000-000000000005' and p.ord = 2;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 1,
  'Thirty years later, almost everyone carries something similar in their pocket.',
  '[
    {"en":"Thirty years later,","ko":"30년 후,"},
    {"en":"almost everyone carries something similar","ko":"거의 모든 사람이 비슷한 것을 들고 다닌다"},
    {"en":"in their pocket.","ko":"자기 주머니 안에."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'a0000005-0000-0000-0000-000000000005' and p.ord = 2;
