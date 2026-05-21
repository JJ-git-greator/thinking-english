-- =====================================================================
-- Structure 객관식 시드: 상(high) 난이도 15지문 × 3단락 × 3문제 = 135문제
-- ord 0=subject, ord 1=verb, ord 2=structure
-- =====================================================================

-- ============ c0000001 Why Expertise Can Become a Cage ============
-- para 0
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'An expert learns to see patterns most people miss.',
  '[{"key":"1","text":"An expert"},{"key":"2","text":"patterns"},{"key":"3","text":"most people"},{"key":"4","text":"to see"}]', '1',
  '동사 learns의 주어는 "An expert".'
from te_paragraphs p where p.passage_id = 'c0000001-0000-0000-0000-000000000001' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"The same training ____ blind spots in the places ..." 빈칸에 알맞은 것은?', 'The same training, however, ___ blind spots in the places where the expert no longer looks because the answer feels obvious.',
  '[{"key":"1","text":"build"},{"key":"2","text":"builds"},{"key":"3","text":"is building"},{"key":"4","text":"have built"}]', '2',
  '주어 "The same training"은 단수 → builds.'
from te_paragraphs p where p.passage_id = 'c0000001-0000-0000-0000-000000000001' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"most people miss"의 역할은?', 'patterns most people miss',
  '[{"key":"1","text":"patterns를 수식하는 관계절 (관계대명사 생략)"},{"key":"2","text":"부사절"},{"key":"3","text":"보어"},{"key":"4","text":"독립절"}]', '1',
  '목적격 관계대명사 that/which 생략, 형용사절이 patterns 수식.'
from te_paragraphs p where p.passage_id = 'c0000001-0000-0000-0000-000000000001' and p.ord = 0;

-- para 1
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'Outsiders sometimes solve problems that have stumped specialists for years.',
  '[{"key":"1","text":"Outsiders"},{"key":"2","text":"problems"},{"key":"3","text":"specialists"},{"key":"4","text":"years"}]', '1',
  '동사 solve의 주어는 "Outsiders".'
from te_paragraphs p where p.passage_id = 'c0000001-0000-0000-0000-000000000001' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"They ____ the assumptions that quietly closed certain doors inside the field." 빈칸에 알맞은 것은?', 'They ___ the assumptions that quietly closed certain doors inside the field.',
  '[{"key":"1","text":"lacks"},{"key":"2","text":"lack"},{"key":"3","text":"is lacking"},{"key":"4","text":"has lacked"}]', '2',
  '주어 They 복수 → lack.'
from te_paragraphs p where p.passage_id = 'c0000001-0000-0000-0000-000000000001' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"that quietly closed certain doors inside the field"의 역할은?', 'the assumptions that quietly closed certain doors inside the field',
  '[{"key":"1","text":"the assumptions를 수식하는 형용사절"},{"key":"2","text":"부사절"},{"key":"3","text":"명사절(주어)"},{"key":"4","text":"보어"}]', '1',
  '관계대명사 that 절이 the assumptions를 수식.'
from te_paragraphs p where p.passage_id = 'c0000001-0000-0000-0000-000000000001' and p.ord = 1;

-- para 2
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'A specialist who keeps one foot outside her own field sees both the inside and the door at the same time.',
  '[{"key":"1","text":"A specialist"},{"key":"2","text":"one foot"},{"key":"3","text":"her own field"},{"key":"4","text":"the door"}]', '1',
  '주절 동사 sees의 주어는 "A specialist". 사이의 who절은 형용사절.'
from te_paragraphs p where p.passage_id = 'c0000001-0000-0000-0000-000000000001' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"The lesson ____ not to avoid expertise but to balance it." 빈칸에 알맞은 것은?', 'The lesson ___ not to avoid expertise but to balance it.',
  '[{"key":"1","text":"are"},{"key":"2","text":"is"},{"key":"3","text":"have"},{"key":"4","text":"were"}]', '2',
  '주어 "The lesson" 단수 → is.'
from te_paragraphs p where p.passage_id = 'c0000001-0000-0000-0000-000000000001' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"not to avoid expertise but to balance it"의 구조는?', 'The lesson is not to avoid expertise but to balance it.',
  '[{"key":"1","text":"not A but B 상관접속사 구조 (to부정사 병렬 보어)"},{"key":"2","text":"부사절"},{"key":"3","text":"형용사절"},{"key":"4","text":"명사절"}]', '1',
  'not A but B: 두 to부정사가 병렬로 보어 역할.'
from te_paragraphs p where p.passage_id = 'c0000001-0000-0000-0000-000000000001' and p.ord = 2;

-- ============ c0000002 The Quiet Tyranny of the Default ============
-- para 0
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'When organ donation is opt-out instead of opt-in, registration rates jump dramatically.',
  '[{"key":"1","text":"organ donation"},{"key":"2","text":"registration rates"},{"key":"3","text":"opt-out"},{"key":"4","text":"opt-in"}]', '2',
  '주절 동사 jump의 주어는 "registration rates". 앞은 when 부사절.'
from te_paragraphs p where p.passage_id = 'c0000002-0000-0000-0000-000000000002' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"A different default ____ a different result." 빈칸에 알맞은 것은?', 'The same population, the same beliefs, but a different default ___ a different result.',
  '[{"key":"1","text":"produce"},{"key":"2","text":"produces"},{"key":"3","text":"are producing"},{"key":"4","text":"have produced"}]', '2',
  '주어 "a different default" 단수 → produces.'
from te_paragraphs p where p.passage_id = 'c0000002-0000-0000-0000-000000000002' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"instead of opt-in"의 역할은?', 'organ donation is opt-out instead of opt-in',
  '[{"key":"1","text":"앞의 opt-out과 대조되는 전치사구"},{"key":"2","text":"명사절"},{"key":"3","text":"독립절"},{"key":"4","text":"보어"}]', '1',
  '"instead of"는 대체/대조를 나타내는 전치사구.'
from te_paragraphs p where p.passage_id = 'c0000002-0000-0000-0000-000000000002' and p.ord = 0;

-- para 1
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'Defaults work because changing them takes a small but real effort, and most people do not pay that cost.',
  '[{"key":"1","text":"Defaults"},{"key":"2","text":"changing them"},{"key":"3","text":"a small but real effort"},{"key":"4","text":"most people"}]', '1',
  '첫 절의 동사 work의 주어는 "Defaults".'
from te_paragraphs p where p.passage_id = 'c0000002-0000-0000-0000-000000000002' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"Changing them ____ a small but real effort." 빈칸에 알맞은 것은?', 'Defaults work because changing them ___ a small but real effort.',
  '[{"key":"1","text":"take"},{"key":"2","text":"takes"},{"key":"3","text":"are taking"},{"key":"4","text":"have taken"}]', '2',
  '동명사구 "changing them" 단수 취급 → takes.'
from te_paragraphs p where p.passage_id = 'c0000002-0000-0000-0000-000000000002' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"regardless of what people would have decided in the abstract"의 역할은?', 'The choice that requires no action wins, regardless of what people would have decided in the abstract.',
  '[{"key":"1","text":"양보를 나타내는 전치사구"},{"key":"2","text":"주어"},{"key":"3","text":"보어"},{"key":"4","text":"형용사절"}]', '1',
  '"regardless of"는 양보/무관 전치사구. 안에 what 명사절.'
from te_paragraphs p where p.passage_id = 'c0000002-0000-0000-0000-000000000002' and p.ord = 1;

-- para 2
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'Whoever sets the default holds quiet power.',
  '[{"key":"1","text":"Whoever sets the default"},{"key":"2","text":"the default"},{"key":"3","text":"quiet power"},{"key":"4","text":"power"}]', '1',
  '복합관계대명사 whoever 명사절 전체가 주어.'
from te_paragraphs p where p.passage_id = 'c0000002-0000-0000-0000-000000000002' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"The design of forms, menus, and settings ____ never neutral." 빈칸에 알맞은 것은?', 'The design of forms, menus, and settings ___ never neutral, even when it looks technical.',
  '[{"key":"1","text":"are"},{"key":"2","text":"is"},{"key":"3","text":"have"},{"key":"4","text":"were"}]', '2',
  '주어 "The design" 단수 → is.'
