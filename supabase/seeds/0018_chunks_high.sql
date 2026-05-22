-- =====================================================================
-- 직독직해 청크 시드 — 상(high) 난이도 15지문, 단락당 1문장 (45문장)
-- =====================================================================

-- c0000001 Why Expertise Can Become a Cage
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'The same training, however, builds blind spots in the places where the expert no longer looks because the answer feels obvious.',
  '[
    {"en":"The same training, however,","ko":"같은 훈련은, 그러나,"},
    {"en":"builds blind spots","ko":"맹점을 만든다"},
    {"en":"in the places","ko":"장소에서"},
    {"en":"where the expert","ko":"전문가가"},
    {"en":"no longer looks","ko":"더 이상 보지 않는"},
    {"en":"because the answer","ko":"왜냐하면 답이"},
    {"en":"feels obvious.","ko":"뻔하게 느껴지기 때문에."}
  ]'::jsonb,
  '관계부사 where + because 부사절'
from te_paragraphs p where p.passage_id = 'c0000001-0000-0000-0000-000000000001' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'They lack the assumptions that quietly closed certain doors inside the field.',
  '[
    {"en":"They lack","ko":"그들은 결핍하고 있다"},
    {"en":"the assumptions","ko":"가정들이"},
    {"en":"that quietly closed","ko":"조용히 닫은"},
    {"en":"certain doors","ko":"특정 문들을"},
    {"en":"inside the field.","ko":"그 분야 안에서."}
  ]'::jsonb,
  '관계대명사 that (assumptions 수식)'
from te_paragraphs p where p.passage_id = 'c0000001-0000-0000-0000-000000000001' and p.ord = 1;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'A specialist who keeps one foot outside her own field sees both the inside and the door at the same time.',
  '[
    {"en":"A specialist","ko":"전문가는"},
    {"en":"who keeps one foot","ko":"한 발을 두고 있는"},
    {"en":"outside her own field","ko":"자기 분야 밖에"},
    {"en":"sees both","ko":"둘 다 본다"},
    {"en":"the inside and the door","ko":"안쪽과 문을"},
    {"en":"at the same time.","ko":"동시에."}
  ]'::jsonb,
  '관계대명사 who + both A and B'
from te_paragraphs p where p.passage_id = 'c0000001-0000-0000-0000-000000000001' and p.ord = 2;

-- c0000002 The Quiet Tyranny of the Default
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'The same population, the same beliefs, but a different default produces a different result.',
  '[
    {"en":"The same population,","ko":"같은 인구,"},
    {"en":"the same beliefs,","ko":"같은 신념,"},
    {"en":"but a different default","ko":"그러나 다른 기본값이"},
    {"en":"produces","ko":"낳는다"},
    {"en":"a different result.","ko":"다른 결과를."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'c0000002-0000-0000-0000-000000000002' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'The choice that requires no action wins, regardless of what people would have decided in the abstract.',
  '[
    {"en":"The choice","ko":"선택이"},
    {"en":"that requires no action","ko":"행동이 필요 없는"},
    {"en":"wins,","ko":"이긴다,"},
    {"en":"regardless of","ko":"~와 상관없이"},
    {"en":"what people would have decided","ko":"사람들이 결정했을지"},
    {"en":"in the abstract.","ko":"추상적으로."}
  ]'::jsonb,
  '관계대명사 that + regardless of + what 명사절'
from te_paragraphs p where p.passage_id = 'c0000002-0000-0000-0000-000000000002' and p.ord = 1;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'This is why the design of forms, menus, and settings is never neutral, even when it looks technical.',
  '[
    {"en":"This is why","ko":"이것이 이유이다"},
    {"en":"the design","ko":"설계가"},
    {"en":"of forms, menus, and settings","ko":"양식, 메뉴, 설정의"},
    {"en":"is never neutral,","ko":"결코 중립적이지 않은,"},
    {"en":"even when","ko":"심지어 ~할 때조차"},
    {"en":"it looks technical.","ko":"기술적으로 보일 때."}
  ]'::jsonb,
  'This is why ~ + even when 양보'
from te_paragraphs p where p.passage_id = 'c0000002-0000-0000-0000-000000000002' and p.ord = 2;

