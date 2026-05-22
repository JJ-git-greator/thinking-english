-- =====================================================================
-- 직독직해 청크 시드 v2 — 중(mid) 20지문, 단락당 1문장 (60문장)
-- 의미단위 원칙: 주어/동사+목적어/부사구/절 통째
-- =====================================================================

-- b0000001 The Trap of Sunk Costs
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'The only honest question is whether the next hour will be enjoyable.',
  '[
    {"en":"The only honest question","ko":"유일하게 정직한 질문은"},
    {"en":"is whether the next hour will be enjoyable.","ko":"다음 한 시간이 즐거울지 아닐지이다."}
  ]'::jsonb,
  'whether 명사절 통째 (보어)'
from te_paragraphs p where p.passage_id = 'b0000001-0000-0000-0000-000000000001' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'People keep reading a boring book because they finished half of it.',
  '[
    {"en":"People keep reading a boring book","ko":"사람들은 지루한 책을 계속 읽는다"},
    {"en":"because they finished half of it.","ko":"왜냐하면 그것의 절반을 끝냈기 때문에."}
  ]'::jsonb,
  'because 부사절 통째'
from te_paragraphs p where p.passage_id = 'b0000001-0000-0000-0000-000000000001' and p.ord = 1;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'What is already spent cannot come back, so it should not steer the next step.',
  '[
    {"en":"What is already spent","ko":"이미 쓰인 것은"},
    {"en":"cannot come back,","ko":"돌아올 수 없다,"},
    {"en":"so it should not steer the next step.","ko":"그래서 다음 단계를 좌우해서는 안 된다."}
  ]'::jsonb,
  'what 명사절 = 주어'
from te_paragraphs p where p.passage_id = 'b0000001-0000-0000-0000-000000000001' and p.ord = 2;

-- b0000002 Plastic That Disappears Into Water
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'When a plastic bottle reaches the ocean, the sun and salt slowly tear it apart.',
  '[
    {"en":"When a plastic bottle reaches the ocean,","ko":"플라스틱 병이 바다에 도달하면,"},
    {"en":"the sun and salt","ko":"태양과 소금이"},
    {"en":"slowly tear it apart.","ko":"천천히 그것을 찢어 분해한다."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'b0000002-0000-0000-0000-000000000002' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'By the time the chain reaches our plates, the plastic has come back to us.',
  '[
    {"en":"By the time the chain reaches our plates,","ko":"먹이 사슬이 우리 접시에 도달할 때쯤이면,"},
    {"en":"the plastic has come back to us.","ko":"플라스틱은 우리에게 돌아와 있다."}
  ]'::jsonb,
  'By the time 부사절 통째'
from te_paragraphs p where p.passage_id = 'b0000002-0000-0000-0000-000000000002' and p.ord = 1;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'The only real cure is producing less of the material that does not truly go away.',
  '[
    {"en":"The only real cure","ko":"유일하게 진짜 해결책은"},
    {"en":"is producing less of the material","ko":"그 물질을 덜 생산하는 것이다"},
    {"en":"that does not truly go away.","ko":"진정으로 사라지지 않는."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'b0000002-0000-0000-0000-000000000002' and p.ord = 2;

-- b0000003 Why We Notice What We Already Believe
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'It pays extra attention to facts that match what we already think, and it quietly skips the rest.',
  '[
    {"en":"It pays extra attention to facts","ko":"마음은 사실들에 더 많은 관심을 둔다"},
    {"en":"that match what we already think,","ko":"우리가 이미 생각하는 것과 맞는,"},
    {"en":"and it quietly skips the rest.","ko":"그리고 조용히 나머지를 건너뛴다."}
  ]'::jsonb,
  '관계대명사 that + what 명사절'
from te_paragraphs p where p.passage_id = 'b0000003-0000-0000-0000-000000000003' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'The skipped facts never leave a mark, so it seems like the world simply lined up with our view.',
  '[
    {"en":"The skipped facts never leave a mark,","ko":"건너뛴 사실들은 흔적을 남기지 않는다,"},
    {"en":"so it seems like","ko":"그래서 ~처럼 보인다"},
    {"en":"the world simply lined up with our view.","ko":"세상이 그저 우리 견해와 줄지어 있는 것."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'b0000003-0000-0000-0000-000000000003' and p.ord = 1;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'We have to seek out the very evidence we would rather avoid.',
  '[
    {"en":"We have to seek out","ko":"우리는 찾아 나서야 한다"},
    {"en":"the very evidence","ko":"바로 그 증거를"},
    {"en":"we would rather avoid.","ko":"우리가 차라리 피하고 싶은."}
  ]'::jsonb,
  '목적격 관계대명사 생략'