from te_paragraphs p where p.passage_id = 'c0000002-0000-0000-0000-000000000002' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"even when it looks technical"의 역할은?', '... is never neutral, even when it looks technical.',
  '[{"key":"1","text":"양보 부사절 (even when)"},{"key":"2","text":"명사절"},{"key":"3","text":"형용사절"},{"key":"4","text":"보어"}]', '1',
  '"even when"이 이끄는 양보 부사절.'
from te_paragraphs p where p.passage_id = 'c0000002-0000-0000-0000-000000000002' and p.ord = 2;

-- ============ c0000003 When Numbers Lie by Telling the Truth ============
-- para 0
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'The trend looks dramatic only because of where the line begins.',
  '[{"key":"1","text":"The trend"},{"key":"2","text":"dramatic"},{"key":"3","text":"the line"},{"key":"4","text":"only"}]', '1',
  '동사 looks의 주어는 "The trend".'
from te_paragraphs p where p.passage_id = 'c0000003-0000-0000-0000-000000000003' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"The number ____ true, but the period chosen runs from an unusual spike to an ordinary year." 빈칸에 알맞은 것은?', 'The number ___ true, but the period chosen runs from an unusual spike to an ordinary year.',
  '[{"key":"1","text":"are"},{"key":"2","text":"is"},{"key":"3","text":"have"},{"key":"4","text":"were"}]', '2',
  '주어 "The number" 단수 → is.'
from te_paragraphs p where p.passage_id = 'c0000003-0000-0000-0000-000000000003' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"where the line begins"의 역할은?', 'only because of where the line begins',
  '[{"key":"1","text":"전치사 of의 목적어 명사절"},{"key":"2","text":"부사절"},{"key":"3","text":"형용사절"},{"key":"4","text":"독립절"}]', '1',
  '관계부사 where가 이끄는 명사절이 of의 목적어.'
from te_paragraphs p where p.passage_id = 'c0000003-0000-0000-0000-000000000003' and p.ord = 0;

-- para 1
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'Averages also hide as much as they show.',
  '[{"key":"1","text":"Averages"},{"key":"2","text":"as much"},{"key":"3","text":"they"},{"key":"4","text":"as"}]', '1',
  '동사 hide의 주어는 "Averages".'
from te_paragraphs p where p.passage_id = 'c0000003-0000-0000-0000-000000000003' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"The average income in a room ____ rise sharply if one billionaire walks in." 빈칸에 알맞은 것은?', 'The average income in a room ___ rise sharply if one billionaire walks in.',
  '[{"key":"1","text":"can"},{"key":"2","text":"are"},{"key":"3","text":"have"},{"key":"4","text":"is"}]', '1',
  '뒤에 동사원형 rise가 오므로 조동사 can.'
from te_paragraphs p where p.passage_id = 'c0000003-0000-0000-0000-000000000003' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"even though everyone else earned nothing new"의 역할은?', '... even though everyone else earned nothing new.',
  '[{"key":"1","text":"양보 부사절"},{"key":"2","text":"명사절"},{"key":"3","text":"형용사절"},{"key":"4","text":"보어"}]', '1',
  'even though 절은 양보 부사절.'
from te_paragraphs p where p.passage_id = 'c0000003-0000-0000-0000-000000000003' and p.ord = 1;

-- para 2
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'A careful reader asks not what the number is but how it was made.',
  '[{"key":"1","text":"A careful reader"},{"key":"2","text":"the number"},{"key":"3","text":"it"},{"key":"4","text":"how"}]', '1',
  '동사 asks의 주어는 "A careful reader".'
from te_paragraphs p where p.passage_id = 'c0000003-0000-0000-0000-000000000003' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"The framing of a statistic often ____ its meaning." 빈칸에 알맞은 것은?', 'The framing of a statistic often ___ its meaning before the digits ever appear.',
  '[{"key":"1","text":"decide"},{"key":"2","text":"decides"},{"key":"3","text":"are deciding"},{"key":"4","text":"have decided"}]', '2',
  '주어 "The framing" 단수 → decides.'
from te_paragraphs p where p.passage_id = 'c0000003-0000-0000-0000-000000000003' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"not what the number is but how it was made"의 구조는?', 'asks not what the number is but how it was made.',
  '[{"key":"1","text":"not A but B 상관접속사로 연결된 두 명사절 (asks의 목적어)"},{"key":"2","text":"부사절"},{"key":"3","text":"형용사절"},{"key":"4","text":"독립절"}]', '1',
  '두 명사절이 not A but B 구조로 병렬, asks의 목적어.'
from te_paragraphs p where p.passage_id = 'c0000003-0000-0000-0000-000000000003' and p.ord = 2;

-- ============ c0000004 The Cost of Constant Connection ============
-- para 0
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'Studies show that simply having a smartphone on the table during a conversation reduces how connected the participants feel.',
  '[{"key":"1","text":"Studies"},{"key":"2","text":"a smartphone"},{"key":"3","text":"the participants"},{"key":"4","text":"the table"}]', '1',
  '주절 동사 show의 주어는 "Studies".'
from te_paragraphs p where p.passage_id = 'c0000004-0000-0000-0000-000000000004' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"Having a smartphone on the table ____ how connected the participants feel." 빈칸에 알맞은 것은?', '... simply having a smartphone on the table during a conversation ___ how connected the participants feel.',
  '[{"key":"1","text":"reduce"},{"key":"2","text":"reduces"},{"key":"3","text":"are reducing"},{"key":"4","text":"have reduced"}]', '2',
  '동명사구 주어 (having ~)는 단수 → reduces.'
from te_paragraphs p where p.passage_id = 'c0000004-0000-0000-0000-000000000004' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"even when the phone never lights up"의 역할은?', '... reduces how connected the participants feel, even when the phone never lights up.',
  '[{"key":"1","text":"양보 부사절"},{"key":"2","text":"명사절"},{"key":"3","text":"형용사절"},{"key":"4","text":"보어"}]', '1',
  'even when 절은 양보 부사절.'
from te_paragraphs p where p.passage_id = 'c0000004-0000-0000-0000-000000000004' and p.ord = 0;

-- para 1
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'A part of attention stays ready for the device, which leaves less attention for the people in the room.',
  '[{"key":"1","text":"A part of attention"},{"key":"2","text":"the device"},{"key":"3","text":"less attention"},{"key":"4","text":"the people"}]', '1',
  '주절 동사 stays의 주어는 "A part of attention".'
from te_paragraphs p where p.passage_id = 'c0000004-0000-0000-0000-000000000004' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"The brain ____ the possibility of an alert like a low background hum." 빈칸에 알맞은 것은?', 'The brain ___ the possibility of an alert like a low background hum.',
  '[{"key":"1","text":"treat"},{"key":"2","text":"treats"},{"key":"3","text":"are treating"},{"key":"4","text":"have treated"}]', '2',
  '주어 "The brain" 단수 → treats.'
from te_paragraphs p where p.passage_id = 'c0000004-0000-0000-0000-000000000004' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"which leaves less attention for the people in the room"의 역할은?', '... stays ready for the device, which leaves less attention for the people in the room.',
  '[{"key":"1","text":"앞 절 전체를 받는 계속적 용법 관계절"},{"key":"2","text":"부사절"},{"key":"3","text":"명사절"},{"key":"4","text":"보어"}]', '1',
  '계속적 용법의 관계대명사 which가 앞 문장 전체를 선행사로 받음.'
from te_paragraphs p where p.passage_id = 'c0000004-0000-0000-0000-000000000004' and p.ord = 1;

-- para 2
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'The fix is not to throw away the phone but to recognize the cost.',
  '[{"key":"1","text":"The fix"},{"key":"2","text":"the phone"},{"key":"3","text":"the cost"},{"key":"4","text":"to throw"}]', '1',
  'is의 주어는 "The fix".'