-- c0000003 When Numbers Lie by Telling the Truth
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'The number is true, but the period chosen runs from an unusual spike to an ordinary year.',
  '[
    {"en":"The number is true,","ko":"숫자는 사실이다,"},
    {"en":"but the period","ko":"하지만 그 기간은"},
    {"en":"chosen","ko":"선택된"},
    {"en":"runs from","ko":"~부터 ~까지 이어진다"},
    {"en":"an unusual spike","ko":"비정상적 급등에서"},
    {"en":"to an ordinary year.","ko":"평범한 해까지."}
  ]'::jsonb,
  '과거분사구 후치수식 (the period chosen)'
from te_paragraphs p where p.passage_id = 'c0000003-0000-0000-0000-000000000003' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'The average income in a room can rise sharply if one billionaire walks in, even though everyone else earned nothing new.',
  '[
    {"en":"The average income","ko":"평균 소득은"},
    {"en":"in a room","ko":"한 방 안의"},
    {"en":"can rise sharply","ko":"급격히 오를 수 있다"},
    {"en":"if one billionaire walks in,","ko":"만약 억만장자 한 명이 들어오면,"},
    {"en":"even though","ko":"비록 ~하더라도"},
    {"en":"everyone else","ko":"다른 모든 사람이"},
    {"en":"earned nothing new.","ko":"새로 번 것이 없다."}
  ]'::jsonb,
  'even though 양보 부사절'
from te_paragraphs p where p.passage_id = 'c0000003-0000-0000-0000-000000000003' and p.ord = 1;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'A careful reader asks not what the number is but how it was made.',
  '[
    {"en":"A careful reader","ko":"신중한 독자는"},
    {"en":"asks","ko":"묻는다"},
    {"en":"not what the number is","ko":"그 숫자가 무엇인지가 아니라"},
    {"en":"but how it was made.","ko":"어떻게 만들어졌는지를."}
  ]'::jsonb,
  'not A but B (간접의문문 두 개)'
from te_paragraphs p where p.passage_id = 'c0000003-0000-0000-0000-000000000003' and p.ord = 2;

-- c0000004 The Cost of Constant Connection
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Studies show that simply having a smartphone on the table during a conversation reduces how connected the participants feel.',
  '[
    {"en":"Studies show","ko":"연구들은 보여준다"},
    {"en":"that simply having","ko":"단순히 두는 것만으로도"},
    {"en":"a smartphone on the table","ko":"스마트폰을 테이블 위에"},
    {"en":"during a conversation","ko":"대화 중에"},
    {"en":"reduces","ko":"줄인다는 것을"},
    {"en":"how connected","ko":"얼마나 연결되어 있다고"},
    {"en":"the participants feel.","ko":"참가자들이 느끼는지를."}
  ]'::jsonb,
  '동명사구 주어 (having ~) + 간접의문문'
from te_paragraphs p where p.passage_id = 'c0000004-0000-0000-0000-000000000004' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'A part of attention stays ready for the device, which leaves less attention for the people in the room.',
  '[
    {"en":"A part of attention","ko":"주의의 일부가"},
    {"en":"stays ready","ko":"준비 상태로 머문다"},
    {"en":"for the device,","ko":"그 기기를 위해,"},
    {"en":"which leaves","ko":"그것이 남긴다"},
    {"en":"less attention","ko":"더 적은 주의를"},
    {"en":"for the people","ko":"사람들에게"},
    {"en":"in the room.","ko":"방 안에 있는."}
  ]'::jsonb,
  '계속적 용법 which (앞 절 전체 받음)'
from te_paragraphs p where p.passage_id = 'c0000004-0000-0000-0000-000000000004' and p.ord = 1;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Putting the device out of sight for a defined period changes the depth of the conversation that follows.',
  '[
    {"en":"Putting the device","ko":"기기를 두는 것은"},
    {"en":"out of sight","ko":"시야 밖에"},
    {"en":"for a defined period","ko":"정해진 시간 동안"},
    {"en":"changes","ko":"바꾼다"},
    {"en":"the depth","ko":"깊이를"},
    {"en":"of the conversation","ko":"대화의"},
    {"en":"that follows.","ko":"이어지는."}
  ]'::jsonb,
  '동명사구 주어, that 관계절'