from te_paragraphs p where p.passage_id = 'b0000003-0000-0000-0000-000000000003' and p.ord = 2;

-- b0000004 How an Algorithm Builds a Bubble
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'An algorithm has one job: predict what will keep your eyes on the screen.',
  '[
    {"en":"An algorithm has one job:","ko":"알고리즘은 한 가지 일을 가진다:"},
    {"en":"predict","ko":"예측하는 것"},
    {"en":"what will keep your eyes on the screen.","ko":"무엇이 당신의 눈을 화면에 붙들어둘지를."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'b0000004-0000-0000-0000-000000000004' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'The system shows what you already like, not what might broaden your view.',
  '[
    {"en":"The system shows","ko":"시스템은 보여준다"},
    {"en":"what you already like,","ko":"당신이 이미 좋아하는 것을,"},
    {"en":"not what might broaden your view.","ko":"당신의 시야를 넓혀줄 수 있는 것이 아니라."}
  ]'::jsonb,
  'what 명사절 두 개 (대조)'
from te_paragraphs p where p.passage_id = 'b0000004-0000-0000-0000-000000000004' and p.ord = 1;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'You have to deliberately seek out voices the feed never serves you.',
  '[
    {"en":"You have to deliberately seek out voices","ko":"당신은 목소리들을 의도적으로 찾아 나서야 한다"},
    {"en":"the feed never serves you.","ko":"피드가 당신에게 절대 제공하지 않는."}
  ]'::jsonb,
  '목적격 관계대명사 생략'
from te_paragraphs p where p.passage_id = 'b0000004-0000-0000-0000-000000000004' and p.ord = 2;

-- b0000005 The Silk Road Was More Than Silk
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'They carried ideas, religions, recipes, instruments, and diseases.',
  '[
    {"en":"They carried ideas, religions, recipes,","ko":"그들은 생각, 종교, 요리법을 운반했다,"},
    {"en":"instruments, and diseases.","ko":"악기, 그리고 질병도."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'b0000005-0000-0000-0000-000000000005' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Whole faiths spread along the same routes that carried spices.',
  '[
    {"en":"Whole faiths spread","ko":"전체 종교들이 퍼졌다"},
    {"en":"along the same routes","ko":"같은 길을 따라"},
    {"en":"that carried spices.","ko":"향신료를 실어 나르던."}
  ]'::jsonb,
  '관계대명사 that 절 통째'
from te_paragraphs p where p.passage_id = 'b0000005-0000-0000-0000-000000000005' and p.ord = 1;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Whenever people meet to exchange things, they end up exchanging much more than they intended.',
  '[
    {"en":"Whenever people meet to exchange things,","ko":"사람들이 물건을 교환하려고 만날 때마다,"},
    {"en":"they end up exchanging much more","ko":"그들은 결국 훨씬 더 많은 것을 교환하게 된다"},
    {"en":"than they intended.","ko":"그들이 의도했던 것보다."}
  ]'::jsonb,
  'Whenever 부사절 통째'
from te_paragraphs p where p.passage_id = 'b0000005-0000-0000-0000-000000000005' and p.ord = 2;

-- b0000006 When Painters Discovered Depth
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Distant people are sometimes drawn larger than nearby ones, because they were more important to the story.',
  '[
    {"en":"Distant people are sometimes drawn larger","ko":"멀리 있는 사람들이 때때로 더 크게 그려진다"},
    {"en":"than nearby ones,","ko":"가까이 있는 사람들보다,"},
    {"en":"because they were more important to the story.","ko":"왜냐하면 그들이 이야기에 더 중요했기 때문에."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'b0000006-0000-0000-0000-000000000006' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Lines that ran away from the viewer met at a single hidden point, and suddenly paintings opened like windows.',
  '[
    {"en":"Lines","ko":"선들이"},
    {"en":"that ran away from the viewer","ko":"보는 사람으로부터 멀어져 가는"},
    {"en":"met at a single hidden point,","ko":"하나의 숨겨진 점에서 만났다,"},
    {"en":"and suddenly paintings opened like windows.","ko":"그러자 갑자기 그림들은 창문처럼 열렸다."}
  ]'::jsonb,
  '관계대명사 that 절'
