-- =====================================================================
-- 직독직해 청크 시드 — 중(mid) 난이도 20지문, 단락당 1문장 (60문장)
-- =====================================================================

-- b0000001 The Trap of Sunk Costs
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'The only honest question is whether the next hour will be enjoyable.',
  '[
    {"en":"The only honest question","ko":"유일하게 정직한 질문은"},
    {"en":"is","ko":"~이다"},
    {"en":"whether the next hour","ko":"다음 한 시간이"},
    {"en":"will be enjoyable.","ko":"즐거울지 아닐지."}
  ]'::jsonb,
  'whether 명사절이 보어'
from te_paragraphs p where p.passage_id = 'b0000001-0000-0000-0000-000000000001' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'People keep reading a boring book because they finished half of it.',
  '[
    {"en":"People keep reading","ko":"사람들은 계속 읽는다"},
    {"en":"a boring book","ko":"지루한 책을"},
    {"en":"because they finished","ko":"왜냐하면 그들이 끝냈으니까"},
    {"en":"half of it.","ko":"그것의 절반을."}
  ]'::jsonb,
  'because 이유 부사절'
from te_paragraphs p where p.passage_id = 'b0000001-0000-0000-0000-000000000001' and p.ord = 1;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'What is already spent cannot come back, so it should not steer the next step.',
  '[
    {"en":"What is already spent","ko":"이미 쓰인 것은"},
    {"en":"cannot come back,","ko":"돌아올 수 없다,"},
    {"en":"so it should not steer","ko":"그래서 그것이 좌우해서는 안 된다"},
    {"en":"the next step.","ko":"다음 단계를."}
  ]'::jsonb,
  '관계대명사 what이 이끄는 명사절 = 주어'
from te_paragraphs p where p.passage_id = 'b0000001-0000-0000-0000-000000000001' and p.ord = 2;

-- b0000002 Plastic That Disappears Into Water
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'When a plastic bottle reaches the ocean, the sun and salt slowly tear it apart.',
  '[
    {"en":"When a plastic bottle","ko":"플라스틱 병이"},
    {"en":"reaches the ocean,","ko":"바다에 도달하면,"},
    {"en":"the sun and salt","ko":"태양과 소금이"},
    {"en":"slowly tear it apart.","ko":"천천히 그것을 찢어 분해한다."}
  ]'::jsonb,
  'when 시간 부사절'
from te_paragraphs p where p.passage_id = 'b0000002-0000-0000-0000-000000000002' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'By the time the chain reaches our plates, the plastic has come back to us.',
  '[
    {"en":"By the time","ko":"~할 때쯤이면"},
    {"en":"the chain reaches","ko":"먹이 사슬이 도달할 때"},
    {"en":"our plates,","ko":"우리 접시에,"},
    {"en":"the plastic","ko":"그 플라스틱은"},
    {"en":"has come back to us.","ko":"우리에게 돌아와 있다."}
  ]'::jsonb,
  'By the time ~ 시간 부사절 + 현재완료'
from te_paragraphs p where p.passage_id = 'b0000002-0000-0000-0000-000000000002' and p.ord = 1;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'The only real cure is producing less of the material that does not truly go away.',
  '[
    {"en":"The only real cure","ko":"유일하게 진짜 해결책은"},
    {"en":"is producing less","ko":"덜 생산하는 것이다"},
    {"en":"of the material","ko":"그 물질을"},
    {"en":"that does not truly go away.","ko":"진정으로 사라지지 않는."}
  ]'::jsonb,
  '관계대명사 that이 material 수식'
from te_paragraphs p where p.passage_id = 'b0000002-0000-0000-0000-000000000002' and p.ord = 2;

-- b0000003 Why We Notice What We Already Believe
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'It pays extra attention to facts that match what we already think, and it quietly skips the rest.',
  '[
    {"en":"It pays extra attention","ko":"마음은 더 많은 관심을 둔다"},
    {"en":"to facts","ko":"사실들에"},
    {"en":"that match","ko":"맞는"},
    {"en":"what we already think,","ko":"우리가 이미 생각하는 것과,"},
    {"en":"and it quietly skips","ko":"그리고 조용히 건너뛴다"},
    {"en":"the rest.","ko":"나머지를."}
  ]'::jsonb,
  '관계대명사 that + what 명사절'