from te_paragraphs p where p.passage_id = 'c0000004-0000-0000-0000-000000000004' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"Putting the device out of sight ____ the depth of the conversation that follows." 빈칸에 알맞은 것은?', 'Putting the device out of sight for a defined period ___ the depth of the conversation that follows.',
  '[{"key":"1","text":"change"},{"key":"2","text":"changes"},{"key":"3","text":"are changing"},{"key":"4","text":"have changed"}]', '2',
  '동명사구 주어 (Putting ~) 단수 → changes.'
from te_paragraphs p where p.passage_id = 'c0000004-0000-0000-0000-000000000004' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"not to throw away the phone but to recognize the cost"의 구조는?', 'The fix is not to throw away the phone but to recognize the cost.',
  '[{"key":"1","text":"not A but B로 연결된 두 to부정사구 (보어)"},{"key":"2","text":"부사절"},{"key":"3","text":"형용사절"},{"key":"4","text":"명사절"}]', '1',
  'not A but B 상관접속사로 두 to부정사구가 병렬 보어.'
from te_paragraphs p where p.passage_id = 'c0000004-0000-0000-0000-000000000004' and p.ord = 2;

-- ============ c0000005 How Maps Quietly Argue ============
-- para 0
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'The choice of projection quietly decides which countries look large or small.',
  '[{"key":"1","text":"The choice of projection"},{"key":"2","text":"which countries"},{"key":"3","text":"projection"},{"key":"4","text":"large or small"}]', '1',
  '주어 "The choice of projection". 동사 decides.'
from te_paragraphs p where p.passage_id = 'c0000005-0000-0000-0000-000000000005' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"A flat map of the round earth ____ always a compromise." 빈칸에 알맞은 것은?', 'A flat map of the round earth ___ always a compromise.',
  '[{"key":"1","text":"are"},{"key":"2","text":"is"},{"key":"3","text":"have"},{"key":"4","text":"were"}]', '2',
  '주어 "A flat map" 단수 → is.'
from te_paragraphs p where p.passage_id = 'c0000005-0000-0000-0000-000000000005' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"which countries look large or small"의 역할은?', 'decides which countries look large or small.',
  '[{"key":"1","text":"decides의 목적어 명사절 (간접의문문)"},{"key":"2","text":"부사절"},{"key":"3","text":"형용사절"},{"key":"4","text":"보어"}]', '1',
  '의문형용사 which가 이끄는 명사절이 decides의 목적어.'
from te_paragraphs p where p.passage_id = 'c0000005-0000-0000-0000-000000000005' and p.ord = 0;

-- para 1
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'A river that shifts each year becomes a single fixed line in the atlas.',
  '[{"key":"1","text":"A river"},{"key":"2","text":"each year"},{"key":"3","text":"a single fixed line"},{"key":"4","text":"the atlas"}]', '1',
  '주절 동사 becomes의 주어는 "A river". 사이의 that절은 형용사절.'
from te_paragraphs p where p.passage_id = 'c0000005-0000-0000-0000-000000000005' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"Borders ____ often drawn cleanly on the page." 빈칸에 알맞은 것은?', 'Borders, too, ___ often drawn cleanly on the page where the ground itself is messy.',
  '[{"key":"1","text":"is"},{"key":"2","text":"are"},{"key":"3","text":"has"},{"key":"4","text":"was"}]', '2',
  '주어 Borders 복수, 수동태 → are drawn.'
from te_paragraphs p where p.passage_id = 'c0000005-0000-0000-0000-000000000005' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"where the ground itself is messy"의 역할은?', 'on the page where the ground itself is messy',
  '[{"key":"1","text":"the page를 수식하는 관계부사절 (형용사절)"},{"key":"2","text":"부사절"},{"key":"3","text":"명사절"},{"key":"4","text":"보어"}]', '1',
  '관계부사 where가 이끄는 형용사절이 the page 수식.'
from te_paragraphs p where p.passage_id = 'c0000005-0000-0000-0000-000000000005' and p.ord = 1;

-- para 2
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'A reader who notices these choices begins to read maps the way a critic reads paintings.',
  '[{"key":"1","text":"A reader"},{"key":"2","text":"these choices"},{"key":"3","text":"maps"},{"key":"4","text":"a critic"}]', '1',
  '주절 동사 begins의 주어는 "A reader". who절은 형용사절.'
from te_paragraphs p where p.passage_id = 'c0000005-0000-0000-0000-000000000005' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"The image ____ not the world; it is one argument about the world." 빈칸에 알맞은 것은?', 'The image ___ not the world; it is one argument about the world.',
  '[{"key":"1","text":"are"},{"key":"2","text":"is"},{"key":"3","text":"have"},{"key":"4","text":"were"}]', '2',
  '주어 "The image" 단수 → is.'
from te_paragraphs p where p.passage_id = 'c0000005-0000-0000-0000-000000000005' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"the way a critic reads paintings"의 역할은?', 'read maps the way a critic reads paintings',
  '[{"key":"1","text":"방식을 나타내는 부사절 (the way = as)"},{"key":"2","text":"명사절"},{"key":"3","text":"형용사절"},{"key":"4","text":"보어"}]', '1',
  '"the way + 절" = "~하는 방식으로" 부사절.'
from te_paragraphs p where p.passage_id = 'c0000005-0000-0000-0000-000000000005' and p.ord = 2;

-- ============ c0000006 The Limits of Imitation ============
-- para 0
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'The hand learns through the muscles what the eyes have only seen so far.',
  '[{"key":"1","text":"The hand"},{"key":"2","text":"the muscles"},{"key":"3","text":"the eyes"},{"key":"4","text":"so far"}]', '1',
  '동사 learns의 주어는 "The hand".'
from te_paragraphs p where p.passage_id = 'c0000006-0000-0000-0000-000000000006' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"Beginning students ____ a master to absorb how each line is made." 빈칸에 알맞은 것은?', 'Beginning students ___ a master to absorb how each line is made.',
  '[{"key":"1","text":"copies"},{"key":"2","text":"copy"},{"key":"3","text":"is copying"},{"key":"4","text":"has copied"}]', '2',
  '주어 students 복수 → copy.'
from te_paragraphs p where p.passage_id = 'c0000006-0000-0000-0000-000000000006' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"what the eyes have only seen so far"의 역할은?', 'The hand learns through the muscles what the eyes have only seen so far.',
  '[{"key":"1","text":"learns의 목적어 명사절 (관계대명사 what)"},{"key":"2","text":"부사절"},{"key":"3","text":"형용사절"},{"key":"4","text":"보어"}]', '1',
  '관계대명사 what이 이끄는 명사절이 learns의 목적어.'
from te_paragraphs p where p.passage_id = 'c0000006-0000-0000-0000-000000000006' and p.ord = 0;

-- para 1
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'The student who never risks her own line repeats the master''s strengths but also his limits.',
  '[{"key":"1","text":"The student"},{"key":"2","text":"her own line"},{"key":"3","text":"the master"},{"key":"4","text":"his limits"}]', '1',
  '주절 동사 repeats의 주어는 "The student". who절은 형용사절.'
from te_paragraphs p where p.passage_id = 'c0000006-0000-0000-0000-000000000006' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"The imitation ____ a ceiling." 빈칸에 알맞은 것은?', 'At a certain point, however, the imitation ___ a ceiling.',
  '[{"key":"1","text":"become"},{"key":"2","text":"becomes"},{"key":"3","text":"are becoming"},{"key":"4","text":"have become"}]', '2',
  '주어 "the imitation" 단수 → becomes.'
from te_paragraphs p where p.passage_id = 'c0000006-0000-0000-0000-000000000006' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"who never risks her own line"의 역할은?', 'The student who never risks her own line',
  '[{"key":"1","text":"The student를 수식하는 형용사절"},{"key":"2","text":"부사절"},{"key":"3","text":"명사절"},{"key":"4","text":"보어"}]', '1',
  '관계대명사 who 절이 The student를 수식.'
from te_paragraphs p where p.passage_id = 'c0000006-0000-0000-0000-000000000006' and p.ord = 1;