from te_paragraphs p where p.passage_id = 'c0000004-0000-0000-0000-000000000004' and p.ord = 2;

-- c0000005 How Maps Quietly Argue
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'The choice of projection quietly decides which countries look large or small.',
  '[
    {"en":"The choice","ko":"선택은"},
    {"en":"of projection","ko":"투영법의"},
    {"en":"quietly decides","ko":"조용히 결정한다"},
    {"en":"which countries","ko":"어떤 나라가"},
    {"en":"look large or small.","ko":"크거나 작아 보이는지를."}
  ]'::jsonb,
  '간접의문문 (decides의 목적어)'
from te_paragraphs p where p.passage_id = 'c0000005-0000-0000-0000-000000000005' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'A river that shifts each year becomes a single fixed line in the atlas.',
  '[
    {"en":"A river","ko":"강이"},
    {"en":"that shifts","ko":"이동하는"},
    {"en":"each year","ko":"매년"},
    {"en":"becomes","ko":"~이 된다"},
    {"en":"a single fixed line","ko":"하나의 고정된 선이"},
    {"en":"in the atlas.","ko":"지도책에서."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'c0000005-0000-0000-0000-000000000005' and p.ord = 1;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'The image is not the world; it is one argument about the world.',
  '[
    {"en":"The image","ko":"이미지는"},
    {"en":"is not the world;","ko":"세상이 아니다;"},
    {"en":"it is","ko":"그것은"},
    {"en":"one argument","ko":"하나의 주장이다"},
    {"en":"about the world.","ko":"세상에 대한."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'c0000005-0000-0000-0000-000000000005' and p.ord = 2;

-- c0000006 The Limits of Imitation
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'The hand learns through the muscles what the eyes have only seen so far.',
  '[
    {"en":"The hand learns","ko":"손은 배운다"},
    {"en":"through the muscles","ko":"근육을 통해"},
    {"en":"what the eyes","ko":"눈이"},
    {"en":"have only seen","ko":"보기만 했던 것을"},
    {"en":"so far.","ko":"지금까지."}
  ]'::jsonb,
  '관계대명사 what 명사절 (learns의 목적어)'
from te_paragraphs p where p.passage_id = 'c0000006-0000-0000-0000-000000000006' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'The student who never risks her own line repeats the master''s strengths but also his limits.',
  '[
    {"en":"The student","ko":"학생은"},
    {"en":"who never risks","ko":"결코 시도하지 않는"},
    {"en":"her own line","ko":"자신만의 선을"},
    {"en":"repeats","ko":"되풀이한다"},
    {"en":"the master''s strengths","ko":"스승의 강점을"},
    {"en":"but also his limits.","ko":"그러나 또한 그의 한계까지도."}
  ]'::jsonb,
  '관계대명사 who'
from te_paragraphs p where p.passage_id = 'c0000006-0000-0000-0000-000000000006' and p.ord = 1;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Real growth begins when the imitator misses on purpose, leaving in the mistakes that turn out to be a voice.',
  '[
    {"en":"Real growth begins","ko":"진정한 성장은 시작된다"},
    {"en":"when the imitator","ko":"모방자가"},
    {"en":"misses on purpose,","ko":"의도적으로 빗나갈 때,"},
    {"en":"leaving in the mistakes","ko":"그 실수들을 남기면서"},
    {"en":"that turn out to be","ko":"결국 ~이 되는"},
    {"en":"a voice.","ko":"하나의 목소리가."}
  ]'::jsonb,
  '분사구문 leaving + 관계대명사 that'
from te_paragraphs p where p.passage_id = 'c0000006-0000-0000-0000-000000000006' and p.ord = 2;

-- c0000007 Why Forgetting Helps Thinking
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Without it, every old phone number, address, and trivial conversation would crowd the mind permanently.',
  '[
    {"en":"Without it,","ko":"그것이 없다면,"},
    {"en":"every old phone number,","ko":"모든 옛 전화번호,"},
    {"en":"address,","ko":"주소,"},
    {"en":"and trivial conversation","ko":"그리고 사소한 대화가"},
    {"en":"would crowd","ko":"가득 채울 것이다"},
    {"en":"the mind permanently.","ko":"마음을 영구히."}
  ]'::jsonb,
  'Without ~ + would (가정법)'