from te_paragraphs p where p.passage_id = 'b0000006-0000-0000-0000-000000000006' and p.ord = 1;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'When the goal changed, the technique followed.',
  '[
    {"en":"When the goal changed,","ko":"목표가 바뀌었을 때,"},
    {"en":"the technique followed.","ko":"기법이 따라왔다."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'b0000006-0000-0000-0000-000000000006' and p.ord = 2;

-- b0000007 A Sugar Pill That Heals
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'A patient who believes a pill will help often reports less pain even when the pill contains nothing active.',
  '[
    {"en":"A patient","ko":"환자는"},
    {"en":"who believes a pill will help","ko":"알약이 도움이 될 것이라 믿는"},
    {"en":"often reports less pain","ko":"종종 통증이 줄었다고 보고한다"},
    {"en":"even when the pill contains nothing active.","ko":"심지어 알약에 유효 성분이 전혀 없을 때도."}
  ]'::jsonb,
  'who 관계절 통째, even when 양보 부사절 통째'
from te_paragraphs p where p.passage_id = 'b0000007-0000-0000-0000-000000000007' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Brain scans show that expectation alone can trigger the release of natural painkillers.',
  '[
    {"en":"Brain scans show","ko":"뇌 스캔은 보여준다"},
    {"en":"that expectation alone","ko":"기대만으로도"},
    {"en":"can trigger the release of natural painkillers.","ko":"자연 진통제의 방출을 촉발할 수 있다는 것을."}
  ]'::jsonb,
  'that 명사절'
from te_paragraphs p where p.passage_id = 'b0000007-0000-0000-0000-000000000007' and p.ord = 1;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Hope, trust, and ritual are quietly working alongside the chemistry.',
  '[
    {"en":"Hope, trust, and ritual","ko":"희망, 신뢰, 의식은"},
    {"en":"are quietly working","ko":"조용히 작용하고 있다"},
    {"en":"alongside the chemistry.","ko":"화학 작용과 나란히."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'b0000007-0000-0000-0000-000000000007' and p.ord = 2;

-- b0000008 When Villages Become Cities
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Today more than half of the world is urban, and the share keeps climbing.',
  '[
    {"en":"Today more than half of the world","ko":"오늘날 세계의 절반 이상이"},
    {"en":"is urban,","ko":"도시에 산다,"},
    {"en":"and the share keeps climbing.","ko":"그리고 그 비율은 계속 올라간다."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'b0000008-0000-0000-0000-000000000008' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Cities make jobs and ideas easier to find.',
  '[
    {"en":"Cities make jobs and ideas","ko":"도시는 일자리와 아이디어를 만든다"},
    {"en":"easier to find.","ko":"찾기 더 쉽게."}
  ]'::jsonb,
  '5형식: make + O + 형용사'
from te_paragraphs p where p.passage_id = 'b0000008-0000-0000-0000-000000000008' and p.ord = 1;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Cities that plan ahead live differently from cities that grow only because people arrive.',
  '[
    {"en":"Cities that plan ahead","ko":"미리 계획하는 도시들은"},
    {"en":"live differently","ko":"다르게 산다"},
    {"en":"from cities that grow","ko":"성장하는 도시들과는"},
    {"en":"only because people arrive.","ko":"단지 사람들이 도착하기 때문에."}
  ]'::jsonb,
  '관계대명사 that 두 번 (각각 통째)'
from te_paragraphs p where p.passage_id = 'b0000008-0000-0000-0000-000000000008' and p.ord = 2;

-- b0000009 The Old Argument About Free Choice
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Genes, culture, hunger, sleep, and the mood of the moment all push the decision in directions we barely notice.',
  '[
    {"en":"Genes, culture, hunger, sleep,","ko":"유전자, 문화, 허기, 잠,"},
    {"en":"and the mood of the moment","ko":"그리고 그 순간의 기분이"},
    {"en":"all push the decision","ko":"모두 결정을 밀어붙인다"},
    {"en":"in directions we barely notice.","ko":"우리가 거의 알아채지 못하는 방향으로."}
  ]'::jsonb,
  '복합 주어, 목적격 관계대명사 생략 절 통째'