from te_paragraphs p where p.passage_id = 'b0000003-0000-0000-0000-000000000003' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'The skipped facts never leave a mark, so it seems like the world simply lined up with our view.',
  '[
    {"en":"The skipped facts","ko":"건너뛴 사실들은"},
    {"en":"never leave a mark,","ko":"흔적을 남기지 않는다,"},
    {"en":"so it seems like","ko":"그래서 ~처럼 보인다"},
    {"en":"the world simply lined up","ko":"세상이 그저 줄지어 있는 것"},
    {"en":"with our view.","ko":"우리 견해와."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'b0000003-0000-0000-0000-000000000003' and p.ord = 1;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'We have to seek out the very evidence we would rather avoid.',
  '[
    {"en":"We have to","ko":"우리는 해야 한다"},
    {"en":"seek out","ko":"찾아 나서야 한다"},
    {"en":"the very evidence","ko":"바로 그 증거를"},
    {"en":"we would rather avoid.","ko":"우리가 차라리 피하고 싶은."}
  ]'::jsonb,
  '목적격 관계대명사 생략 (evidence 수식)'
from te_paragraphs p where p.passage_id = 'b0000003-0000-0000-0000-000000000003' and p.ord = 2;

-- b0000004 How an Algorithm Builds a Bubble
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'An algorithm has one job: predict what will keep your eyes on the screen.',
  '[
    {"en":"An algorithm","ko":"알고리즘은"},
    {"en":"has one job:","ko":"한 가지 일을 가진다:"},
    {"en":"predict","ko":"예측하는 것"},
    {"en":"what will keep","ko":"무엇이 유지시킬지를"},
    {"en":"your eyes on the screen.","ko":"당신의 눈을 화면에."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'b0000004-0000-0000-0000-000000000004' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'The system shows what you already like, not what might broaden your view.',
  '[
    {"en":"The system shows","ko":"시스템은 보여준다"},
    {"en":"what you already like,","ko":"당신이 이미 좋아하는 것을,"},
    {"en":"not what might broaden","ko":"넓혀줄 수 있는 것이 아니라"},
    {"en":"your view.","ko":"당신의 시야를."}
  ]'::jsonb,
  'what 명사절 두 개 (대조)'
from te_paragraphs p where p.passage_id = 'b0000004-0000-0000-0000-000000000004' and p.ord = 1;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'You have to deliberately seek out voices the feed never serves you.',
  '[
    {"en":"You have to","ko":"당신은 해야 한다"},
    {"en":"deliberately seek out","ko":"의도적으로 찾아 나서야 한다"},
    {"en":"voices","ko":"목소리들을"},
    {"en":"the feed never serves you.","ko":"피드가 당신에게 절대 제공하지 않는."}
  ]'::jsonb,
  '목적격 관계대명사 생략 (voices 수식)'
from te_paragraphs p where p.passage_id = 'b0000004-0000-0000-0000-000000000004' and p.ord = 2;

-- b0000005 The Silk Road Was More Than Silk
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'They carried ideas, religions, recipes, instruments, and diseases.',
  '[
    {"en":"They carried","ko":"그들은 운반했다"},
    {"en":"ideas, religions, recipes,","ko":"생각, 종교, 요리법,"},
    {"en":"instruments, and diseases.","ko":"악기, 그리고 질병을."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'b0000005-0000-0000-0000-000000000005' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Whole faiths spread along the same routes that carried spices.',
  '[
    {"en":"Whole faiths","ko":"전체 종교들이"},
    {"en":"spread","ko":"퍼졌다"},
    {"en":"along the same routes","ko":"같은 길을 따라"},
    {"en":"that carried spices.","ko":"향신료를 실어 나르던."}
  ]'::jsonb,
  '관계대명사 that이 routes 수식'
from te_paragraphs p where p.passage_id = 'b0000005-0000-0000-0000-000000000005' and p.ord = 1;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Whenever people meet to exchange things, they end up exchanging much more than they intended.',
  '[
    {"en":"Whenever people meet","ko":"사람들이 만날 때마다"},
    {"en":"to exchange things,","ko":"물건을 교환하려고,"},
    {"en":"they end up exchanging","ko":"그들은 결국 교환하게 된다"},
    {"en":"much more","ko":"훨씬 더 많은 것을"},
    {"en":"than they intended.","ko":"그들이 의도한 것보다."}
  ]'::jsonb,
  'Whenever 부사절, end up -ing'
