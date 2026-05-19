-- =====================================================================
-- Sample questions for Phase 2 testing
-- 30 questions: main_idea x10, blank x10, vocabulary x10
-- Based on the 3 seed passages (UUIDs from 0002_sample_passages.sql).
-- =====================================================================

-- Use fixed UUIDs so the seeds are idempotent-ish for testing.

-- ===== MAIN IDEA (10) =================================================
insert into te_questions (id, passage_id, topic, prompt, choices, correct_answer, explanation, difficulty, grade_level, org_id)
values
  -- Passage 1: The Hidden Cost of Free Choice
  ('a0000001-0000-0000-0000-000000000001', '11111111-1111-1111-1111-111111111111', 'main_idea',
   'What is the main idea of the passage about jam choices?',
   '[
     {"key":"1","text":"Stores should always offer more product choices to attract customers."},
     {"key":"2","text":"Too many options can lower happiness and reduce decisions."},
     {"key":"3","text":"Shoppers always prefer larger selections in stores."},
     {"key":"4","text":"Jam quality matters more than the number of choices."}
   ]',
   '2', '핵심: 선택지가 많아질수록 결정 비용이 늘고 만족이 줄어든다는 choice overload 주제.', 'mid', 11, null),

  ('a0000001-0000-0000-0000-000000000002', '11111111-1111-1111-1111-111111111111', 'main_idea',
   'What does the author suggest about freedom of choice?',
   '[
     {"key":"1","text":"It is valuable only when it serves a goal."},
     {"key":"2","text":"It always increases personal happiness."},
     {"key":"3","text":"It is the most important feature of modern life."},
     {"key":"4","text":"It should be unlimited for everyone."}
   ]',
   '1', '마지막 단락 핵심: choice for its own sake can paralyze us.', 'mid', 11, null),

  ('a0000001-0000-0000-0000-000000000003', '11111111-1111-1111-1111-111111111111', 'main_idea',
   'Which title best fits this passage?',
   '[
     {"key":"1","text":"The Joy of Endless Options"},
     {"key":"2","text":"When Too Much Choice Hurts Us"},
     {"key":"3","text":"The Power of Shopping Malls"},
     {"key":"4","text":"How to Sell More Jam"}
   ]',
   '2', '주제는 "선택의 숨겨진 비용". 제목도 같은 방향.', 'mid', 11, null),

  -- Passage 2: Why Forests Quietly Talk
  ('a0000002-0000-0000-0000-000000000001', '22222222-2222-2222-2222-222222222222', 'main_idea',
   'What is the main message of this passage?',
   '[
     {"key":"1","text":"Trees compete fiercely for sunlight in every forest."},
     {"key":"2","text":"Forests are interconnected communities, not isolated trees."},
     {"key":"3","text":"Fungal threads are the most dangerous part of forests."},
     {"key":"4","text":"Old trees should be removed to make room for new ones."}
   ]',
   '2', '전체 단락의 흐름: 숲은 경쟁의 장이 아니라 연결된 공동체라는 발견.', 'mid', 10, null),

  ('a0000002-0000-0000-0000-000000000002', '22222222-2222-2222-2222-222222222222', 'main_idea',
   'What conclusion does the passage draw about protecting biodiversity?',
   '[
     {"key":"1","text":"We should focus only on visible plants."},
     {"key":"2","text":"We must also protect invisible underground connections."},
     {"key":"3","text":"Cutting old trees has no impact on the ecosystem."},
     {"key":"4","text":"Forest networks are too small to matter."}
   ]',
   '2', '결론 단락: protecting biodiversity means protecting the invisible connections.', 'mid', 10, null),

  ('a0000002-0000-0000-0000-000000000003', '22222222-2222-2222-2222-222222222222', 'main_idea',
   'Which title best captures the passage?',
   '[
     {"key":"1","text":"The Battle of the Trees"},
     {"key":"2","text":"How Trees Quietly Help Each Other"},
     {"key":"3","text":"The Decline of Modern Forests"},
     {"key":"4","text":"Fungi: The Enemy of Trees"}
   ]',
   '2', '주제는 트리들 사이의 협력적 네트워크.', 'mid', 10, null),

  -- Passage 3: Why Mistakes Make Better Learners
  ('a0000003-0000-0000-0000-000000000001', '33333333-3333-3333-3333-333333333333', 'main_idea',
   'What is the main argument of the passage?',
   '[
     {"key":"1","text":"Avoiding mistakes is the fastest path to learning."},
     {"key":"2","text":"Re-reading is the most effective study method."},
     {"key":"3","text":"Mistakes followed by feedback strengthen memory."},
     {"key":"4","text":"Difficulty in learning should always be reduced."}
   ]',
   '3', '핵심: corrected mistake is remembered far longer than easy answers.', 'low', 9, null),

  ('a0000003-0000-0000-0000-000000000002', '33333333-3333-3333-3333-333333333333', 'main_idea',
   'According to the passage, why is re-reading a weak study habit?',
   '[
     {"key":"1","text":"It takes too much time."},
     {"key":"2","text":"The brain is not surprised by anything during re-reading."},
     {"key":"3","text":"It cannot be done with notes."},
     {"key":"4","text":"It requires too much effort."}
   ]',
   '2', '두 번째 단락: 뇌가 놀라지 않아서 기억 형성이 약하다.', 'low', 9, null),

  ('a0000003-0000-0000-0000-000000000003', '33333333-3333-3333-3333-333333333333', 'main_idea',
   'How do the best students treat wrong answers?',
   '[
     {"key":"1","text":"As something embarrassing to avoid."},
     {"key":"2","text":"As a tool to find their weakest question type."},
     {"key":"3","text":"As proof they should study less."},
     {"key":"4","text":"As random events that do not matter."}
   ]',
   '2', '마지막 단락: as a tool, not a punishment, to target weak types.', 'low', 9, null),

  ('a0000003-0000-0000-0000-000000000004', '33333333-3333-3333-3333-333333333333', 'main_idea',
   'Which sentence best summarizes the passage?',
   '[
     {"key":"1","text":"Comfort leads to growth, while difficulty harms it."},
     {"key":"2","text":"Well-designed difficulty is a friend of growth."},
     {"key":"3","text":"Successful learners never feel surprised."},
     {"key":"4","text":"Students should memorize answers without testing themselves."}
   ]',
   '2', '마지막 문장 그대로: well-designed difficulty is its friend.', 'low', 9, null);