-- para 2
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'Real growth begins when the imitator misses on purpose, leaving in the mistakes that turn out to be a voice.',
  '[{"key":"1","text":"Real growth"},{"key":"2","text":"the imitator"},{"key":"3","text":"the mistakes"},{"key":"4","text":"a voice"}]', '1',
  '주절 동사 begins의 주어는 "Real growth".'
from te_paragraphs p where p.passage_id = 'c0000006-0000-0000-0000-000000000006' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"The same path that started in copying ____ in something new." 빈칸에 알맞은 것은?', 'The same path that started in copying ___ in something new.',
  '[{"key":"1","text":"end"},{"key":"2","text":"ends"},{"key":"3","text":"are ending"},{"key":"4","text":"have ended"}]', '2',
  '주어 "The same path" 단수 → ends.'
from te_paragraphs p where p.passage_id = 'c0000006-0000-0000-0000-000000000006' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"leaving in the mistakes that turn out to be a voice"의 역할은?', '... misses on purpose, leaving in the mistakes that turn out to be a voice.',
  '[{"key":"1","text":"분사구문 (부사 역할)"},{"key":"2","text":"독립절"},{"key":"3","text":"명사절"},{"key":"4","text":"보어"}]', '1',
  '현재분사로 시작하는 분사구문 (동시동작/부연설명).'
from te_paragraphs p where p.passage_id = 'c0000006-0000-0000-0000-000000000006' and p.ord = 2;

-- ============ c0000007 Why Forgetting Helps Thinking ============
-- para 0
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'Forgetting is often described as failure, but it is also a quiet form of editing.',
  '[{"key":"1","text":"Forgetting"},{"key":"2","text":"failure"},{"key":"3","text":"editing"},{"key":"4","text":"a quiet form"}]', '1',
  '첫 절의 동사 is described의 주어는 동명사 Forgetting.'
from te_paragraphs p where p.passage_id = 'c0000007-0000-0000-0000-000000000007' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"Every old phone number, address, and trivial conversation ____ crowd the mind permanently." 빈칸에 알맞은 것은?', 'Without it, every old phone number, address, and trivial conversation ___ crowd the mind permanently.',
  '[{"key":"1","text":"would"},{"key":"2","text":"are"},{"key":"3","text":"has"},{"key":"4","text":"is"}]', '1',
  '뒤에 동사원형 crowd가 오고 가정법 의미 → would.'
from te_paragraphs p where p.passage_id = 'c0000007-0000-0000-0000-000000000007' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"Without it"의 역할은?', 'Without it, every old phone number ... would crowd the mind.',
  '[{"key":"1","text":"가정법 조건의 전치사구 (if it were not for ~)"},{"key":"2","text":"주어"},{"key":"3","text":"보어"},{"key":"4","text":"명사절"}]', '1',
  '"Without ~" = "~이 없다면" 가정법 조건 부사구.'
from te_paragraphs p where p.passage_id = 'c0000007-0000-0000-0000-000000000007' and p.ord = 0;

-- para 1
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'Studies of people who cannot forget show that their lives are filled with intrusive detail rather than richer thought.',
  '[{"key":"1","text":"Studies of people who cannot forget"},{"key":"2","text":"their lives"},{"key":"3","text":"intrusive detail"},{"key":"4","text":"richer thought"}]', '1',
  '주절 동사 show의 주어는 "Studies of people who cannot forget".'
from te_paragraphs p where p.passage_id = 'c0000007-0000-0000-0000-000000000007' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"Memory weighed down by everything ____ no room to compare or generalize." 빈칸에 알맞은 것은?', 'Memory weighed down by everything ___ no room to compare or generalize.',
  '[{"key":"1","text":"have"},{"key":"2","text":"has"},{"key":"3","text":"are having"},{"key":"4","text":"having"}]', '2',
  '주어 Memory 단수 → has.'
from te_paragraphs p where p.passage_id = 'c0000007-0000-0000-0000-000000000007' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"weighed down by everything"의 역할은?', 'Memory weighed down by everything has no room.',
  '[{"key":"1","text":"Memory를 수식하는 과거분사구"},{"key":"2","text":"부사절"},{"key":"3","text":"동사"},{"key":"4","text":"보어"}]', '1',
  '과거분사구가 Memory를 뒤에서 수식 (수동 의미).'
from te_paragraphs p where p.passage_id = 'c0000007-0000-0000-0000-000000000007' and p.ord = 1;

-- para 2
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'The form emerges from what has been removed, not only from what remains.',
  '[{"key":"1","text":"The form"},{"key":"2","text":"what has been removed"},{"key":"3","text":"what remains"},{"key":"4","text":"only"}]', '1',
  '동사 emerges의 주어는 "The form".'
from te_paragraphs p where p.passage_id = 'c0000007-0000-0000-0000-000000000007' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"Good thinking ____ less like collecting and more like sculpting." 빈칸에 알맞은 것은?', 'Good thinking, then, ___ less like collecting and more like sculpting.',
  '[{"key":"1","text":"are"},{"key":"2","text":"is"},{"key":"3","text":"have"},{"key":"4","text":"were"}]', '2',
  '주어 "Good thinking" 동명사 단수 → is.'
from te_paragraphs p where p.passage_id = 'c0000007-0000-0000-0000-000000000007' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"what has been removed"의 역할은?', 'emerges from what has been removed',
  '[{"key":"1","text":"전치사 from의 목적어 명사절 (관계대명사 what)"},{"key":"2","text":"부사절"},{"key":"3","text":"형용사절"},{"key":"4","text":"보어"}]', '1',
  '관계대명사 what이 이끄는 명사절이 from의 목적어.'
from te_paragraphs p where p.passage_id = 'c0000007-0000-0000-0000-000000000007' and p.ord = 2;

-- ============ c0000008 The Hidden Politics of Search ============
-- para 0
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'They predict which pages are most useful to each individual, based on past behavior, location, and many signals invisible to the user.',
  '[{"key":"1","text":"They"},{"key":"2","text":"which pages"},{"key":"3","text":"each individual"},{"key":"4","text":"signals"}]', '1',
  '동사 predict의 주어는 "They" (Search engines).'
from te_paragraphs p where p.passage_id = 'c0000008-0000-0000-0000-000000000008' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"Search engines ____ not present a fixed list of pages." 빈칸에 알맞은 것은?', 'Search engines ___ not present a fixed list of pages.',
  '[{"key":"1","text":"is"},{"key":"2","text":"do"},{"key":"3","text":"has"},{"key":"4","text":"was"}]', '2',
  '주어 engines 복수 + 일반동사 부정 → do not.'
from te_paragraphs p where p.passage_id = 'c0000008-0000-0000-0000-000000000008' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"based on past behavior, location, and many signals invisible to the user"의 역할은?', '... predict which pages are most useful to each individual, based on past behavior ...',
  '[{"key":"1","text":"분사구문 (수동, 부사 역할)"},{"key":"2","text":"주어"},{"key":"3","text":"보어"},{"key":"4","text":"명사절"}]', '1',
  '과거분사 based로 시작하는 분사구문 (= which are based ~).'
from te_paragraphs p where p.passage_id = 'c0000008-0000-0000-0000-000000000008' and p.ord = 0;

-- para 1
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'This personalization can be convenient, but it also means two readers cannot fully share what they have seen.',
  '[{"key":"1","text":"This personalization"},{"key":"2","text":"two readers"},{"key":"3","text":"what they have seen"},{"key":"4","text":"convenient"}]', '1',
  '첫 절 주어는 "This personalization".'
from te_paragraphs p where p.passage_id = 'c0000008-0000-0000-0000-000000000008' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"Public debate ____ harder when each citizen reads from a slightly different page." 빈칸에 알맞은 것은?', 'Public debate ___ harder when each citizen reads from a slightly different page.',
  '[{"key":"1","text":"become"},{"key":"2","text":"becomes"},{"key":"3","text":"are becoming"},{"key":"4","text":"have become"}]', '2',
  '주어 "Public debate" 단수 → becomes.'