from te_paragraphs p where p.passage_id = 'c0000007-0000-0000-0000-000000000007' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Memory weighed down by everything has no room to compare or generalize.',
  '[
    {"en":"Memory","ko":"기억은"},
    {"en":"weighed down","ko":"눌린"},
    {"en":"by everything","ko":"모든 것에 의해"},
    {"en":"has no room","ko":"여유가 없다"},
    {"en":"to compare or generalize.","ko":"비교하거나 일반화할."}
  ]'::jsonb,
  '과거분사구 후치수식 (Memory weighed down ~)'
from te_paragraphs p where p.passage_id = 'c0000007-0000-0000-0000-000000000007' and p.ord = 1;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'The form emerges from what has been removed, not only from what remains.',
  '[
    {"en":"The form emerges","ko":"형태가 나타난다"},
    {"en":"from what has been removed,","ko":"제거된 것으로부터,"},
    {"en":"not only from","ko":"~로부터만이 아니라"},
    {"en":"what remains.","ko":"남아 있는 것으로부터."}
  ]'::jsonb,
  'what 명사절 두 번 (수동 + 능동)'
from te_paragraphs p where p.passage_id = 'c0000007-0000-0000-0000-000000000007' and p.ord = 2;

-- c0000008 The Hidden Politics of Search
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'They predict which pages are most useful to each individual, based on past behavior, location, and many signals invisible to the user.',
  '[
    {"en":"They predict","ko":"그것들은 예측한다"},
    {"en":"which pages are most useful","ko":"어떤 페이지가 가장 유용한지"},
    {"en":"to each individual,","ko":"각 개인에게,"},
    {"en":"based on","ko":"~를 기반으로"},
    {"en":"past behavior, location,","ko":"과거 행동, 위치,"},
    {"en":"and many signals","ko":"그리고 많은 신호들"},
    {"en":"invisible to the user.","ko":"사용자에게 보이지 않는."}
  ]'::jsonb,
  '간접의문문 + 과거분사구 후치수식'
from te_paragraphs p where p.passage_id = 'c0000008-0000-0000-0000-000000000008' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Public debate becomes harder when each citizen reads from a slightly different page.',
  '[
    {"en":"Public debate","ko":"공적 토론은"},
    {"en":"becomes harder","ko":"더 어려워진다"},
    {"en":"when each citizen","ko":"각 시민이"},
    {"en":"reads","ko":"읽을 때"},
    {"en":"from a slightly different page.","ko":"약간 다른 페이지에서."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'c0000008-0000-0000-0000-000000000008' and p.ord = 1;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Knowing this does not change the results, but it changes the trust the reader places in them.',
  '[
    {"en":"Knowing this","ko":"이것을 안다고 해서"},
    {"en":"does not change","ko":"바꾸지는 않는다"},
    {"en":"the results,","ko":"결과를,"},
    {"en":"but it changes","ko":"하지만 그것은 바꾼다"},
    {"en":"the trust","ko":"신뢰를"},
    {"en":"the reader places","ko":"독자가 두는"},
    {"en":"in them.","ko":"그 결과에."}
  ]'::jsonb,
  '동명사 주어, 목적격 관계대명사 생략'
from te_paragraphs p where p.passage_id = 'c0000008-0000-0000-0000-000000000008' and p.ord = 2;

-- c0000009 The Long Tail of an Apology
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'The person harmed keeps repeating the event in private, trying to make sense of what happened.',
  '[
    {"en":"The person","ko":"그 사람은"},
    {"en":"harmed","ko":"상처를 입은"},
    {"en":"keeps repeating","ko":"계속 되풀이한다"},
    {"en":"the event in private,","ko":"그 사건을 혼자서,"},
    {"en":"trying to make sense","ko":"이해해보려 애쓰며"},
    {"en":"of what happened.","ko":"무슨 일이 있었는지를."}
  ]'::jsonb,
  '과거분사구 후치수식 + 분사구문'
from te_paragraphs p where p.passage_id = 'c0000009-0000-0000-0000-000000000009' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'The story can now include the words that closed it, not only the moment that opened it.',
  '[
    {"en":"The story","ko":"그 이야기는"},
    {"en":"can now include","ko":"이제 포함할 수 있다"},
    {"en":"the words","ko":"말들을"},
    {"en":"that closed it,","ko":"그것을 닫은,"},
    {"en":"not only the moment","ko":"그 순간만이 아니라"},
    {"en":"that opened it.","ko":"그것을 연."}
  ]'::jsonb,
  '관계대명사 that 두 번 (대조)'