from te_paragraphs p where p.passage_id = 'b0000005-0000-0000-0000-000000000005' and p.ord = 2;

-- b0000006 When Painters Discovered Depth
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Distant people are sometimes drawn larger than nearby ones, because they were more important to the story.',
  '[
    {"en":"Distant people","ko":"멀리 있는 사람들이"},
    {"en":"are sometimes drawn","ko":"때때로 그려진다"},
    {"en":"larger than nearby ones,","ko":"가까이 있는 사람들보다 더 크게,"},
    {"en":"because they were","ko":"왜냐하면 그들이"},
    {"en":"more important","ko":"더 중요했기 때문에"},
    {"en":"to the story.","ko":"이야기에."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'b0000006-0000-0000-0000-000000000006' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Lines that ran away from the viewer met at a single hidden point, and suddenly paintings opened like windows.',
  '[
    {"en":"Lines","ko":"선들이"},
    {"en":"that ran away","ko":"멀어져 가는"},
    {"en":"from the viewer","ko":"보는 사람으로부터"},
    {"en":"met","ko":"만났다"},
    {"en":"at a single hidden point,","ko":"하나의 숨겨진 점에서,"},
    {"en":"and suddenly paintings","ko":"그러자 갑자기 그림들은"},
    {"en":"opened like windows.","ko":"창문처럼 열렸다."}
  ]'::jsonb,
  '관계대명사 that, 비유 like windows'
from te_paragraphs p where p.passage_id = 'b0000006-0000-0000-0000-000000000006' and p.ord = 1;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'When the goal changed, the technique followed.',
  '[
    {"en":"When the goal changed,","ko":"목표가 바뀌었을 때,"},
    {"en":"the technique","ko":"기법이"},
    {"en":"followed.","ko":"따라왔다."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'b0000006-0000-0000-0000-000000000006' and p.ord = 2;

-- b0000007 A Sugar Pill That Heals
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'A patient who believes a pill will help often reports less pain even when the pill contains nothing active.',
  '[
    {"en":"A patient","ko":"환자는"},
    {"en":"who believes","ko":"믿는 사람"},
    {"en":"a pill will help","ko":"알약이 도움이 될 것이라고"},
    {"en":"often reports","ko":"종종 보고한다"},
    {"en":"less pain","ko":"통증이 줄어들었다고"},
    {"en":"even when the pill","ko":"심지어 알약이"},
    {"en":"contains nothing active.","ko":"유효 성분을 전혀 포함하지 않을 때도."}
  ]'::jsonb,
  '관계대명사 who, even when 양보 부사절'
from te_paragraphs p where p.passage_id = 'b0000007-0000-0000-0000-000000000007' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Brain scans show that expectation alone can trigger the release of natural painkillers.',
  '[
    {"en":"Brain scans show","ko":"뇌 스캔은 보여준다"},
    {"en":"that expectation alone","ko":"기대만으로도"},
    {"en":"can trigger","ko":"촉발할 수 있다는 것을"},
    {"en":"the release","ko":"방출을"},
    {"en":"of natural painkillers.","ko":"자연 진통제의."}
  ]'::jsonb,
  'that 명사절 (show의 목적어)'
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
    {"en":"Today","ko":"오늘날"},
    {"en":"more than half","ko":"절반 이상이"},
    {"en":"of the world","ko":"세계의"},
    {"en":"is urban,","ko":"도시에 산다,"},
    {"en":"and the share","ko":"그리고 그 비율은"},
    {"en":"keeps climbing.","ko":"계속 올라간다."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'b0000008-0000-0000-0000-000000000008' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Cities make jobs and ideas easier to find.',
  '[
    {"en":"Cities make","ko":"도시는 만든다"},
    {"en":"jobs and ideas","ko":"일자리와 아이디어를"},
    {"en":"easier to find.","ko":"찾기 더 쉽게."}
  ]'::jsonb,
  '5형식: make + 목적어 + 형용사 + to부정사'