from te_paragraphs p where p.passage_id = 'c0000008-0000-0000-0000-000000000008' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"what they have seen"의 역할은?', 'two readers cannot fully share what they have seen.',
  '[{"key":"1","text":"share의 목적어 명사절 (관계대명사 what)"},{"key":"2","text":"부사절"},{"key":"3","text":"형용사절"},{"key":"4","text":"보어"}]', '1',
  '관계대명사 what이 이끄는 명사절이 share의 목적어.'
from te_paragraphs p where p.passage_id = 'c0000008-0000-0000-0000-000000000008' and p.ord = 1;

-- para 2
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'A neutral-looking search bar carries decisions made elsewhere.',
  '[{"key":"1","text":"A neutral-looking search bar"},{"key":"2","text":"decisions"},{"key":"3","text":"elsewhere"},{"key":"4","text":"neutral"}]', '1',
  '동사 carries의 주어는 "A neutral-looking search bar".'
from te_paragraphs p where p.passage_id = 'c0000008-0000-0000-0000-000000000008' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"Knowing this ____ not change the results." 빈칸에 알맞은 것은?', 'Knowing this ___ not change the results, but it changes the trust the reader places in them.',
  '[{"key":"1","text":"do"},{"key":"2","text":"does"},{"key":"3","text":"are"},{"key":"4","text":"have"}]', '2',
  '동명사구 "Knowing this" 단수 → does not change.'
from te_paragraphs p where p.passage_id = 'c0000008-0000-0000-0000-000000000008' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"made elsewhere"의 역할은?', 'carries decisions made elsewhere',
  '[{"key":"1","text":"decisions를 수식하는 과거분사구"},{"key":"2","text":"부사절"},{"key":"3","text":"동사"},{"key":"4","text":"독립절"}]', '1',
  '과거분사구가 decisions를 뒤에서 수식 (수동 의미).'
from te_paragraphs p where p.passage_id = 'c0000008-0000-0000-0000-000000000008' and p.ord = 2;

-- ============ c0000009 The Long Tail of an Apology ============
-- para 0
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'The person harmed keeps repeating the event in private, trying to make sense of what happened.',
  '[{"key":"1","text":"The person harmed"},{"key":"2","text":"the event"},{"key":"3","text":"what happened"},{"key":"4","text":"private"}]', '1',
  '주절 동사 keeps의 주어는 "The person harmed" (과거분사 후치수식).'
from te_paragraphs p where p.passage_id = 'c0000009-0000-0000-0000-000000000009' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"When a wrong is followed by silence, the memory of it ____ sharp." 빈칸에 알맞은 것은?', 'When a wrong is followed by silence, the memory of it ___ sharp.',
  '[{"key":"1","text":"stay"},{"key":"2","text":"stays"},{"key":"3","text":"are staying"},{"key":"4","text":"have stayed"}]', '2',
  '주어 "the memory" 단수 → stays.'
from te_paragraphs p where p.passage_id = 'c0000009-0000-0000-0000-000000000009' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"trying to make sense of what happened"의 역할은?', '... keeps repeating the event in private, trying to make sense of what happened.',
  '[{"key":"1","text":"분사구문 (동시동작)"},{"key":"2","text":"독립절"},{"key":"3","text":"명사절"},{"key":"4","text":"보어"}]', '1',
  '현재분사로 시작하는 분사구문 (동시동작 부사).'
from te_paragraphs p where p.passage_id = 'c0000009-0000-0000-0000-000000000009' and p.ord = 0;

-- para 1
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'The story can now include the words that closed it, not only the moment that opened it.',
  '[{"key":"1","text":"The story"},{"key":"2","text":"the words"},{"key":"3","text":"the moment"},{"key":"4","text":"it"}]', '1',
  '동사 include의 주어는 "The story".'
from te_paragraphs p where p.passage_id = 'c0000009-0000-0000-0000-000000000009' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"A real apology ____ not undo the act." 빈칸에 알맞은 것은?', 'A real apology ___ not undo the act.',
  '[{"key":"1","text":"do"},{"key":"2","text":"does"},{"key":"3","text":"are"},{"key":"4","text":"have"}]', '2',
  '주어 단수 + 일반동사 부정 → does not undo.'
from te_paragraphs p where p.passage_id = 'c0000009-0000-0000-0000-000000000009' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"the words that closed it, not only the moment that opened it"의 구조는?', 'include the words that closed it, not only the moment that opened it.',
  '[{"key":"1","text":"두 명사구가 not only ~ but also (생략) 구조로 병렬"},{"key":"2","text":"부사절"},{"key":"3","text":"형용사절"},{"key":"4","text":"독립절"}]', '1',
  '두 명사구가 병렬되며 각자 that 관계절을 가짐.'
from te_paragraphs p where p.passage_id = 'c0000009-0000-0000-0000-000000000009' and p.ord = 1;

-- para 2
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'The timing of an apology matters as much as its content.',
  '[{"key":"1","text":"The timing of an apology"},{"key":"2","text":"its content"},{"key":"3","text":"an apology"},{"key":"4","text":"as much"}]', '1',
  '동사 matters의 주어는 "The timing of an apology".'
from te_paragraphs p where p.passage_id = 'c0000009-0000-0000-0000-000000000009' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"A late apology ____ less." 빈칸에 알맞은 것은?', 'A late apology ___ less because by then the story has hardened into its private form.',
  '[{"key":"1","text":"repair"},{"key":"2","text":"repairs"},{"key":"3","text":"are repairing"},{"key":"4","text":"have repaired"}]', '2',
  '주어 "A late apology" 단수 → repairs.'
from te_paragraphs p where p.passage_id = 'c0000009-0000-0000-0000-000000000009' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"as much as its content"의 역할은?', 'matters as much as its content.',
  '[{"key":"1","text":"동등비교 부사구문 (as ~ as)"},{"key":"2","text":"명사절"},{"key":"3","text":"형용사절"},{"key":"4","text":"주어"}]', '1',
  'as much as ~: 동등비교 부사구.'
from te_paragraphs p where p.passage_id = 'c0000009-0000-0000-0000-000000000009' and p.ord = 2;

-- ============ c000000a Why Cities Outlive Empires ============
-- para 0
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'Babylon, Constantinople, and many ancient capitals outlasted the powers that founded them.',
  '[{"key":"1","text":"Babylon, Constantinople, and many ancient capitals"},{"key":"2","text":"the powers"},{"key":"3","text":"them"},{"key":"4","text":"that"}]', '1',
  '복수 명사구가 and로 연결된 복합 주어.'
from te_paragraphs p where p.passage_id = 'c000000a-0000-0000-0000-00000000000a' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"Infrastructure ____ a longer memory than rulers." 빈칸에 알맞은 것은?', 'Infrastructure ___ a longer memory than rulers.',
  '[{"key":"1","text":"have"},{"key":"2","text":"has"},{"key":"3","text":"are"},{"key":"4","text":"were"}]', '2',
  '주어 Infrastructure 불가산명사 단수 → has.'
from te_paragraphs p where p.passage_id = 'c000000a-0000-0000-0000-00000000000a' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"that founded them"의 수식 대상은?', 'the powers that founded them',
  '[{"key":"1","text":"the powers"},{"key":"2","text":"capitals"},{"key":"3","text":"Babylon"},{"key":"4","text":"Rome"}]', '1',
  '관계대명사 that 절이 the powers를 수식.'
from te_paragraphs p where p.passage_id = 'c000000a-0000-0000-0000-00000000000a' and p.ord = 0;

-- para 1
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'Roads, harbors, and walls keep doing useful work long after their original purpose ends.',
  '[{"key":"1","text":"Roads, harbors, and walls"},{"key":"2","text":"useful work"},{"key":"3","text":"their original purpose"},{"key":"4","text":"after"}]', '1',
  '주절 동사 keep의 주어는 "Roads, harbors, and walls" 복합 주어.'