from te_paragraphs p where p.passage_id = 'b0000009-0000-0000-0000-000000000009' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Others say freedom is not freedom from causes but the ability to respond to reasons.',
  '[
    {"en":"Others say","ko":"다른 이들은 말한다"},
    {"en":"freedom is not freedom from causes","ko":"자유가 원인으로부터의 자유가 아니라"},
    {"en":"but the ability to respond to reasons.","ko":"이성에 반응하는 능력이라고."}
  ]'::jsonb,
  'not A but B'
from te_paragraphs p where p.passage_id = 'b0000009-0000-0000-0000-000000000009' and p.ord = 1;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'A decision made with awareness still feels different from one made on autopilot.',
  '[
    {"en":"A decision made with awareness","ko":"의식하고 내린 결정은"},
    {"en":"still feels different","ko":"여전히 다르게 느껴진다"},
    {"en":"from one made on autopilot.","ko":"자동으로 내려진 결정과는."}
  ]'::jsonb,
  '과거분사구 후치수식 통째'
from te_paragraphs p where p.passage_id = 'b0000009-0000-0000-0000-000000000009' and p.ord = 2;

-- b000000a High Context, Low Context
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'People rely on the words to carry the meaning, and asking too many indirect questions feels evasive.',
  '[
    {"en":"People rely on the words","ko":"사람들은 말 자체에 의존한다"},
    {"en":"to carry the meaning,","ko":"의미를 전달하도록,"},
    {"en":"and asking too many indirect questions","ko":"그리고 너무 많은 간접 질문을 하는 것은"},
    {"en":"feels evasive.","ko":"회피적으로 느껴진다."}
  ]'::jsonb,
  '동명사구 주어'
from te_paragraphs p where p.passage_id = 'b000000a-0000-0000-0000-00000000000a' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Listeners read the relationship, the tone, and the silence as carefully as the words themselves.',
  '[
    {"en":"Listeners read","ko":"듣는 사람들은 읽는다"},
    {"en":"the relationship, the tone, and the silence","ko":"관계, 어조, 침묵을"},
    {"en":"as carefully as the words themselves.","ko":"말 자체만큼이나 신중하게."}
  ]'::jsonb,
  'as ~ as 비교구 통째'
from te_paragraphs p where p.passage_id = 'b000000a-0000-0000-0000-00000000000a' and p.ord = 1;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'A speaker from one tradition may be saying yes while the listener from another tradition hears no.',
  '[
    {"en":"A speaker from one tradition","ko":"한 전통의 화자가"},
    {"en":"may be saying yes","ko":"예라고 말하고 있을 수 있다"},
    {"en":"while the listener from another tradition","ko":"반면 다른 전통의 듣는 사람은"},
    {"en":"hears no.","ko":"아니오라고 듣는다."}
  ]'::jsonb,
  'while 대조 부사절'
from te_paragraphs p where p.passage_id = 'b000000a-0000-0000-0000-00000000000a' and p.ord = 2;