from te_paragraphs p where p.passage_id = 'b0000008-0000-0000-0000-000000000008' and p.ord = 1;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Cities that plan ahead live differently from cities that grow only because people arrive.',
  '[
    {"en":"Cities","ko":"도시들은"},
    {"en":"that plan ahead","ko":"미리 계획하는"},
    {"en":"live differently","ko":"다르게 산다"},
    {"en":"from cities","ko":"도시들과는"},
    {"en":"that grow","ko":"성장하는"},
    {"en":"only because people arrive.","ko":"사람들이 도착하기 때문에만."}
  ]'::jsonb,
  '관계대명사 that 두 번'
from te_paragraphs p where p.passage_id = 'b0000008-0000-0000-0000-000000000008' and p.ord = 2;

-- b0000009 The Old Argument About Free Choice
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Genes, culture, hunger, sleep, and the mood of the moment all push the decision in directions we barely notice.',
  '[
    {"en":"Genes, culture, hunger, sleep,","ko":"유전자, 문화, 허기, 잠,"},
    {"en":"and the mood of the moment","ko":"그리고 그 순간의 기분이"},
    {"en":"all push","ko":"모두 밀어붙인다"},
    {"en":"the decision","ko":"결정을"},
    {"en":"in directions","ko":"방향으로"},
    {"en":"we barely notice.","ko":"우리가 거의 알아채지 못하는."}
  ]'::jsonb,
  '복합 주어, 목적격 관계대명사 생략'
from te_paragraphs p where p.passage_id = 'b0000009-0000-0000-0000-000000000009' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Others say freedom is not freedom from causes but the ability to respond to reasons.',
  '[
    {"en":"Others say","ko":"다른 이들은 말한다"},
    {"en":"freedom is","ko":"자유는"},
    {"en":"not freedom from causes","ko":"원인으로부터의 자유가 아니라"},
    {"en":"but the ability","ko":"오히려 능력이라고"},
    {"en":"to respond to reasons.","ko":"이성에 반응하는."}
  ]'::jsonb,
  'not A but B'
from te_paragraphs p where p.passage_id = 'b0000009-0000-0000-0000-000000000009' and p.ord = 1;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'A decision made with awareness still feels different from one made on autopilot.',
  '[
    {"en":"A decision","ko":"결정은"},
    {"en":"made with awareness","ko":"의식하고 내려진"},
    {"en":"still feels different","ko":"여전히 다르게 느껴진다"},
    {"en":"from one","ko":"하나와 비교해서"},
    {"en":"made on autopilot.","ko":"자동으로 내려진."}
  ]'::jsonb,
  '과거분사구 후치수식 두 번'
from te_paragraphs p where p.passage_id = 'b0000009-0000-0000-0000-000000000009' and p.ord = 2;

-- b000000a High Context, Low Context
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'People rely on the words to carry the meaning, and asking too many indirect questions feels evasive.',
  '[
    {"en":"People rely on","ko":"사람들은 의존한다"},
    {"en":"the words","ko":"말 자체에"},
    {"en":"to carry the meaning,","ko":"의미를 전달하도록,"},
    {"en":"and asking","ko":"그리고 묻는 것은"},
    {"en":"too many indirect questions","ko":"너무 많은 간접 질문을"},
    {"en":"feels evasive.","ko":"회피적으로 느껴진다."}
  ]'::jsonb,
  '동명사 주어 (asking ~)'
from te_paragraphs p where p.passage_id = 'b000000a-0000-0000-0000-00000000000a' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Listeners read the relationship, the tone, and the silence as carefully as the words themselves.',
  '[
    {"en":"Listeners read","ko":"듣는 사람들은 읽는다"},
    {"en":"the relationship, the tone,","ko":"관계, 어조,"},
    {"en":"and the silence","ko":"그리고 침묵을"},
    {"en":"as carefully as","ko":"~만큼 신중하게"},
    {"en":"the words themselves.","ko":"말 자체만큼이나."}
  ]'::jsonb,
  'as carefully as: 동등 비교'
from te_paragraphs p where p.passage_id = 'b000000a-0000-0000-0000-00000000000a' and p.ord = 1;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'A speaker from one tradition may be saying yes while the listener from another tradition hears no.',
  '[
    {"en":"A speaker","ko":"한 화자가"},
    {"en":"from one tradition","ko":"한 전통에서 온"},
    {"en":"may be saying yes","ko":"예라고 말하고 있을 수 있다"},
    {"en":"while the listener","ko":"반면 듣는 사람은"},
    {"en":"from another tradition","ko":"다른 전통에서 온"},
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
    {"en":"volunteers have lived","ko":"자원자들은 살아왔다"},
    {"en":"for weeks","ko":"몇 주 동안"},
    {"en":"in caves","ko":"동굴 안에서"},
    {"en":"with no sunlight","ko":"햇빛 없이"},
    {"en":"and no clocks.","ko":"그리고 시계 없이."}
  ]'::jsonb,
  '현재완료'