from te_paragraphs p where p.passage_id = 'c000000a-0000-0000-0000-00000000000a' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"New generations ____ their lives along old stones." 빈칸에 알맞은 것은?', 'New generations ___ their lives along old stones without noticing whose feet first wore them down.',
  '[{"key":"1","text":"routes"},{"key":"2","text":"route"},{"key":"3","text":"is routing"},{"key":"4","text":"has routed"}]', '2',
  '주어 generations 복수 → route.'
from te_paragraphs p where p.passage_id = 'c000000a-0000-0000-0000-00000000000a' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"whose feet first wore them down"의 역할은?', 'without noticing whose feet first wore them down',
  '[{"key":"1","text":"noticing의 목적어 명사절 (의문사 whose)"},{"key":"2","text":"부사절"},{"key":"3","text":"형용사절"},{"key":"4","text":"보어"}]', '1',
  '의문사 whose가 이끄는 간접의문문이 동명사 noticing의 목적어.'
from te_paragraphs p where p.passage_id = 'c000000a-0000-0000-0000-00000000000a' and p.ord = 1;

-- para 2
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'A city is therefore a kind of fossil and a living organism at the same time.',
  '[{"key":"1","text":"A city"},{"key":"2","text":"a kind of fossil"},{"key":"3","text":"a living organism"},{"key":"4","text":"the same time"}]', '1',
  '동사 is의 주어는 "A city".'
from te_paragraphs p where p.passage_id = 'c000000a-0000-0000-0000-00000000000a' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"It ____ decisions that nobody alive made." 빈칸에 알맞은 것은?', 'It ___ decisions that nobody alive made, and it shapes decisions that nobody dead can predict.',
  '[{"key":"1","text":"carry"},{"key":"2","text":"carries"},{"key":"3","text":"are carrying"},{"key":"4","text":"have carried"}]', '2',
  '주어 It 단수 → carries.'
from te_paragraphs p where p.passage_id = 'c000000a-0000-0000-0000-00000000000a' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"that nobody alive made"의 역할은?', 'decisions that nobody alive made',
  '[{"key":"1","text":"decisions를 수식하는 형용사절 (목적격 관계대명사 that)"},{"key":"2","text":"부사절"},{"key":"3","text":"보어"},{"key":"4","text":"명사절"}]', '1',
  '관계대명사 that 절이 decisions를 수식.'
from te_paragraphs p where p.passage_id = 'c000000a-0000-0000-0000-00000000000a' and p.ord = 2;

-- ============ c000000b The Paradox of Choice in Markets ============
-- para 0
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'Classical economics assumes that more options serve the buyer.',
  '[{"key":"1","text":"Classical economics"},{"key":"2","text":"more options"},{"key":"3","text":"the buyer"},{"key":"4","text":"that"}]', '1',
  '주절 동사 assumes의 주어는 "Classical economics" (단수 취급).'
from te_paragraphs p where p.passage_id = 'c000000b-0000-0000-0000-00000000000b' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"In practice, when the number of options grows large, decisions ____ slower." 빈칸에 알맞은 것은?', 'In practice, when the number of options grows large, decisions ___ slower.',
  '[{"key":"1","text":"becomes"},{"key":"2","text":"become"},{"key":"3","text":"is becoming"},{"key":"4","text":"has become"}]', '2',
  '주절 주어 decisions 복수 → become.'
from te_paragraphs p where p.passage_id = 'c000000b-0000-0000-0000-00000000000b' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"that more options serve the buyer"의 역할은?', 'assumes that more options serve the buyer.',
  '[{"key":"1","text":"assumes의 목적어 명사절"},{"key":"2","text":"부사절"},{"key":"3","text":"형용사절"},{"key":"4","text":"보어"}]', '1',
  '접속사 that 명사절이 assumes의 목적어.'
from te_paragraphs p where p.passage_id = 'c000000b-0000-0000-0000-00000000000b' and p.ord = 0;

-- para 1
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'The chosen option must now defend itself against forty unseen rivals.',
  '[{"key":"1","text":"The chosen option"},{"key":"2","text":"itself"},{"key":"3","text":"forty unseen rivals"},{"key":"4","text":"now"}]', '1',
  '동사 defend의 주어는 "The chosen option".'
from te_paragraphs p where p.passage_id = 'c000000b-0000-0000-0000-00000000000b' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"The buyer ____ an invisible burden." 빈칸에 알맞은 것은?', 'The buyer ___ an invisible burden.',
  '[{"key":"1","text":"carry"},{"key":"2","text":"carries"},{"key":"3","text":"are carrying"},{"key":"4","text":"have carried"}]', '2',
  '주어 "The buyer" 단수 → carries.'
from te_paragraphs p where p.passage_id = 'c000000b-0000-0000-0000-00000000000b' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"Could one of the other options have been better?"의 역할은? (앞 문장 맥락)', 'Every choice opens new questions: Could one of the other options have been better?',
  '[{"key":"1","text":"questions의 내용을 보여주는 직접의문문 (콜론 뒤)"},{"key":"2","text":"부사절"},{"key":"3","text":"형용사절"},{"key":"4","text":"명사절"}]', '1',
  '콜론 뒤에 questions의 구체 내용을 직접의문문으로 제시.'
from te_paragraphs p where p.passage_id = 'c000000b-0000-0000-0000-00000000000b' and p.ord = 1;

-- para 2
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'Well-designed markets curate choice rather than maximize it.',
  '[{"key":"1","text":"Well-designed markets"},{"key":"2","text":"choice"},{"key":"3","text":"it"},{"key":"4","text":"rather"}]', '1',
  '동사 curate의 주어는 "Well-designed markets".'
from te_paragraphs p where p.passage_id = 'c000000b-0000-0000-0000-00000000000b' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"A shorter list ____ buyers who feel both freer and happier." 빈칸에 알맞은 것은?', 'A shorter list, chosen with care, often ___ buyers who feel both freer and happier than a longer list ever could.',
  '[{"key":"1","text":"produce"},{"key":"2","text":"produces"},{"key":"3","text":"are producing"},{"key":"4","text":"have produced"}]', '2',
  '주어 "A shorter list" 단수 → produces.'
from te_paragraphs p where p.passage_id = 'c000000b-0000-0000-0000-00000000000b' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"chosen with care"의 역할은?', 'A shorter list, chosen with care, often produces buyers ...',
  '[{"key":"1","text":"A shorter list를 수식하는 분사구 (콤마 삽입)"},{"key":"2","text":"동사"},{"key":"3","text":"부사절"},{"key":"4","text":"보어"}]', '1',
  '과거분사구가 콤마 사이에 삽입되어 A shorter list를 수식.'
from te_paragraphs p where p.passage_id = 'c000000b-0000-0000-0000-00000000000b' and p.ord = 2;

-- ============ c000000c When Help Hurts ============
-- para 0
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'A donation of free shoes to a struggling area sounds harmless.',
  '[{"key":"1","text":"A donation of free shoes to a struggling area"},{"key":"2","text":"free shoes"},{"key":"3","text":"a struggling area"},{"key":"4","text":"harmless"}]', '1',
  '주어는 명사구 "A donation of free shoes to a struggling area" 전체.'
from te_paragraphs p where p.passage_id = 'c000000c-0000-0000-0000-00000000000c' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"Local shoemakers, who survive on small margins, suddenly ____ their customers." 빈칸에 알맞은 것은?', 'Yet local shoemakers, who survive on small margins, suddenly ___ their customers.',
  '[{"key":"1","text":"loses"},{"key":"2","text":"lose"},{"key":"3","text":"is losing"},{"key":"4","text":"has lost"}]', '2',
  '주어 shoemakers 복수 → lose.'
from te_paragraphs p where p.passage_id = 'c000000c-0000-0000-0000-00000000000c' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"who survive on small margins"의 역할은?', 'local shoemakers, who survive on small margins, suddenly lose their customers.',
  '[{"key":"1","text":"계속적 용법의 관계절 (shoemakers 부연설명)"},{"key":"2","text":"제한적 용법의 관계절"},{"key":"3","text":"부사절"},{"key":"4","text":"독립절"}]', '1',
  '콤마가 있는 계속적 용법 관계절. 추가 설명.'