-- b000000b The Body Clock Inside You
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'In experiments, volunteers have lived for weeks in caves with no sunlight and no clocks.',
  '[
    {"en":"In experiments,","ko":"실험에서,"},
    {"en":"volunteers have lived for weeks","ko":"자원자들은 몇 주 동안 살아왔다"},
    {"en":"in caves with no sunlight and no clocks.","ko":"햇빛도 시계도 없는 동굴 안에서."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'b000000b-0000-0000-0000-00000000000b' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'It sets the timing of hormone release, body temperature, and even the strength of the immune system at different hours of the day.',
  '[
    {"en":"It sets the timing","ko":"그것은 타이밍을 설정한다"},
    {"en":"of hormone release, body temperature,","ko":"호르몬 분비, 체온,"},
    {"en":"and even the strength of the immune system","ko":"그리고 심지어 면역계의 강도까지도"},
    {"en":"at different hours of the day.","ko":"하루의 서로 다른 시간에."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'b000000b-0000-0000-0000-00000000000b' and p.ord = 1;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Over years, the fight has measurable health costs.',
  '[
    {"en":"Over years,","ko":"수년에 걸쳐,"},
    {"en":"the fight has measurable health costs.","ko":"그 싸움은 측정 가능한 건강 비용을 초래한다."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'b000000b-0000-0000-0000-00000000000b' and p.ord = 2;

-- b000000c What You Give Up by Choosing
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'You are also choosing not to have any other flavor in the case.',
  '[
    {"en":"You are also choosing","ko":"당신은 또한 선택하고 있다"},
    {"en":"not to have any other flavor","ko":"다른 어떤 맛도 가지지 않기로"},
    {"en":"in the case.","ko":"진열장 안의."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'b000000c-0000-0000-0000-00000000000c' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Economists call the value of the option you gave up the opportunity cost.',
  '[
    {"en":"Economists call","ko":"경제학자들은 부른다"},
    {"en":"the value of the option","ko":"선택지의 가치를"},
    {"en":"you gave up","ko":"당신이 포기한"},
    {"en":"the opportunity cost.","ko":"기회비용이라고."}
  ]'::jsonb,
  '5형식 call + O + 보어'
from te_paragraphs p where p.passage_id = 'b000000c-0000-0000-0000-00000000000c' and p.ord = 1;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Big decisions become clearer once we ask what we are giving up, not only what we are getting.',
  '[
    {"en":"Big decisions become clearer","ko":"큰 결정은 더 명확해진다"},
    {"en":"once we ask","ko":"우리가 묻기 시작하면"},
    {"en":"what we are giving up,","ko":"우리가 포기하는 것이 무엇인지를,"},
    {"en":"not only what we are getting.","ko":"얻는 것뿐만 아니라."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'b000000c-0000-0000-0000-00000000000c' and p.ord = 2;

-- b000000d The Most Wanted Thing Online
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Advertisers are the customers, and the user is the product whose attention is sold.',
  '[
    {"en":"Advertisers are the customers,","ko":"광고주들이 고객이다,"},
    {"en":"and the user is the product","ko":"그리고 사용자는 상품이다"},
    {"en":"whose attention is sold.","ko":"그 관심이 판매되는."}
  ]'::jsonb,
  '소유격 관계대명사 whose 절 통째'
from te_paragraphs p where p.passage_id = 'b000000d-0000-0000-0000-00000000000d' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'There are only so many hours in a day, and many apps fight for the same ones.',
  '[
    {"en":"There are only so many hours in a day,","ko":"하루에는 시간이 그만큼만 있다,"},
    {"en":"and many apps fight for the same ones.","ko":"그리고 많은 앱들이 같은 시간을 두고 다툰다."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'b000000d-0000-0000-0000-00000000000d' and p.ord = 1;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Endless scrolling is not free time; it is paid time, paid in something we cannot earn back.',
  '[
    {"en":"Endless scrolling is not free time;","ko":"끝없는 스크롤은 자유 시간이 아니다;"},
    {"en":"it is paid time,","ko":"그것은 지불된 시간이다,"},
    {"en":"paid in something","ko":"무언가로 지불된"},
    {"en":"we cannot earn back.","ko":"우리가 되찾을 수 없는."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'b000000d-0000-0000-0000-00000000000d' and p.ord = 2;

-- b000000e Animals That Pretend
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'A harmless hoverfly wears the same yellow and black stripes as a stinging wasp.',
  '[
    {"en":"A harmless hoverfly","ko":"해롭지 않은 꽃등에는"},
    {"en":"wears the same yellow and black stripes","ko":"같은 노란색과 검은색 줄무늬를 입는다"},
    {"en":"as a stinging wasp.","ko":"쏘는 말벌과 같이."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'b000000e-0000-0000-0000-00000000000e' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'A stick insect looks like a twig, a leaf insect like a torn leaf.',
  '[
    {"en":"A stick insect looks like a twig,","ko":"대벌레는 나뭇가지처럼 보이고,"},
    {"en":"a leaf insect like a torn leaf.","ko":"잎벌레는 찢어진 잎처럼 (보인다)."}
  ]'::jsonb,
  '병렬 구조 (looks 생략)'
from te_paragraphs p where p.passage_id = 'b000000e-0000-0000-0000-00000000000e' and p.ord = 1;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Borrowing the appearance of something dangerous, or of nothing at all, often works just as well.',
  '[
    {"en":"Borrowing the appearance","ko":"외모를 빌리는 것이"},
    {"en":"of something dangerous,","ko":"위험한 무언가의,"},
    {"en":"or of nothing at all,","ko":"또는 아무것도 아닌 것의,"},
    {"en":"often works just as well.","ko":"종종 똑같이 효과가 있다."}
  ]'::jsonb,
  '동명사 주어 (Borrowing ~)'
from te_paragraphs p where p.passage_id = 'b000000e-0000-0000-0000-00000000000e' and p.ord = 2;

-- b000000f Why New Cities Mix Everything
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'A traditional city zoned for cars made every trip long.',
  '[
    {"en":"A traditional city","ko":"전통적인 도시는"},
    {"en":"zoned for cars","ko":"자동차용으로 구역이 정해진"},
    {"en":"made every trip long.","ko":"모든 이동을 길게 만들었다."}
  ]'::jsonb,
  '과거분사구 후치수식, 5형식'
from te_paragraphs p where p.passage_id = 'b000000f-0000-0000-0000-00000000000f' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'A mixed-use street puts shops on the ground floor, offices above, and apartments on top.',
  '[
    {"en":"A mixed-use street puts","ko":"복합용도 거리는 배치한다"},
    {"en":"shops on the ground floor,","ko":"상점을 1층에,"},
    {"en":"offices above,","ko":"사무실을 위층에,"},
    {"en":"and apartments on top.","ko":"그리고 아파트를 맨 위에."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'b000000f-0000-0000-0000-00000000000f' and p.ord = 1;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Streets fill with people throughout the day, which makes them safer and livelier in ways that empty zoned areas never become.',
  '[
    {"en":"Streets fill with people","ko":"거리는 사람들로 채워진다"},
    {"en":"throughout the day,","ko":"하루 종일,"},
    {"en":"which makes them safer and livelier","ko":"그것이 거리를 더 안전하고 더 활기차게 만든다"},
    {"en":"in ways that empty zoned areas never become.","ko":"빈 구역들은 결코 되지 못하는 방식으로."}
  ]'::jsonb,
  '계속적 용법 which, 관계대명사 that'
from te_paragraphs p where p.passage_id = 'b000000f-0000-0000-0000-00000000000f' and p.ord = 2;

-- b0000010 A Sad Song in Every Language
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'When sad music is played slowly with low notes, listeners around the world tend to call it sad.',
  '[
    {"en":"When sad music is played slowly","ko":"슬픈 음악이 느리게 연주될 때"},
    {"en":"with low notes,","ko":"낮은 음으로,"},
    {"en":"listeners around the world","ko":"세계 곳곳의 청취자들은"},
    {"en":"tend to call it sad.","ko":"그것을 슬프다고 부르는 경향이 있다."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'b0000010-0000-0000-0000-000000000010' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Slow tempos resemble a sleeping heartbeat; low pitches resemble a quiet voice.',
  '[
    {"en":"Slow tempos resemble a sleeping heartbeat;","ko":"느린 박자는 잠자는 심장 박동을 닮았다;"},
    {"en":"low pitches resemble a quiet voice.","ko":"낮은 음높이는 조용한 목소리를 닮았다."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'b0000010-0000-0000-0000-000000000010' and p.ord = 1;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Music varies enormously across cultures, but a small core seems to be shared.',
  '[
    {"en":"Music varies enormously","ko":"음악은 엄청나게 다양하다"},
    {"en":"across cultures,","ko":"문화에 따라,"},
    {"en":"but a small core seems to be shared.","ko":"하지만 작은 핵심은 공유되는 것으로 보인다."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'b0000010-0000-0000-0000-000000000010' and p.ord = 2;

-- b0000011 How a Shared Language Spread
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'No one wanted to learn three new languages just to sell goods.',
  '[
    {"en":"No one wanted","ko":"아무도 원치 않았다"},
    {"en":"to learn three new languages","ko":"세 개의 새 언어를 배우는 것을"},
    {"en":"just to sell goods.","ko":"단지 물건을 팔기 위해."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'b0000011-0000-0000-0000-000000000011' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'It is built for usefulness, not for poetry.',
  '[
    {"en":"It is built","ko":"그것은 만들어졌다"},
    {"en":"for usefulness, not for poetry.","ko":"유용함을 위해, 시를 위해서가 아니라."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'b0000011-0000-0000-0000-000000000011' and p.ord = 1;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Sometimes, surprisingly, it grows roots and becomes a native language for the next generation.',
  '[
    {"en":"Sometimes, surprisingly,","ko":"때로, 놀랍게도,"},
    {"en":"it grows roots","ko":"그것은 뿌리를 내린다"},
    {"en":"and becomes a native language","ko":"그리고 모국어가 된다"},
    {"en":"for the next generation.","ko":"다음 세대를 위한."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'b0000011-0000-0000-0000-000000000011' and p.ord = 2;

-- b0000012 Why Tomorrow Feels Less Real
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'The future second candy feels less real than the candy in front of them.',
  '[
    {"en":"The future second candy","ko":"미래의 두 번째 사탕은"},
    {"en":"feels less real","ko":"덜 현실적으로 느껴진다"},
    {"en":"than the candy in front of them.","ko":"그들 앞에 있는 사탕보다."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'b0000012-0000-0000-0000-000000000012' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'They skip exercise that pays off next year for comfort tonight.',
  '[
    {"en":"They skip exercise","ko":"그들은 운동을 건너뛴다"},
    {"en":"that pays off next year","ko":"내년에 이득이 되는"},
    {"en":"for comfort tonight.","ko":"오늘 밤의 편안함을 위해."}
  ]'::jsonb,
  '관계대명사 that'
from te_paragraphs p where p.passage_id = 'b0000012-0000-0000-0000-000000000012' and p.ord = 1;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'The future self becomes a person worth keeping a promise to.',
  '[
    {"en":"The future self becomes a person","ko":"미래의 자아는 한 사람이 된다"},
    {"en":"worth keeping a promise to.","ko":"약속을 지킬 가치가 있는."}
  ]'::jsonb,
  'worth + 동명사 형용사구'
from te_paragraphs p where p.passage_id = 'b0000012-0000-0000-0000-000000000012' and p.ord = 2;

-- b0000013 Two Prisoners and a Choice
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'If one stays silent and one betrays, the betrayer walks free and the silent one suffers most.',
  '[
    {"en":"If one stays silent and one betrays,","ko":"한 명이 침묵하고 한 명이 배신하면,"},
    {"en":"the betrayer walks free","ko":"배신자는 풀려난다"},
    {"en":"and the silent one suffers most.","ko":"그리고 침묵한 자는 가장 큰 고통을 받는다."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'b0000013-0000-0000-0000-000000000013' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'If both follow that logic, both lose.',
  '[
    {"en":"If both follow that logic,","ko":"둘 다 그 논리를 따른다면,"},
    {"en":"both lose.","ko":"둘 다 진다."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'b0000013-0000-0000-0000-000000000013' and p.ord = 1;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Countries deciding on pollution, neighbors deciding on noise, students deciding on group projects all face a version of the same trap.',
  '[
    {"en":"Countries deciding on pollution,","ko":"공해에 대해 결정하는 나라들,"},
    {"en":"neighbors deciding on noise,","ko":"소음에 대해 결정하는 이웃들,"},
    {"en":"students deciding on group projects","ko":"조별 과제에 대해 결정하는 학생들이"},
    {"en":"all face a version of the same trap.","ko":"모두 같은 함정의 한 버전을 마주한다."}
  ]'::jsonb,
  '현재분사구 후치수식 (병렬 세 개)'
from te_paragraphs p where p.passage_id = 'b0000013-0000-0000-0000-000000000013' and p.ord = 2;

-- b0000014 The Missing Mass of the Universe
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'The stars spin too fast for the visible matter alone to hold them together.',
  '[
    {"en":"The stars spin too fast","ko":"별들은 너무 빨리 회전한다"},
    {"en":"for the visible matter alone","ko":"보이는 물질만으로는"},
    {"en":"to hold them together.","ko":"그것들을 묶어둘 수 없을 만큼."}
  ]'::jsonb,
  'too ~ for X to ~'
from te_paragraphs p where p.passage_id = 'b0000014-0000-0000-0000-000000000014' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'It does not give off light, and it ignores almost everything except gravity.',
  '[
    {"en":"It does not give off light,","ko":"그것은 빛을 발산하지 않는다,"},
    {"en":"and it ignores almost everything","ko":"그리고 거의 모든 것을 무시한다"},
    {"en":"except gravity.","ko":"중력만 제외하고."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'b0000014-0000-0000-0000-000000000014' and p.ord = 1;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Most of what holds the cosmos together is hidden in plain sight.',
  '[
    {"en":"Most of what holds the cosmos together","ko":"우주를 함께 붙들고 있는 것의 대부분이"},
    {"en":"is hidden in plain sight.","ko":"눈에 잘 띄는 곳에 숨겨져 있다."}
  ]'::jsonb,
  'what 명사절이 주어 통째'
from te_paragraphs p where p.passage_id = 'b0000014-0000-0000-0000-000000000014' and p.ord = 2;