from te_paragraphs p where p.passage_id = 'b000000b-0000-0000-0000-00000000000b' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'It sets the timing of hormone release, body temperature, and even the strength of the immune system at different hours of the day.',
  '[
    {"en":"It sets","ko":"그것은 설정한다"},
    {"en":"the timing","ko":"타이밍을"},
    {"en":"of hormone release,","ko":"호르몬 분비의,"},
    {"en":"body temperature,","ko":"체온의,"},
    {"en":"and even the strength","ko":"그리고 심지어 강도까지도"},
    {"en":"of the immune system","ko":"면역계의"},
    {"en":"at different hours","ko":"서로 다른 시간에"},
    {"en":"of the day.","ko":"하루의."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'b000000b-0000-0000-0000-00000000000b' and p.ord = 1;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Over years, the fight has measurable health costs.',
  '[
    {"en":"Over years,","ko":"수년에 걸쳐,"},
    {"en":"the fight","ko":"그 싸움은"},
    {"en":"has measurable","ko":"측정 가능한"},
    {"en":"health costs.","ko":"건강 비용을 초래한다."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'b000000b-0000-0000-0000-00000000000b' and p.ord = 2;

-- b000000c What You Give Up by Choosing
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'You are also choosing not to have any other flavor in the case.',
  '[
    {"en":"You are also choosing","ko":"당신은 또한 선택하고 있다"},
    {"en":"not to have","ko":"가지지 않기로"},
    {"en":"any other flavor","ko":"어떤 다른 맛도"},
    {"en":"in the case.","ko":"진열장 안의."}
  ]'::jsonb,
  'not to + 동사원형'
from te_paragraphs p where p.passage_id = 'b000000c-0000-0000-0000-00000000000c' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Economists call the value of the option you gave up the opportunity cost.',
  '[
    {"en":"Economists call","ko":"경제학자들은 부른다"},
    {"en":"the value","ko":"가치를"},
    {"en":"of the option","ko":"선택지의"},
    {"en":"you gave up","ko":"당신이 포기한"},
    {"en":"the opportunity cost.","ko":"기회비용이라고."}
  ]'::jsonb,
  '5형식: call + O + 명사 (~을 ~라 부르다)'
from te_paragraphs p where p.passage_id = 'b000000c-0000-0000-0000-00000000000c' and p.ord = 1;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Big decisions become clearer once we ask what we are giving up, not only what we are getting.',
  '[
    {"en":"Big decisions","ko":"큰 결정들은"},
    {"en":"become clearer","ko":"더 명확해진다"},
    {"en":"once we ask","ko":"우리가 묻기 시작하면"},
    {"en":"what we are giving up,","ko":"우리가 포기하는 것을,"},
    {"en":"not only what we are getting.","ko":"얻는 것뿐만 아니라."}
  ]'::jsonb,
  'once 부사절, what 명사절 두 번'
from te_paragraphs p where p.passage_id = 'b000000c-0000-0000-0000-00000000000c' and p.ord = 2;

-- b000000d The Most Wanted Thing Online
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Advertisers are the customers, and the user is the product whose attention is sold.',
  '[
    {"en":"Advertisers","ko":"광고주들이"},
    {"en":"are the customers,","ko":"고객이다,"},
    {"en":"and the user","ko":"그리고 사용자는"},
    {"en":"is the product","ko":"상품이다"},
    {"en":"whose attention","ko":"그의 관심이"},
    {"en":"is sold.","ko":"판매되는."}
  ]'::jsonb,
  '소유격 관계대명사 whose'