from te_paragraphs p where p.passage_id = 'c0000009-0000-0000-0000-000000000009' and p.ord = 1;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'A late apology repairs less because by then the story has hardened into its private form.',
  '[
    {"en":"A late apology","ko":"늦은 사과는"},
    {"en":"repairs less","ko":"덜 회복시킨다"},
    {"en":"because by then","ko":"왜냐하면 그때쯤이면"},
    {"en":"the story","ko":"이야기가"},
    {"en":"has hardened","ko":"굳어버렸기 때문에"},
    {"en":"into its private form.","ko":"그 사람만의 형태로."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'c0000009-0000-0000-0000-000000000009' and p.ord = 2;

-- c000000a Why Cities Outlive Empires
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Babylon, Constantinople, and many ancient capitals outlasted the powers that founded them.',
  '[
    {"en":"Babylon, Constantinople,","ko":"바빌론, 콘스탄티노플,"},
    {"en":"and many ancient capitals","ko":"그리고 많은 고대 수도들이"},
    {"en":"outlasted","ko":"오래 살아남았다"},
    {"en":"the powers","ko":"권력들보다"},
    {"en":"that founded them.","ko":"그들을 세운."}
  ]'::jsonb,
  '관계대명사 that (powers 수식)'
from te_paragraphs p where p.passage_id = 'c000000a-0000-0000-0000-00000000000a' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'New generations route their lives along old stones without noticing whose feet first wore them down.',
  '[
    {"en":"New generations","ko":"새 세대는"},
    {"en":"route their lives","ko":"자신의 삶을 따라간다"},
    {"en":"along old stones","ko":"오래된 돌들을 따라"},
    {"en":"without noticing","ko":"눈치채지 못한 채"},
    {"en":"whose feet","ko":"누구의 발이"},
    {"en":"first wore them down.","ko":"처음으로 그것을 닳게 했는지."}
  ]'::jsonb,
  '의문사 whose 간접의문문'
from te_paragraphs p where p.passage_id = 'c000000a-0000-0000-0000-00000000000a' and p.ord = 1;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'It carries decisions that nobody alive made, and it shapes decisions that nobody dead can predict.',
  '[
    {"en":"It carries","ko":"그것은 품고 있다"},
    {"en":"decisions","ko":"결정들을"},
    {"en":"that nobody alive made,","ko":"살아있는 누구도 내리지 않은,"},
    {"en":"and it shapes","ko":"그리고 형성한다"},
    {"en":"decisions","ko":"결정들을"},
    {"en":"that nobody dead can predict.","ko":"죽은 누구도 예측할 수 없는."}
  ]'::jsonb,
  '관계대명사 that 두 번 (병렬)'
from te_paragraphs p where p.passage_id = 'c000000a-0000-0000-0000-00000000000a' and p.ord = 2;

-- c000000b The Paradox of Choice in Markets
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'In practice, when the number of options grows large, decisions become slower, regrets stronger, and satisfaction lower.',
  '[
    {"en":"In practice,","ko":"실제로는,"},
    {"en":"when the number of options","ko":"선택지의 수가"},
    {"en":"grows large,","ko":"커지면,"},
    {"en":"decisions become slower,","ko":"결정은 더 느려지고,"},
    {"en":"regrets stronger,","ko":"후회는 더 강해지고,"},
    {"en":"and satisfaction lower.","ko":"만족도는 더 낮아진다."}
  ]'::jsonb,
  '병렬 (become 생략)'