-- ===== BLANK (10) ====================================================
insert into te_questions (id, passage_id, topic, prompt, choices, correct_answer, explanation, difficulty, grade_level, org_id)
values
  ('b0000001-0000-0000-0000-000000000001', '11111111-1111-1111-1111-111111111111', 'blank',
   'Fill in the blank: As the mental cost of choosing grows, the joy of finally choosing ____.',
   '[
     {"key":"1","text":"shrinks"},
     {"key":"2","text":"grows"},
     {"key":"3","text":"appears"},
     {"key":"4","text":"remains"}
   ]',
   '1', '본문 그대로: the joy of finally choosing shrinks.', 'mid', 11, null),

  ('b0000001-0000-0000-0000-000000000002', '11111111-1111-1111-1111-111111111111', 'blank',
   'Fill in the blank: Restricting one''s options is sometimes the most powerful way to make ____ progress.',
   '[
     {"key":"1","text":"random"},
     {"key":"2","text":"consistent"},
     {"key":"3","text":"impossible"},
     {"key":"4","text":"slow"}
   ]',
   '2', '본문: consistent progress.', 'mid', 11, null),

  ('b0000001-0000-0000-0000-000000000003', '11111111-1111-1111-1111-111111111111', 'blank',
   'Fill in the blank: Choice for its own sake can ____ us.',
   '[
     {"key":"1","text":"motivate"},
     {"key":"2","text":"reward"},
     {"key":"3","text":"paralyze"},
     {"key":"4","text":"protect"}
   ]',
   '3', '본문: choice for its own sake can paralyze us.', 'mid', 11, null),

  ('b0000002-0000-0000-0000-000000000001', '22222222-2222-2222-2222-222222222222', 'blank',
   'Fill in the blank: Beneath the soil of a forest lies an enormous network of ____ threads.',
   '[
     {"key":"1","text":"copper"},
     {"key":"2","text":"plastic"},
     {"key":"3","text":"fungal"},
     {"key":"4","text":"electric"}
   ]',
   '3', '본문: network of fungal threads (wood wide web).', 'mid', 10, null),

  ('b0000002-0000-0000-0000-000000000002', '22222222-2222-2222-2222-222222222222', 'blank',
   'Fill in the blank: Trees attacked by insects can send ____ warnings to their neighbors.',
   '[
     {"key":"1","text":"chemical"},
     {"key":"2","text":"radio"},
     {"key":"3","text":"verbal"},
     {"key":"4","text":"emotional"}
   ]',
   '1', '본문: chemical warnings.', 'mid', 10, null),

  ('b0000002-0000-0000-0000-000000000003', '22222222-2222-2222-2222-222222222222', 'blank',
   'Fill in the blank: The forest behaves less like a battlefield and more like a ____.',
   '[
     {"key":"1","text":"market"},
     {"key":"2","text":"community"},
     {"key":"3","text":"machine"},
     {"key":"4","text":"prison"}
   ]',
   '2', '본문: more like a community.', 'mid', 10, null),

  ('b0000003-0000-0000-0000-000000000001', '33333333-3333-3333-3333-333333333333', 'blank',
   'Fill in the blank: When a learner sees a corrected mistake, the brain responds with a strong burst of ____.',
   '[
     {"key":"1","text":"attention"},
     {"key":"2","text":"boredom"},
     {"key":"3","text":"sleep"},
     {"key":"4","text":"sadness"}
   ]',
   '1', '본문: a strong burst of attention.', 'low', 9, null),

  ('b0000003-0000-0000-0000-000000000002', '33333333-3333-3333-3333-333333333333', 'blank',
   'Fill in the blank: Quiz-style practice trains memory because it forces the brain to predict, fail, and then ____ its understanding.',
   '[
     {"key":"1","text":"erase"},
     {"key":"2","text":"hide"},
     {"key":"3","text":"update"},
     {"key":"4","text":"repeat"}
   ]',
   '3', '본문: predict, fail, and then update its understanding.', 'low', 9, null),

  ('b0000003-0000-0000-0000-000000000003', '33333333-3333-3333-3333-333333333333', 'blank',
   'Fill in the blank: Comfort is the enemy of growth; well-designed ____ is its friend.',
   '[
     {"key":"1","text":"comfort"},
     {"key":"2","text":"shortcut"},
     {"key":"3","text":"luck"},
     {"key":"4","text":"difficulty"}
   ]',
   '4', '본문 마지막 문장: well-designed difficulty is its friend.', 'low', 9, null),

  ('b0000003-0000-0000-0000-000000000004', '33333333-3333-3333-3333-333333333333', 'blank',
   'Fill in the blank: The best students treat wrong answers as a ____, not a punishment.',
   '[
     {"key":"1","text":"tool"},
     {"key":"2","text":"shame"},
     {"key":"3","text":"joke"},
     {"key":"4","text":"reward"}
   ]',
   '1', '본문: as a tool, not a punishment.', 'low', 9, null);