from te_paragraphs p where p.passage_id = 'b000000d-0000-0000-0000-00000000000d' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'There are only so many hours in a day, and many apps fight for the same ones.',
  '[
    {"en":"There are","ko":"~있다"},
    {"en":"only so many hours","ko":"오직 몇 시간만"},
    {"en":"in a day,","ko":"하루에,"},
    {"en":"and many apps fight","ko":"그리고 많은 앱들이 다툰다"},
    {"en":"for the same ones.","ko":"같은 시간을 두고."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'b000000d-0000-0000-0000-00000000000d' and p.ord = 1;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Endless scrolling is not free time; it is paid time, paid in something we cannot earn back.',
  '[
    {"en":"Endless scrolling","ko":"끝없는 스크롤은"},
    {"en":"is not free time;","ko":"자유 시간이 아니다;"},
    {"en":"it is paid time,","ko":"그것은 지불된 시간이다,"},
    {"en":"paid in something","ko":"무언가로 지불된"},
    {"en":"we cannot earn back.","ko":"우리가 되찾을 수 없는."}
  ]'::jsonb,
  '과거분사구 후치수식, 관계대명사 생략'
from te_paragraphs p where p.passage_id = 'b000000d-0000-0000-0000-00000000000d' and p.ord = 2;

-- b000000e Animals That Pretend
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'A harmless hoverfly wears the same yellow and black stripes as a stinging wasp.',
  '[
    {"en":"A harmless hoverfly","ko":"해롭지 않은 꽃등에는"},
    {"en":"wears","ko":"입는다"},
    {"en":"the same yellow and black stripes","ko":"같은 노란색과 검은색 줄무늬를"},
    {"en":"as a stinging wasp.","ko":"쏘는 말벌과 같이."}
  ]'::jsonb,
  'the same ~ as: ~와 같은'
from te_paragraphs p where p.passage_id = 'b000000e-0000-0000-0000-00000000000e' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'A stick insect looks like a twig, a leaf insect like a torn leaf.',
  '[
    {"en":"A stick insect","ko":"대벌레는"},
    {"en":"looks like","ko":"~처럼 보인다"},
    {"en":"a twig,","ko":"나뭇가지처럼,"},
    {"en":"a leaf insect","ko":"잎벌레는"},
    {"en":"like a torn leaf.","ko":"찢어진 잎처럼 (보인다)."}
  ]'::jsonb,
  '뒤 절에서 looks 생략 (병렬)'
from te_paragraphs p where p.passage_id = 'b000000e-0000-0000-0000-00000000000e' and p.ord = 1;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Borrowing the appearance of something dangerous, or of nothing at all, often works just as well.',
  '[
    {"en":"Borrowing","ko":"빌리는 것이"},
    {"en":"the appearance","ko":"외모를"},
    {"en":"of something dangerous,","ko":"위험한 무언가의,"},
    {"en":"or of nothing at all,","ko":"또는 아무것도 아닌 것의,"},
    {"en":"often works","ko":"종종 효과가 있다"},
    {"en":"just as well.","ko":"똑같이."}
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
    {"en":"made every trip","ko":"모든 이동을 만들었다"},
    {"en":"long.","ko":"길게."}
  ]'::jsonb,
  '과거분사구 후치수식, 5형식'
from te_paragraphs p where p.passage_id = 'b000000f-0000-0000-0000-00000000000f' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'A mixed-use street puts shops on the ground floor, offices above, and apartments on top.',
  '[
    {"en":"A mixed-use street","ko":"복합용도 거리는"},
    {"en":"puts","ko":"배치한다"},
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
    {"en":"Streets fill","ko":"거리는 차게 된다"},
    {"en":"with people","ko":"사람들로"},
    {"en":"throughout the day,","ko":"하루 종일,"},
    {"en":"which makes them","ko":"그것이 거리를 만든다"},
    {"en":"safer and livelier","ko":"더 안전하고 더 활기차게"},
    {"en":"in ways","ko":"방식으로"},
    {"en":"that empty zoned areas","ko":"빈 구역들은"},
    {"en":"never become.","ko":"결코 되지 못하는."}
  ]'::jsonb,
  '계속적 용법 which, 관계대명사 that (ways 수식)'
from te_paragraphs p where p.passage_id = 'b000000f-0000-0000-0000-00000000000f' and p.ord = 2;