from te_paragraphs p where p.passage_id = 'c000000c-0000-0000-0000-00000000000c' and p.ord = 0;

-- para 1
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'Cash transfers to the same households often produce better outcomes.',
  '[{"key":"1","text":"Cash transfers"},{"key":"2","text":"the same households"},{"key":"3","text":"better outcomes"},{"key":"4","text":"often"}]', '1',
  '동사 produce의 주어는 "Cash transfers" (복수).'
from te_paragraphs p where p.passage_id = 'c000000c-0000-0000-0000-00000000000c' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"Recipients ____ on locally made goods." 빈칸에 알맞은 것은?', 'Recipients ___ on locally made goods, which strengthens neighboring producers instead of replacing them.',
  '[{"key":"1","text":"spends"},{"key":"2","text":"spend"},{"key":"3","text":"is spending"},{"key":"4","text":"has spent"}]', '2',
  '주어 Recipients 복수 → spend.'
from te_paragraphs p where p.passage_id = 'c000000c-0000-0000-0000-00000000000c' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"which strengthens neighboring producers instead of replacing them"의 역할은?', 'Recipients spend on locally made goods, which strengthens neighboring producers instead of replacing them.',
  '[{"key":"1","text":"앞 절 전체를 받는 계속적 용법 관계절"},{"key":"2","text":"부사절"},{"key":"3","text":"명사절"},{"key":"4","text":"보어"}]', '1',
  '계속적 용법 which가 앞 절(소비 행위) 전체를 받음.'
from te_paragraphs p where p.passage_id = 'c000000c-0000-0000-0000-00000000000c' and p.ord = 1;

-- para 2
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'The lesson is that good intentions cannot stand alone.',
  '[{"key":"1","text":"The lesson"},{"key":"2","text":"good intentions"},{"key":"3","text":"alone"},{"key":"4","text":"that"}]', '1',
  '동사 is의 주어는 "The lesson". 뒤 that절은 보어.'
from te_paragraphs p where p.passage_id = 'c000000c-0000-0000-0000-00000000000c' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"Aid that ignores the local economy ____ erase what it was meant to support." 빈칸에 알맞은 것은?', 'Aid that ignores the local economy ___ erase what it was meant to support.',
  '[{"key":"1","text":"can"},{"key":"2","text":"are"},{"key":"3","text":"have"},{"key":"4","text":"is"}]', '1',
  '뒤에 동사원형 erase가 오므로 조동사 can.'
from te_paragraphs p where p.passage_id = 'c000000c-0000-0000-0000-00000000000c' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"what it was meant to support"의 역할은?', 'can erase what it was meant to support.',
  '[{"key":"1","text":"erase의 목적어 명사절 (관계대명사 what)"},{"key":"2","text":"부사절"},{"key":"3","text":"형용사절"},{"key":"4","text":"보어"}]', '1',
  '관계대명사 what이 이끄는 명사절이 erase의 목적어.'
from te_paragraphs p where p.passage_id = 'c000000c-0000-0000-0000-00000000000c' and p.ord = 2;

-- ============ c000000d The Long Sentence That Says Nothing ============
-- para 0
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'A sentence packed with abstract nouns and rare adjectives can feel important even when, examined closely, it says almost nothing.',
  '[{"key":"1","text":"A sentence"},{"key":"2","text":"abstract nouns"},{"key":"3","text":"it"},{"key":"4","text":"closely"}]', '1',
  '주절 동사 can feel의 주어는 "A sentence".'
from te_paragraphs p where p.passage_id = 'c000000d-0000-0000-0000-00000000000d' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"Some writers ____ thin ideas behind dense language." 빈칸에 알맞은 것은?', 'Some writers ___ thin ideas behind dense language.',
  '[{"key":"1","text":"hides"},{"key":"2","text":"hide"},{"key":"3","text":"is hiding"},{"key":"4","text":"has hidden"}]', '2',
  '주어 writers 복수 → hide.'
from te_paragraphs p where p.passage_id = 'c000000d-0000-0000-0000-00000000000d' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"packed with abstract nouns and rare adjectives"의 역할은?', 'A sentence packed with abstract nouns and rare adjectives can feel important.',
  '[{"key":"1","text":"A sentence를 수식하는 과거분사구"},{"key":"2","text":"부사절"},{"key":"3","text":"동사"},{"key":"4","text":"독립절"}]', '1',
  '과거분사구가 A sentence를 뒤에서 수식.'
from te_paragraphs p where p.passage_id = 'c000000d-0000-0000-0000-00000000000d' and p.ord = 0;

-- para 1
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'Reading slowly reveals the trick.',
  '[{"key":"1","text":"Reading slowly"},{"key":"2","text":"the trick"},{"key":"3","text":"slowly"},{"key":"4","text":"Reading"}]', '1',
  '동명사구 "Reading slowly" 전체가 주어.'
from te_paragraphs p where p.passage_id = 'c000000d-0000-0000-0000-00000000000d' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"The resistance often ____ to absence rather than depth." 빈칸에 알맞은 것은?', 'When a passage resists every attempt at simple paraphrase, the resistance often ___ to absence rather than depth.',
  '[{"key":"1","text":"point"},{"key":"2","text":"points"},{"key":"3","text":"are pointing"},{"key":"4","text":"have pointed"}]', '2',
  '주어 "the resistance" 단수 → points.'
from te_paragraphs p where p.passage_id = 'c000000d-0000-0000-0000-00000000000d' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"When a passage resists every attempt at simple paraphrase"의 역할은?', 'When a passage resists every attempt at simple paraphrase, the resistance often points to absence rather than depth.',
  '[{"key":"1","text":"시간/조건 부사절"},{"key":"2","text":"명사절"},{"key":"3","text":"형용사절"},{"key":"4","text":"보어"}]', '1',
  'When절이 시간/조건의 부사절.'
from te_paragraphs p where p.passage_id = 'c000000d-0000-0000-0000-00000000000d' and p.ord = 1;

-- para 2
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'A short sentence that survives translation into a child''s words has earned the right to look simple.',
  '[{"key":"1","text":"A short sentence"},{"key":"2","text":"translation"},{"key":"3","text":"a child''s words"},{"key":"4","text":"the right"}]', '1',
  '주절 동사 has earned의 주어는 "A short sentence". that절은 형용사절.'
from te_paragraphs p where p.passage_id = 'c000000d-0000-0000-0000-00000000000d' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"Clear writing ____ harder than complex writing." 빈칸에 알맞은 것은?', 'Clear writing ___ harder than complex writing.',
  '[{"key":"1","text":"are"},{"key":"2","text":"is"},{"key":"3","text":"have"},{"key":"4","text":"were"}]', '2',
  '주어 "Clear writing" 동명사 단수 → is.'
from te_paragraphs p where p.passage_id = 'c000000d-0000-0000-0000-00000000000d' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"to look simple"의 역할은?', '... has earned the right to look simple.',
  '[{"key":"1","text":"the right를 수식하는 to부정사 (형용사 역할)"},{"key":"2","text":"동사"},{"key":"3","text":"부사절"},{"key":"4","text":"독립절"}]', '1',
  '"the right to + 동사원형": to부정사가 명사 right 수식.'
from te_paragraphs p where p.passage_id = 'c000000d-0000-0000-0000-00000000000d' and p.ord = 2;

-- ============ c000000e Why Innovation Often Comes From Outsiders ============
-- para 0
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'Newcomers ask questions that insiders have stopped asking, because insiders have already learned which questions sound foolish.',
  '[{"key":"1","text":"Newcomers"},{"key":"2","text":"questions"},{"key":"3","text":"insiders"},{"key":"4","text":"which questions"}]', '1',
  '주절 동사 ask의 주어는 "Newcomers".'
from te_paragraphs p where p.passage_id = 'c000000e-0000-0000-0000-00000000000e' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"The foolish question ____ sometimes the one that breaks the field open." 빈칸에 알맞은 것은?', 'The foolish question ___ sometimes the one that breaks the field open.',
  '[{"key":"1","text":"are"},{"key":"2","text":"is"},{"key":"3","text":"have"},{"key":"4","text":"were"}]', '2',
  '주어 "The foolish question" 단수 → is.'