-- ===== VOCABULARY (10) ===============================================
insert into te_questions (id, passage_id, topic, prompt, choices, correct_answer, explanation, difficulty, grade_level, org_id)
values
  ('c0000001-0000-0000-0000-000000000001', '11111111-1111-1111-1111-111111111111', 'vocabulary',
   'In the passage, "choice overload" most nearly means:',
   '[
     {"key":"1","text":"the feeling of being overwhelmed by too many options"},
     {"key":"2","text":"the joy of having unlimited choices"},
     {"key":"3","text":"a marketing technique used in supermarkets"},
     {"key":"4","text":"a way to reduce shopping time"}
   ]',
   '1', '맥락에서 too many options → overwhelmed 의미.', 'mid', 11, null),

  ('c0000001-0000-0000-0000-000000000002', '11111111-1111-1111-1111-111111111111', 'vocabulary',
   'In the passage, "paralyze" most nearly means:',
   '[
     {"key":"1","text":"strengthen and encourage"},
     {"key":"2","text":"make unable to act or decide"},
     {"key":"3","text":"physically injure someone"},
     {"key":"4","text":"protect from danger"}
   ]',
   '2', '맥락: choice for its own sake → 결정 못 하게 만든다.', 'mid', 11, null),

  ('c0000001-0000-0000-0000-000000000003', '11111111-1111-1111-1111-111111111111', 'vocabulary',
   'In the passage, "restrict" most nearly means:',
   '[
     {"key":"1","text":"to increase the amount"},
     {"key":"2","text":"to limit or reduce"},
     {"key":"3","text":"to celebrate openly"},
     {"key":"4","text":"to translate to another language"}
   ]',
   '2', 'restricting one''s options → 선택을 줄이다 의미.', 'mid', 11, null),

  ('c0000002-0000-0000-0000-000000000001', '22222222-2222-2222-2222-222222222222', 'vocabulary',
   'In the passage, "seedling" most nearly means:',
   '[
     {"key":"1","text":"a small young plant"},
     {"key":"2","text":"a dead tree trunk"},
     {"key":"3","text":"a piece of soil"},
     {"key":"4","text":"a forest manager"}
   ]',
   '1', '맥락: smaller seedling struggling in the shade → 어린 나무.', 'mid', 10, null),

  ('c0000002-0000-0000-0000-000000000002', '22222222-2222-2222-2222-222222222222', 'vocabulary',
   'In the passage, "disconnect" most nearly means:',
   '[
     {"key":"1","text":"to join more closely"},
     {"key":"2","text":"to separate from a connection"},
     {"key":"3","text":"to plant new seeds"},
     {"key":"4","text":"to water the soil"}
   ]',
   '2', '맥락: removing a tree can disconnect dozens of others from a shared system.', 'mid', 10, null),

  ('c0000002-0000-0000-0000-000000000003', '22222222-2222-2222-2222-222222222222', 'vocabulary',
   'In the passage, "biodiversity" most nearly means:',
   '[
     {"key":"1","text":"the variety of living things in an ecosystem"},
     {"key":"2","text":"a single dominant species"},
     {"key":"3","text":"a type of pollution"},
     {"key":"4","text":"the size of a forest"}
   ]',
   '1', '환경 맥락에서 다양한 생물의 공존을 뜻함.', 'mid', 10, null),

  ('c0000003-0000-0000-0000-000000000001', '33333333-3333-3333-3333-333333333333', 'vocabulary',
   'In the passage, "burst" most nearly means:',
   '[
     {"key":"1","text":"a slow and gradual change"},
     {"key":"2","text":"a sudden and strong release"},
     {"key":"3","text":"a long-lasting silence"},
     {"key":"4","text":"a quiet whisper"}
   ]',
   '2', '맥락: a strong burst of attention → 갑작스럽고 강한 반응.', 'low', 9, null),

  ('c0000003-0000-0000-0000-000000000002', '33333333-3333-3333-3333-333333333333', 'vocabulary',
   'In the passage, "predict" most nearly means:',
   '[
     {"key":"1","text":"to guess what will happen before it happens"},
     {"key":"2","text":"to forget the answer immediately"},
     {"key":"3","text":"to copy what another person said"},
     {"key":"4","text":"to repeat the same action"}
   ]',
   '1', '맥락: brain predicts, fails, then updates. 예측 의미.', 'low', 9, null),

  ('c0000003-0000-0000-0000-000000000003', '33333333-3333-3333-3333-333333333333', 'vocabulary',
   'In the passage, "punishment" most nearly means:',
   '[
     {"key":"1","text":"a reward for doing well"},
     {"key":"2","text":"something unpleasant given for wrongdoing"},
     {"key":"3","text":"a friendly conversation"},
     {"key":"4","text":"a small gift"}
   ]',
   '2', '맥락: as a tool, not a punishment → 처벌 의미.', 'low', 9, null),

  ('c0000003-0000-0000-0000-000000000004', '33333333-3333-3333-3333-333333333333', 'vocabulary',
   'In the passage, "comfort" most nearly means:',
   '[
     {"key":"1","text":"a state of ease and lack of challenge"},
     {"key":"2","text":"extreme physical pain"},
     {"key":"3","text":"a difficult test"},
     {"key":"4","text":"a loud noise"}
   ]',
   '1', '맥락: comfort is the enemy of growth → 편안함, 안주.', 'low', 9, null);