-- b0000010 A Sad Song in Every Language
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'When sad music is played slowly with low notes, listeners around the world tend to call it sad.',
  '[
    {"en":"When sad music","ko":"슬픈 음악이"},
    {"en":"is played slowly","ko":"느리게 연주될 때"},
    {"en":"with low notes,","ko":"낮은 음으로,"},
    {"en":"listeners around the world","ko":"세계 곳곳의 청취자들은"},
    {"en":"tend to call it","ko":"그것을 ~라 부르는 경향이 있다"},
    {"en":"sad.","ko":"슬프다고."}
  ]'::jsonb,
  '5형식: call + O + 형용사'
from te_paragraphs p where p.passage_id = 'b0000010-0000-0000-0000-000000000010' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Slow tempos resemble a sleeping heartbeat; low pitches resemble a quiet voice.',
  '[
    {"en":"Slow tempos","ko":"느린 박자는"},
    {"en":"resemble","ko":"닮았다"},
    {"en":"a sleeping heartbeat;","ko":"잠자는 심장 박동을;"},
    {"en":"low pitches","ko":"낮은 음높이는"},
    {"en":"resemble","ko":"닮았다"},
    {"en":"a quiet voice.","ko":"조용한 목소리를."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'b0000010-0000-0000-0000-000000000010' and p.ord = 1;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Music varies enormously across cultures, but a small core seems to be shared.',
  '[
    {"en":"Music varies","ko":"음악은 다양하다"},
    {"en":"enormously","ko":"엄청나게"},
    {"en":"across cultures,","ko":"문화에 따라,"},
    {"en":"but a small core","ko":"하지만 작은 핵심은"},
    {"en":"seems to be shared.","ko":"공유되는 것으로 보인다."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'b0000010-0000-0000-0000-000000000010' and p.ord = 2;

-- b0000011 How a Shared Language Spread
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'No one wanted to learn three new languages just to sell goods.',
  '[
    {"en":"No one wanted","ko":"아무도 원치 않았다"},
    {"en":"to learn","ko":"배우는 것을"},
    {"en":"three new languages","ko":"세 개의 새 언어를"},
    {"en":"just to sell goods.","ko":"단지 물건을 팔기 위해."}
  ]'::jsonb,
  'just to ~: 단지 ~하기 위해 (목적 부사)'
from te_paragraphs p where p.passage_id = 'b0000011-0000-0000-0000-000000000011' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'It is built for usefulness, not for poetry.',
  '[
    {"en":"It is built","ko":"그것은 만들어졌다"},
    {"en":"for usefulness,","ko":"유용함을 위해,"},
    {"en":"not for poetry.","ko":"시를 위해서가 아니라."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'b0000011-0000-0000-0000-000000000011' and p.ord = 1;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Sometimes, surprisingly, it grows roots and becomes a native language for the next generation.',
  '[
    {"en":"Sometimes, surprisingly,","ko":"때로, 놀랍게도,"},
    {"en":"it grows roots","ko":"그것은 뿌리를 내린다"},
    {"en":"and becomes","ko":"그리고 ~이 된다"},
    {"en":"a native language","ko":"모국어가"},
    {"en":"for the next generation.","ko":"다음 세대를 위한."}
  ]'::jsonb,
  '동사 두 개 병렬 (grows / becomes)'
from te_paragraphs p where p.passage_id = 'b0000011-0000-0000-0000-000000000011' and p.ord = 2;

-- b0000012 Why Tomorrow Feels Less Real
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'The future second candy feels less real than the candy in front of them.',
  '[
    {"en":"The future second candy","ko":"미래의 두 번째 사탕은"},
    {"en":"feels less real","ko":"덜 현실적으로 느껴진다"},
    {"en":"than the candy","ko":"그 사탕보다"},
    {"en":"in front of them.","ko":"그들 앞에 있는."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'b0000012-0000-0000-0000-000000000012' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'They skip exercise that pays off next year for comfort tonight.',
  '[
    {"en":"They skip","ko":"그들은 건너뛴다"},
    {"en":"exercise","ko":"운동을"},
    {"en":"that pays off","ko":"이득이 되는"},
    {"en":"next year","ko":"내년에"},
    {"en":"for comfort tonight.","ko":"오늘 밤의 편안함을 위해."}
  ]'::jsonb,
  '관계대명사 that (exercise 수식)'
from te_paragraphs p where p.passage_id = 'b0000012-0000-0000-0000-000000000012' and p.ord = 1;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'The future self becomes a person worth keeping a promise to.',
  '[
    {"en":"The future self","ko":"미래의 자아는"},
    {"en":"becomes","ko":"~이 된다"},
    {"en":"a person","ko":"한 사람이"},
    {"en":"worth keeping","ko":"지킬 가치가 있는"},
    {"en":"a promise to.","ko":"약속을."}
  ]'::jsonb,
  'worth + 동명사 (~할 가치가 있는)'