from te_paragraphs p where p.passage_id = 'c000000e-0000-0000-0000-00000000000e' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"which questions sound foolish"의 역할은?', '... have already learned which questions sound foolish.',
  '[{"key":"1","text":"learned의 목적어 명사절 (간접의문문)"},{"key":"2","text":"부사절"},{"key":"3","text":"형용사절"},{"key":"4","text":"보어"}]', '1',
  '의문형용사 which가 이끄는 명사절이 learned의 목적어.'
from te_paragraphs p where p.passage_id = 'c000000e-0000-0000-0000-00000000000e' and p.ord = 0;

-- para 1
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'Many famous inventions appeared at the edges where two fields touched, brought there by people who belonged fully to neither.',
  '[{"key":"1","text":"Many famous inventions"},{"key":"2","text":"the edges"},{"key":"3","text":"two fields"},{"key":"4","text":"people"}]', '1',
  '주절 동사 appeared의 주어는 "Many famous inventions".'
from te_paragraphs p where p.passage_id = 'c000000e-0000-0000-0000-00000000000e' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"They ____ carry a tool from one world into another." 빈칸에 알맞은 것은?', 'They ___ carry a tool from one world into another without seeing the imagined wall between them.',
  '[{"key":"1","text":"could"},{"key":"2","text":"is"},{"key":"3","text":"are"},{"key":"4","text":"has"}]', '1',
  '뒤에 동사원형 carry가 오므로 조동사 could.'
from te_paragraphs p where p.passage_id = 'c000000e-0000-0000-0000-00000000000e' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"brought there by people who belonged fully to neither"의 역할은?', '... appeared at the edges where two fields touched, brought there by people who belonged fully to neither.',
  '[{"key":"1","text":"분사구문 (과거분사, 수동)"},{"key":"2","text":"독립절"},{"key":"3","text":"명사절"},{"key":"4","text":"보어"}]', '1',
  '과거분사 brought로 시작하는 분사구문 (= which were brought ~).'
from te_paragraphs p where p.passage_id = 'c000000e-0000-0000-0000-00000000000e' and p.ord = 1;

-- para 2
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'This does not mean every outsider becomes an innovator.',
  '[{"key":"1","text":"This"},{"key":"2","text":"every outsider"},{"key":"3","text":"an innovator"},{"key":"4","text":"not"}]', '1',
  '동사 does not mean의 주어는 "This".'
from te_paragraphs p where p.passage_id = 'c000000e-0000-0000-0000-00000000000e' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"An outsider ____ a chance the insider has slowly traded away." 빈칸에 알맞은 것은?', 'It means an outsider ___ a chance the insider has slowly traded away.',
  '[{"key":"1","text":"have"},{"key":"2","text":"has"},{"key":"3","text":"is having"},{"key":"4","text":"having"}]', '2',
  '주어 "an outsider" 단수 → has.'
from te_paragraphs p where p.passage_id = 'c000000e-0000-0000-0000-00000000000e' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"the insider has slowly traded away"의 역할은?', 'a chance the insider has slowly traded away',
  '[{"key":"1","text":"a chance를 수식하는 관계절 (관계대명사 생략)"},{"key":"2","text":"부사절"},{"key":"3","text":"보어"},{"key":"4","text":"독립절"}]', '1',
  '목적격 관계대명사 that/which 생략된 형용사절이 a chance 수식.'
from te_paragraphs p where p.passage_id = 'c000000e-0000-0000-0000-00000000000e' and p.ord = 2;

-- ============ c000000f The Discipline of Slowness ============
-- para 0
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'A culture that prizes speed treats slowness as weakness.',
  '[{"key":"1","text":"A culture"},{"key":"2","text":"speed"},{"key":"3","text":"slowness"},{"key":"4","text":"weakness"}]', '1',
  '주절 동사 treats의 주어는 "A culture". that절은 형용사절.'
from te_paragraphs p where p.passage_id = 'c000000f-0000-0000-0000-00000000000f' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"Long pauses ____ suspected of indecision." 빈칸에 알맞은 것은?', 'Long pauses ___ suspected of indecision.',
  '[{"key":"1","text":"is"},{"key":"2","text":"are"},{"key":"3","text":"has"},{"key":"4","text":"was"}]', '2',
  '주어 "Long pauses" 복수, 수동태 → are suspected.'
from te_paragraphs p where p.passage_id = 'c000000f-0000-0000-0000-00000000000f' and p.ord = 0;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"that prizes speed"의 역할은?', 'A culture that prizes speed treats slowness as weakness.',
  '[{"key":"1","text":"A culture를 수식하는 형용사절"},{"key":"2","text":"부사절"},{"key":"3","text":"명사절"},{"key":"4","text":"보어"}]', '1',
  '관계대명사 that 절이 A culture를 수식.'
from te_paragraphs p where p.passage_id = 'c000000f-0000-0000-0000-00000000000f' and p.ord = 0;

-- para 1
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'A choice made in three seconds and a choice made in three days do not always reach the same place.',
  '[{"key":"1","text":"A choice made in three seconds and a choice made in three days"},{"key":"2","text":"three seconds"},{"key":"3","text":"three days"},{"key":"4","text":"the same place"}]', '1',
  '두 명사구가 and로 묶인 복합 주어.'
from te_paragraphs p where p.passage_id = 'c000000f-0000-0000-0000-00000000000f' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"Some problems ____ their shape only after we stop pushing on them." 빈칸에 알맞은 것은?', 'Some problems ___ their shape only after we stop pushing on them.',
  '[{"key":"1","text":"reveals"},{"key":"2","text":"reveal"},{"key":"3","text":"is revealing"},{"key":"4","text":"has revealed"}]', '2',
  '주어 problems 복수 → reveal.'
from te_paragraphs p where p.passage_id = 'c000000f-0000-0000-0000-00000000000f' and p.ord = 1;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"made in three seconds"의 역할은?', 'A choice made in three seconds',
  '[{"key":"1","text":"A choice를 수식하는 과거분사구"},{"key":"2","text":"동사"},{"key":"3","text":"부사절"},{"key":"4","text":"독립절"}]', '1',
  '과거분사구가 A choice를 뒤에서 수식 (수동 의미).'
from te_paragraphs p where p.passage_id = 'c000000f-0000-0000-0000-00000000000f' and p.ord = 1;

-- para 2
insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 0, 'subject', '다음 문장의 주어는?', 'It is a disciplined refusal to confuse the appearance of progress with the substance of it.',
  '[{"key":"1","text":"It"},{"key":"2","text":"a disciplined refusal"},{"key":"3","text":"the appearance"},{"key":"4","text":"the substance"}]', '1',
  'is의 주어는 "It".'
from te_paragraphs p where p.passage_id = 'c000000f-0000-0000-0000-00000000000f' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 1, 'verb', '"Choosing slowness ____ not laziness." 빈칸에 알맞은 것은?', 'Choosing slowness ___ not laziness.',
  '[{"key":"1","text":"are"},{"key":"2","text":"is"},{"key":"3","text":"have"},{"key":"4","text":"were"}]', '2',
  '동명사 주어 "Choosing slowness" 단수 → is.'
from te_paragraphs p where p.passage_id = 'c000000f-0000-0000-0000-00000000000f' and p.ord = 2;

insert into te_structure_questions (paragraph_id, ord, kind, prompt, target_sentence, choices, correct_answer, explanation)
select p.id, 2, 'structure', '"to confuse the appearance of progress with the substance of it"의 역할은?', 'a disciplined refusal to confuse the appearance of progress with the substance of it.',
  '[{"key":"1","text":"refusal을 수식하는 to부정사구 (형용사 역할)"},{"key":"2","text":"부사절"},{"key":"3","text":"명사절"},{"key":"4","text":"보어"}]', '1',
  '"refusal to + 동사원형": to부정사가 명사 refusal을 수식.'
from te_paragraphs p where p.passage_id = 'c000000f-0000-0000-0000-00000000000f' and p.ord = 2;