from te_paragraphs p where p.passage_id = 'c000000b-0000-0000-0000-00000000000b' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'The chosen option must now defend itself against forty unseen rivals.',
  '[
    {"en":"The chosen option","ko":"선택된 옵션은"},
    {"en":"must now defend itself","ko":"이제 자신을 방어해야 한다"},
    {"en":"against","ko":"~에 대항하여"},
    {"en":"forty unseen rivals.","ko":"40개의 보이지 않는 경쟁자에."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'c000000b-0000-0000-0000-00000000000b' and p.ord = 1;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'A shorter list, chosen with care, often produces buyers who feel both freer and happier than a longer list ever could.',
  '[
    {"en":"A shorter list,","ko":"더 짧은 목록은,"},
    {"en":"chosen with care,","ko":"신중하게 선택된,"},
    {"en":"often produces","ko":"종종 만들어낸다"},
    {"en":"buyers","ko":"구매자들을"},
    {"en":"who feel both freer and happier","ko":"더 자유롭고 더 행복하게 느끼는"},
    {"en":"than a longer list ever could.","ko":"긴 목록이 만들 수 있는 것보다."}
  ]'::jsonb,
  '삽입된 분사구 + 관계대명사 who'
from te_paragraphs p where p.passage_id = 'c000000b-0000-0000-0000-00000000000b' and p.ord = 2;

-- c000000c When Help Hurts
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Yet local shoemakers, who survive on small margins, suddenly lose their customers.',
  '[
    {"en":"Yet local shoemakers,","ko":"그러나 현지 신발 제조업자들은,"},
    {"en":"who survive","ko":"생존하고 있는"},
    {"en":"on small margins,","ko":"적은 이윤으로,"},
    {"en":"suddenly lose","ko":"갑자기 잃는다"},
    {"en":"their customers.","ko":"고객을."}
  ]'::jsonb,
  '계속적 용법 관계절'
from te_paragraphs p where p.passage_id = 'c000000c-0000-0000-0000-00000000000c' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Recipients spend on locally made goods, which strengthens neighboring producers instead of replacing them.',
  '[
    {"en":"Recipients spend","ko":"수혜자들은 쓴다"},
    {"en":"on locally made goods,","ko":"현지에서 만든 물건에,"},
    {"en":"which strengthens","ko":"그것이 강화한다"},
    {"en":"neighboring producers","ko":"인근 생산자들을"},
    {"en":"instead of replacing them.","ko":"그들을 대체하는 대신."}
  ]'::jsonb,
  '계속적 용법 which'
from te_paragraphs p where p.passage_id = 'c000000c-0000-0000-0000-00000000000c' and p.ord = 1;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Aid that ignores the local economy can erase what it was meant to support.',
  '[
    {"en":"Aid","ko":"원조는"},
    {"en":"that ignores","ko":"무시하는"},
    {"en":"the local economy","ko":"지역 경제를"},
    {"en":"can erase","ko":"지울 수 있다"},
    {"en":"what it was meant to support.","ko":"그것이 지원하려던 것을."}
  ]'::jsonb,
  '관계대명사 that + what 명사절'
from te_paragraphs p where p.passage_id = 'c000000c-0000-0000-0000-00000000000c' and p.ord = 2;

-- c000000d The Long Sentence That Says Nothing
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'A sentence packed with abstract nouns and rare adjectives can feel important even when, examined closely, it says almost nothing.',
  '[
    {"en":"A sentence","ko":"한 문장은"},
    {"en":"packed with","ko":"가득 채워진"},
    {"en":"abstract nouns and rare adjectives","ko":"추상명사와 드문 형용사들로"},
    {"en":"can feel important","ko":"중요해 보일 수 있다"},
    {"en":"even when, examined closely,","ko":"심지어, 자세히 살펴봤을 때조차,"},
    {"en":"it says almost nothing.","ko":"거의 아무 말도 하지 않는데."}
  ]'::jsonb,
  '과거분사구 후치수식 + 삽입 분사구문'