from te_paragraphs p where p.passage_id = 'b0000012-0000-0000-0000-000000000012' and p.ord = 2;

-- b0000013 Two Prisoners and a Choice
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'If one stays silent and one betrays, the betrayer walks free and the silent one suffers most.',
  '[
    {"en":"If one stays silent","ko":"만약 한 명이 침묵하고"},
    {"en":"and one betrays,","ko":"한 명이 배신하면,"},
    {"en":"the betrayer","ko":"배신자는"},
    {"en":"walks free","ko":"풀려난다"},
    {"en":"and the silent one","ko":"그리고 침묵한 자는"},
    {"en":"suffers most.","ko":"가장 큰 고통을 받는다."}
  ]'::jsonb,
  'If 조건절'
from te_paragraphs p where p.passage_id = 'b0000013-0000-0000-0000-000000000013' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'If both follow that logic, both lose.',
  '[
    {"en":"If both follow","ko":"만약 둘 다 따른다면"},
    {"en":"that logic,","ko":"그 논리를,"},
    {"en":"both lose.","ko":"둘 다 진다."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'b0000013-0000-0000-0000-000000000013' and p.ord = 1;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Countries deciding on pollution, neighbors deciding on noise, students deciding on group projects all face a version of the same trap.',
  '[
    {"en":"Countries","ko":"나라들이"},
    {"en":"deciding on pollution,","ko":"공해에 대해 결정하는,"},
    {"en":"neighbors","ko":"이웃들이"},
    {"en":"deciding on noise,","ko":"소음에 대해 결정하는,"},
    {"en":"students","ko":"학생들이"},
    {"en":"deciding on group projects","ko":"조별 과제에 대해 결정하는"},
    {"en":"all face","ko":"모두 마주한다"},
    {"en":"a version of the same trap.","ko":"같은 함정의 한 버전을."}
  ]'::jsonb,
  '현재분사구 후치수식 세 번'
from te_paragraphs p where p.passage_id = 'b0000013-0000-0000-0000-000000000013' and p.ord = 2;

-- b0000014 The Missing Mass of the Universe
insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'The stars spin too fast for the visible matter alone to hold them together.',
  '[
    {"en":"The stars spin","ko":"별들은 회전한다"},
    {"en":"too fast","ko":"너무 빨라서"},
    {"en":"for the visible matter alone","ko":"보이는 물질만으로는"},
    {"en":"to hold them together.","ko":"그것들을 묶어둘 수 없다."}
  ]'::jsonb,
  'too ~ for X to ~: X가 ~할 수 없을 만큼 ~'
from te_paragraphs p where p.passage_id = 'b0000014-0000-0000-0000-000000000014' and p.ord = 0;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'It does not give off light, and it ignores almost everything except gravity.',
  '[
    {"en":"It does not give off","ko":"그것은 발산하지 않는다"},
    {"en":"light,","ko":"빛을,"},
    {"en":"and it ignores","ko":"그리고 무시한다"},
    {"en":"almost everything","ko":"거의 모든 것을"},
    {"en":"except gravity.","ko":"중력만 제외하고."}
  ]'::jsonb,
  null
from te_paragraphs p where p.passage_id = 'b0000014-0000-0000-0000-000000000014' and p.ord = 1;

insert into te_chunk_sentences (paragraph_id, ord, full_sentence, chunks, note)
select p.id, 0,
  'Most of what holds the cosmos together is hidden in plain sight.',
  '[
    {"en":"Most","ko":"대부분이"},
    {"en":"of what holds","ko":"붙잡아두는 것의"},
    {"en":"the cosmos together","ko":"우주를 함께"},
    {"en":"is hidden","ko":"숨겨져 있다"},
    {"en":"in plain sight.","ko":"눈에 잘 띄는 곳에."}
  ]'::jsonb,
  'what 명사절 (of의 목적어)'
from te_paragraphs p where p.passage_id = 'b0000014-0000-0000-0000-000000000014' and p.ord = 2;