from te_paragraphs p where p.passage_id = 'c000000d-0000-0000-0000-00000000000d' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'When a passage resists every attempt at simple paraphrase, the resistance often points to absence rather than depth.',
  '[
    {"en":"When a passage resists","ko":"한 글이 저항할 때"},
    {"en":"every attempt","ko":"모든 시도에"},
    {"en":"at simple paraphrase,","ko":"단순한 풀어 말하기 시도에,"},
    {"en":"the resistance","ko":"그 저항은"},
    {"en":"often points to","ko":"종종 가리킨다"},
    {"en":"absence","ko":"부재를"},
    {"en":"rather than depth.","ko":"깊이가 아니라."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'c000000d-0000-0000-0000-00000000000d' and p.ord = 1;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'A short sentence that survives translation into a child''s words has earned the right to look simple.',
  '[
    {"en":"A short sentence","ko":"짧은 문장은"},
    {"en":"that survives","ko":"살아남는"},
    {"en":"translation","ko":"번역에서"},
    {"en":"into a child''s words","ko":"아이의 말로의"},
    {"en":"has earned the right","ko":"권리를 얻은 것이다"},
    {"en":"to look simple.","ko":"단순해 보일."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'c000000d-0000-0000-0000-00000000000d' and p.ord = 2;

-- c000000e Why Innovation Often Comes From Outsiders
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Newcomers ask questions that insiders have stopped asking, because insiders have already learned which questions sound foolish.',
  '[
    {"en":"Newcomers ask questions","ko":"신참자들은 질문을 한다"},
    {"en":"that insiders have stopped asking,","ko":"내부자들이 묻기를 그만둔,"},
    {"en":"because insiders have already learned","ko":"왜냐하면 내부자들은 이미 배웠기 때문에"},
    {"en":"which questions","ko":"어떤 질문들이"},
    {"en":"sound foolish.","ko":"바보처럼 들리는지를."}
  ]'::jsonb,
  '관계대명사 that + 간접의문문'
from te_paragraphs p where p.passage_id = 'c000000e-0000-0000-0000-00000000000e' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Many famous inventions appeared at the edges where two fields touched, brought there by people who belonged fully to neither.',
  '[
    {"en":"Many famous inventions","ko":"많은 유명한 발명들은"},
    {"en":"appeared at the edges","ko":"경계에서 나타났다"},
    {"en":"where two fields touched,","ko":"두 분야가 맞닿은,"},
    {"en":"brought there","ko":"그곳으로 가져와진"},
    {"en":"by people","ko":"사람들에 의해"},
    {"en":"who belonged fully to neither.","ko":"어느 쪽에도 완전히 속하지 않은."}
  ]'::jsonb,
  '관계부사 where + 과거분사구문 + who'
from te_paragraphs p where p.passage_id = 'c000000e-0000-0000-0000-00000000000e' and p.ord = 1;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'It means an outsider has a chance the insider has slowly traded away.',
  '[
    {"en":"It means","ko":"그것은 의미한다"},
    {"en":"an outsider has a chance","ko":"외부자가 기회를 가진다는 것을"},
    {"en":"the insider has slowly traded away.","ko":"내부자가 천천히 내준."}
  ]'::jsonb,
  '명사절 두 개 중첩 (that 둘 다 생략)'
from te_paragraphs p where p.passage_id = 'c000000e-0000-0000-0000-00000000000e' and p.ord = 2;

-- c000000f The Discipline of Slowness
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'A culture that prizes speed treats slowness as weakness.',
  '[
    {"en":"A culture","ko":"문화는"},
    {"en":"that prizes speed","ko":"속도를 중시하는"},
    {"en":"treats slowness","ko":"느림을 취급한다"},
    {"en":"as weakness.","ko":"약점으로."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'c000000f-0000-0000-0000-00000000000f' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Some problems reveal their shape only after we stop pushing on them.',
  '[
    {"en":"Some problems","ko":"어떤 문제들은"},
    {"en":"reveal their shape","ko":"자신의 모양을 드러낸다"},
    {"en":"only after","ko":"오직 ~한 후에야"},
    {"en":"we stop pushing on them.","ko":"우리가 그것들을 밀어붙이기를 멈춘."}
  ]'::jsonb,
  'after 시간 부사절'
from te_paragraphs p where p.passage_id = 'c000000f-0000-0000-0000-00000000000f' and p.ord = 1;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'It is a disciplined refusal to confuse the appearance of progress with the substance of it.',
  '[
    {"en":"It is","ko":"그것은"},
    {"en":"a disciplined refusal","ko":"규율 있는 거부이다"},
    {"en":"to confuse","ko":"혼동하기를"},
    {"en":"the appearance of progress","ko":"진보의 외양을"},
    {"en":"with the substance of it.","ko":"그것의 실체와."}
  ]'::jsonb,
  'confuse A with B'
from te_paragraphs p where p.passage_id = 'c000000f-0000-0000-0000-00000000000f' and p.ord = 2;
