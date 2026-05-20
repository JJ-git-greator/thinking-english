-- =====================================================================
-- 콘텐츠 배치 1: 하(low) 난이도 15개 지문 + 단락 + 문제
-- 100% 창작 (저작권 안전). 학년: 중3~고1 수준.
-- 주제: 수면·환경·심리·언어·기술·역사·예술·운동·사회 다양화.
-- =====================================================================

-- ===== 지문 15개 ======================================================
insert into te_passages (id, title, body, source, grade_level, difficulty, org_id) values
  ('a0000001-0000-0000-0000-000000000001', 'How Sleep Resets the Brain', 'Scientists once thought sleep was simply a time when the body rested. New research suggests it is actively cleaning the brain.', 'thinking-english seed', 9, 'low', null),
  ('a0000002-0000-0000-0000-000000000002', 'The Quiet Power of Walking', 'Walking is often called the simplest exercise. But its impact on thinking and mood goes far beyond physical health.', 'thinking-english seed', 9, 'low', null),
  ('a0000003-0000-0000-0000-000000000003', 'Why We Remember Stories Better Than Facts', 'Try to recall a fact you read last week. Now try to recall a story. The story comes back more easily for a reason.', 'thinking-english seed', 9, 'low', null),
  ('a0000004-0000-0000-0000-000000000004', 'Bees and the Hidden Map of Flowers', 'A bee leaving its hive looks lost. In fact, it follows a precise map that has been built into its tiny body for millions of years.', 'thinking-english seed', 9, 'low', null),
  ('a0000005-0000-0000-0000-000000000005', 'The First Smartphone Was Not What You Think', 'When people hear "first smartphone," they imagine a sleek black rectangle. The real first one looked nothing like that.', 'thinking-english seed', 10, 'low', null),
  ('a0000006-0000-0000-0000-000000000006', 'Why Music Helps Us Focus', 'A library is silent for a reason, but many students study with headphones on. Both habits can work, and science explains why.', 'thinking-english seed', 9, 'low', null),
  ('a0000007-0000-0000-0000-000000000007', 'The Lost Language of Whistles', 'On a small Spanish island, people once spoke to each other across deep valleys without ever raising their voices.', 'thinking-english seed', 10, 'low', null),
  ('a0000008-0000-0000-0000-000000000008', 'The Surprising Job of a Coral Reef', 'Coral reefs look like underwater gardens, but they do far more than decorate the sea floor.', 'thinking-english seed', 9, 'low', null),
  ('a0000009-0000-0000-0000-000000000009', 'How a Compliment Changes the Brain', 'A kind word feels good. New brain studies show that it also lights up the same area as a real reward.', 'thinking-english seed', 9, 'low', null),
  ('a000000a-0000-0000-0000-00000000000a', 'Why Cities Are Hotter Than Forests', 'Step into a city street on a summer afternoon and you will feel a heat that you do not feel under nearby trees.', 'thinking-english seed', 10, 'low', null),
  ('a000000b-0000-0000-0000-00000000000b', 'The Oldest Toy Still Played With', 'Long before video games or plastic blocks, a simple round object kept children of every culture busy.', 'thinking-english seed', 9, 'low', null),
  ('a000000c-0000-0000-0000-00000000000c', 'Why Some Foods Taste Better the Next Day', 'Open the fridge the morning after a stew, and the smell hits you stronger than yesterday. There is a reason.', 'thinking-english seed', 9, 'low', null),
  ('a000000d-0000-0000-0000-00000000000d', 'The Math Behind a Soccer Ball', 'A soccer ball looks like a simple round shape, but its surface follows a quiet rule that mathematicians have studied for centuries.', 'thinking-english seed', 10, 'low', null),
  ('a000000e-0000-0000-0000-00000000000e', 'Reading Slowly to Read More', 'It sounds wrong, but slower reading often leads to more learning. Speed reading has limits.', 'thinking-english seed', 10, 'low', null),
  ('a000000f-0000-0000-0000-00000000000f', 'How Animals Predict the Weather', 'Long before there were forecasts, farmers watched birds and cows to know what the sky would do.', 'thinking-english seed', 9, 'low', null);

-- ===== 단락 ===========================================================
insert into te_paragraphs (passage_id, ord, body) values
  ('a0000001-0000-0000-0000-000000000001', 0, 'During deep sleep, the brain rinses itself with a special fluid that washes away the toxic proteins built up during the day. This cleaning process is most active at night, when the body is still.'),
  ('a0000001-0000-0000-0000-000000000001', 1, 'Without this nightly washing, the unwanted proteins begin to stack up. Over time, they can damage the cells that store memories and slow down thinking.'),
  ('a0000001-0000-0000-0000-000000000001', 2, 'This finding suggests that sleeping enough is not a sign of laziness. It is one of the most active things the brain does, and skipping it has real costs.'),

  ('a0000002-0000-0000-0000-000000000002', 0, 'A short walk seems almost too easy to be useful. Yet researchers have found that thirty minutes of walking can lift mood as much as some medicines for sadness.'),
  ('a0000002-0000-0000-0000-000000000002', 1, 'Walking also changes how we think. Many writers and scientists report that their best ideas arrive while they are moving, not while they are sitting at a desk.'),
  ('a0000002-0000-0000-0000-000000000002', 2, 'The lesson is simple. When a problem feels stuck, the answer may not be more thinking but a quiet walk outside.'),

  ('a0000003-0000-0000-0000-000000000003', 0, 'Our brains were built long before there were books or tests. They were built around campfires, where people shared what happened during the day. Stories were how knowledge moved between people.'),
  ('a0000003-0000-0000-0000-000000000003', 1, 'A list of facts is hard to hold. A story has characters, problems, and endings, and our minds catch onto these shapes naturally. The same fact wrapped in a story is remembered longer.'),
  ('a0000003-0000-0000-0000-000000000003', 2, 'This is why a good teacher does not only give information. The teacher tells the information as a story, so the lesson stays.'),

  ('a0000004-0000-0000-0000-000000000004', 0, 'A bee can fly two kilometers from its home and return without getting lost. To do this, it remembers the angle of the sun and adjusts as the sun moves across the sky.'),
  ('a0000004-0000-0000-0000-000000000004', 1, 'When a bee finds a new flower, it does a small dance back at the hive. The shape of the dance tells the other bees how far the flower is and in which direction.'),
  ('a0000004-0000-0000-0000-000000000004', 2, 'A creature smaller than a coin carries a map, a clock, and a language inside it. Nature often hides large skills in small bodies.'),

  ('a0000005-0000-0000-0000-000000000005', 0, 'The first device that combined a phone with a small computer came out in 1994. It was the size of a brick, and it weighed almost half a kilogram.'),
  ('a0000005-0000-0000-0000-000000000005', 1, 'The screen was green and could only show a few lines of text. Yet it could send email, check the calendar, and play simple games. It cost as much as a small car.'),
  ('a0000005-0000-0000-0000-000000000005', 2, 'Most people in 1994 did not see why they would need such a thing. Thirty years later, almost everyone carries something similar in their pocket.'),

  ('a0000006-0000-0000-0000-000000000006', 0, 'Some students find total silence helpful for difficult reading. Other students cannot start their work without music. Both groups are not wrong; they need different things.'),
  ('a0000006-0000-0000-0000-000000000006', 1, 'For tasks that need clear thinking, like math or new reading, silence usually wins. For tasks that are familiar or repetitive, gentle music helps the mind stay alert.'),
  ('a0000006-0000-0000-0000-000000000006', 2, 'The key is to match the sound to the task. Loud lyrics during difficult reading often steal focus, while soft instrumental music can carry repeating tasks forward.'),

  ('a0000007-0000-0000-0000-000000000007', 0, 'On the island of La Gomera, the valleys are too deep to shout across, so people invented a way to send long sentences by whistling. Each word has its own whistled shape.'),
  ('a0000007-0000-0000-0000-000000000007', 1, 'A skilled whistler can be understood from two kilometers away. The language is real, with grammar and meaning, not just signals.'),
  ('a0000007-0000-0000-0000-000000000007', 2, 'For a time, the young people forgot the skill. Now it is taught in school again, because losing a language means losing a way of seeing the world.'),

  ('a0000008-0000-0000-0000-000000000008', 0, 'Coral reefs cover less than one percent of the ocean floor, but they are home to about a quarter of all sea creatures. Without them, much of ocean life would have nowhere to live.'),
  ('a0000008-0000-0000-0000-000000000008', 1, 'They also break the energy of large waves before the waves reach the coast. Villages near healthy reefs suffer less damage from storms than villages near empty water.'),
  ('a0000008-0000-0000-0000-000000000008', 2, 'A reef is not just beautiful. It is a small city, a shield, and a quiet engine of the ocean. When it dies, much more dies with it.'),

  ('a0000009-0000-0000-0000-000000000009', 0, 'When a person hears a sincere compliment, scans of the brain show the same areas lighting up as when the person receives a small gift of money.'),
  ('a0000009-0000-0000-0000-000000000009', 1, 'This means kind words are not "just words." For the brain, they are a kind of reward, and they leave a memory that lasts.'),
  ('a0000009-0000-0000-0000-000000000009', 2, 'Knowing this changes how we should treat each other. A short honest compliment costs nothing, yet it gives a real gift to the listener.'),

  ('a000000a-0000-0000-0000-00000000000a', 0, 'A city is mostly concrete, asphalt, and stone. These materials catch heat all day and let it go slowly at night. A forest, made of leaves and damp soil, does the opposite.'),
  ('a000000a-0000-0000-0000-00000000000a', 1, 'On a hot afternoon, the temperature inside a city can be five to seven degrees higher than the temperature in a forest only a few kilometers away.'),
  ('a000000a-0000-0000-0000-00000000000a', 2, 'Planting trees, painting rooftops white, and adding small parks can lower these numbers. The cure is simple, but it requires planning before the next summer arrives.'),

  ('a000000b-0000-0000-0000-00000000000b', 0, 'Almost every old civilization, from Egypt to Korea, made simple round balls for children. The materials changed, but the idea did not.'),
  ('a000000b-0000-0000-0000-00000000000b', 1, 'A ball teaches the body how to throw, catch, and predict. It also teaches the mind how to play with rules, alone or with others.'),
  ('a000000b-0000-0000-0000-00000000000b', 2, 'In a world full of new toys, the old round ball still rolls into every childhood. Simple things last because they teach the most.'),

  ('a000000c-0000-0000-0000-00000000000c', 0, 'When a stew sits in the fridge overnight, the flavors do not stay still. The liquids slowly enter the meat and the vegetables, and the strong tastes spread evenly.'),
  ('a000000c-0000-0000-0000-00000000000c', 1, 'At the same time, sharp flavors that taste loud on the first day soften. The next-day version is smoother and more balanced.'),
  ('a000000c-0000-0000-0000-00000000000c', 2, 'Good cooks know this. Many recipes are written so that the dish is made one day and served the next, on purpose.'),

  ('a000000d-0000-0000-0000-00000000000d', 0, 'A soccer ball is built from twenty white six-sided pieces and twelve black five-sided pieces. Together, these shapes wrap a ball almost perfectly.'),
  ('a000000d-0000-0000-0000-00000000000d', 1, 'This pattern is not chosen for looks alone. It is one of the few ways to cover a round surface with flat pieces of equal size.'),
  ('a000000d-0000-0000-0000-00000000000d', 2, 'Mathematicians have studied this shape since long before soccer existed. Sport and math, far apart at first glance, often meet on the same field.'),

  ('a000000e-0000-0000-0000-00000000000e', 0, 'Speed reading promises to push a thousand words a minute through the brain. In tests, the brain pushes back. Comprehension drops sharply past a certain point.'),
  ('a000000e-0000-0000-0000-00000000000e', 1, 'A reader who slows down and pauses on hard sentences often finishes the book more slowly but remembers far more of it. Slowness is part of understanding.'),
  ('a000000e-0000-0000-0000-00000000000e', 2, 'The real goal of reading is not to finish first. It is to carry the book inside your head after you close it.'),

  ('a000000f-0000-0000-0000-00000000000f', 0, 'Before weather forecasts, farmers watched the world around them. Birds flying low often meant rain. Cows lying down in a field often meant a storm before evening.'),
  ('a000000f-0000-0000-0000-00000000000f', 1, 'These signs were not magic. Animals feel changes in air pressure and humidity faster than people do, and they react before the change becomes obvious.'),
  ('a000000f-0000-0000-0000-00000000000f', 2, 'Modern tools can read the sky from satellites, but the old habit of watching animals still works in places where the wind speaks before the radio does.');

-- ===== 문제 (각 지문당 주제 2 + 빈칸 1 + 어휘 2 = 5문제) =================
-- 단순화: 모든 문제는 자동 생성된 UUID. passage_id로 묶임.

-- Passage 1: Sleep
insert into te_questions (passage_id, topic, prompt, choices, correct_answer, explanation, difficulty, grade_level, org_id) values
  ('a0000001-0000-0000-0000-000000000001', 'main_idea', 'What is the main idea of the passage?',
   '[{"key":"1","text":"Sleep is mostly about resting the body."},{"key":"2","text":"Sleep actively cleans the brain and protects memory."},{"key":"3","text":"Skipping sleep has no real cost."},{"key":"4","text":"Toxic proteins are formed only during deep sleep."}]',
   '2', '두 단락의 핵심: 수면이 단순한 휴식이 아니라 뇌 청소·기억 보호 기능을 한다.', 'low', 9, null),
  ('a0000001-0000-0000-0000-000000000001', 'main_idea', 'Which best summarizes the passage?',
   '[{"key":"1","text":"Sleep is one of the most active jobs the brain does."},{"key":"2","text":"The brain rests completely during sleep."},{"key":"3","text":"Memory is unrelated to sleep."},{"key":"4","text":"Deep sleep slows down thinking."}]',
   '1', '마지막 단락이 직접 결론으로 던지는 문장.', 'low', 9, null),
  ('a0000001-0000-0000-0000-000000000001', 'blank', 'Fill in the blank: During deep sleep, the brain rinses itself with a fluid that washes away ____ proteins.',
   '[{"key":"1","text":"useful"},{"key":"2","text":"toxic"},{"key":"3","text":"frozen"},{"key":"4","text":"new"}]',
   '2', '본문 그대로 toxic proteins.', 'low', 9, null),
  ('a0000001-0000-0000-0000-000000000001', 'vocabulary', 'In the passage, "stack up" most nearly means:',
   '[{"key":"1","text":"to disappear quietly"},{"key":"2","text":"to gather and build up"},{"key":"3","text":"to be cleaned away"},{"key":"4","text":"to fall over"}]',
   '2', '맥락: proteins begin to stack up → 점점 쌓이다.', 'low', 9, null),
  ('a0000001-0000-0000-0000-000000000001', 'vocabulary', 'In the passage, "skipping" most nearly means:',
   '[{"key":"1","text":"jumping happily"},{"key":"2","text":"not doing something you should do"},{"key":"3","text":"reading carefully"},{"key":"4","text":"making longer"}]',
   '2', 'skipping it has real costs → 빼먹다.', 'low', 9, null);

-- Passage 2: Walking
insert into te_questions (passage_id, topic, prompt, choices, correct_answer, explanation, difficulty, grade_level, org_id) values
  ('a0000002-0000-0000-0000-000000000002', 'main_idea', 'What is the passage mostly about?',
   '[{"key":"1","text":"Walking is the best exercise for losing weight."},{"key":"2","text":"Walking has effects on mood and thinking beyond physical health."},{"key":"3","text":"Writers should never sit at a desk."},{"key":"4","text":"Medicine for sadness is unnecessary."}]',
   '2', '도입 문장과 결론 모두 "thinking and mood"에 초점.', 'low', 9, null),
  ('a0000002-0000-0000-0000-000000000002', 'main_idea', 'Which title best fits?',
   '[{"key":"1","text":"Walking: A Simple Tool for the Mind"},{"key":"2","text":"The Hidden Costs of Walking"},{"key":"3","text":"Why Sitting Is Better Than Walking"},{"key":"4","text":"How to Walk for Weight Loss"}]',
   '1', '본문 전체: 단순한 운동이지만 마음·생각에 작동한다.', 'low', 9, null),
  ('a0000002-0000-0000-0000-000000000002', 'blank', 'Fill in the blank: Many writers and scientists report that their best ideas arrive while they are ____, not at a desk.',
   '[{"key":"1","text":"sleeping"},{"key":"2","text":"moving"},{"key":"3","text":"reading"},{"key":"4","text":"eating"}]',
   '2', 'arrive while they are moving.', 'low', 9, null),
  ('a0000002-0000-0000-0000-000000000002', 'vocabulary', 'In the passage, "lift mood" most nearly means:',
   '[{"key":"1","text":"to physically carry something"},{"key":"2","text":"to make someone feel better emotionally"},{"key":"3","text":"to forget feelings"},{"key":"4","text":"to make someone tired"}]',
   '2', 'lift는 "끌어올리다" → 기분을 끌어올리다.', 'low', 9, null),
  ('a0000002-0000-0000-0000-000000000002', 'vocabulary', 'In the passage, "stuck" most nearly means:',
   '[{"key":"1","text":"glued"},{"key":"2","text":"unable to progress"},{"key":"3","text":"deeply funny"},{"key":"4","text":"newly started"}]',
   '2', 'problem feels stuck → 풀리지 않다.', 'low', 9, null);

-- Passage 3: Stories
insert into te_questions (passage_id, topic, prompt, choices, correct_answer, explanation, difficulty, grade_level, org_id) values
  ('a0000003-0000-0000-0000-000000000003', 'main_idea', 'What is the main idea?',
   '[{"key":"1","text":"Stories are entertainment, not learning tools."},{"key":"2","text":"The brain remembers stories more easily than lists of facts."},{"key":"3","text":"Good teachers avoid storytelling."},{"key":"4","text":"Campfires destroyed early human memory."}]',
   '2', '전체 단락 핵심: 이야기 = 기억에 잘 남는 형태.', 'low', 9, null),
  ('a0000003-0000-0000-0000-000000000003', 'main_idea', 'Why does a good teacher use stories?',
   '[{"key":"1","text":"To save time."},{"key":"2","text":"To help the lesson stay in students minds."},{"key":"3","text":"To replace facts with fiction."},{"key":"4","text":"To make tests harder."}]',
   '2', '마지막 단락의 직접 진술.', 'low', 9, null),
  ('a0000003-0000-0000-0000-000000000003', 'blank', 'Fill in the blank: A story has characters, problems, and endings, and our minds catch onto these ____ naturally.',
   '[{"key":"1","text":"shapes"},{"key":"2","text":"colors"},{"key":"3","text":"costs"},{"key":"4","text":"numbers"}]',
   '1', 'catch onto these shapes.', 'low', 9, null),
  ('a0000003-0000-0000-0000-000000000003', 'vocabulary', 'In the passage, "wrapped in a story" most nearly means:',
   '[{"key":"1","text":"placed inside a story"},{"key":"2","text":"shown without context"},{"key":"3","text":"erased from memory"},{"key":"4","text":"printed in a book"}]',
   '1', 'wrap in → ~으로 감싸다.', 'low', 9, null),
  ('a0000003-0000-0000-0000-000000000003', 'vocabulary', 'In the passage, "hold" most nearly means:',
   '[{"key":"1","text":"to grab with hands"},{"key":"2","text":"to keep in memory"},{"key":"3","text":"to repeat aloud"},{"key":"4","text":"to delete"}]',
   '2', 'A list of facts is hard to hold → 머릿속에 담기 어렵다.', 'low', 9, null);

-- Passage 4: Bees
insert into te_questions (passage_id, topic, prompt, choices, correct_answer, explanation, difficulty, grade_level, org_id) values
  ('a0000004-0000-0000-0000-000000000004', 'main_idea', 'What is the passage mostly about?',
   '[{"key":"1","text":"Bees fly randomly until they find flowers."},{"key":"2","text":"A bee has built-in navigation, timing, and a way to share information."},{"key":"3","text":"Bees cannot communicate."},{"key":"4","text":"Bees do not return to the hive."}]',
   '2', '세 단락이 각각 map, clock, language를 보여준다.', 'low', 9, null),
  ('a0000004-0000-0000-0000-000000000004', 'main_idea', 'What is the writer''s main point in the last sentence?',
   '[{"key":"1","text":"Bees are too small to matter."},{"key":"2","text":"Nature hides large skills in small bodies."},{"key":"3","text":"Coins are similar to bees."},{"key":"4","text":"Bees should be kept in larger boxes."}]',
   '2', '마지막 문장 그대로의 주제.', 'low', 9, null),
  ('a0000004-0000-0000-0000-000000000004', 'blank', 'Fill in the blank: The bee adjusts its flight as the sun moves across the ____.',
   '[{"key":"1","text":"ocean"},{"key":"2","text":"hive"},{"key":"3","text":"sky"},{"key":"4","text":"flower"}]',
   '3', 'across the sky.', 'low', 9, null),
  ('a0000004-0000-0000-0000-000000000004', 'vocabulary', 'In the passage, "precise" most nearly means:',
   '[{"key":"1","text":"exact and accurate"},{"key":"2","text":"slow and confused"},{"key":"3","text":"large and rough"},{"key":"4","text":"random"}]',
   '1', 'precise map → 정확한 지도.', 'low', 9, null),
  ('a0000004-0000-0000-0000-000000000004', 'vocabulary', 'In the passage, "tiny" most nearly means:',
   '[{"key":"1","text":"very large"},{"key":"2","text":"very small"},{"key":"3","text":"very angry"},{"key":"4","text":"very loud"}]',
   '2', 'tiny body → 매우 작은 몸.', 'low', 9, null);

-- Passage 5: First smartphone
insert into te_questions (passage_id, topic, prompt, choices, correct_answer, explanation, difficulty, grade_level, org_id) values
  ('a0000005-0000-0000-0000-000000000005', 'main_idea', 'What is the main idea?',
   '[{"key":"1","text":"The first smartphone looked very different from today and was not seen as necessary."},{"key":"2","text":"The first smartphone was sleek and modern."},{"key":"3","text":"Smartphones have not changed since 1994."},{"key":"4","text":"Phones in 1994 could not send email."}]',
   '1', '전체 단락 핵심: 외형도 인식도 지금과 완전히 다름.', 'low', 10, null),
  ('a0000005-0000-0000-0000-000000000005', 'main_idea', 'Which title best fits?',
   '[{"key":"1","text":"A Useless Invention"},{"key":"2","text":"The Heavy First Smartphone"},{"key":"3","text":"Why Phones Have Always Been Pocket-Sized"},{"key":"4","text":"How Phones Killed Computers"}]',
   '2', '본문 톤: 무겁고 비싸고 외면받았던 첫 스마트폰.', 'low', 10, null),
  ('a0000005-0000-0000-0000-000000000005', 'blank', 'Fill in the blank: The first smartphone weighed almost half a ____.',
   '[{"key":"1","text":"meter"},{"key":"2","text":"kilogram"},{"key":"3","text":"hour"},{"key":"4","text":"liter"}]',
   '2', 'weighed almost half a kilogram.', 'low', 10, null),
  ('a0000005-0000-0000-0000-000000000005', 'vocabulary', 'In the passage, "sleek" most nearly means:',
   '[{"key":"1","text":"old and worn"},{"key":"2","text":"smooth and modern looking"},{"key":"3","text":"heavy and slow"},{"key":"4","text":"green and dim"}]',
   '2', 'sleek black rectangle → 매끈한 사각형.', 'low', 10, null),
  ('a0000005-0000-0000-0000-000000000005', 'vocabulary', 'In the passage, "see why they would need" most nearly means:',
   '[{"key":"1","text":"to understand the reason"},{"key":"2","text":"to physically look at"},{"key":"3","text":"to forget"},{"key":"4","text":"to refuse"}]',
   '1', 'see → 이해하다, 인식하다 의미.', 'low', 10, null);

-- Passage 6~15 동일 패턴
-- 6: Music
insert into te_questions (passage_id, topic, prompt, choices, correct_answer, explanation, difficulty, grade_level, org_id) values
  ('a0000006-0000-0000-0000-000000000006', 'main_idea', 'What is the main point?',
   '[{"key":"1","text":"Music is always bad for studying."},{"key":"2","text":"Silence is always best for studying."},{"key":"3","text":"Whether music helps depends on the type of task."},{"key":"4","text":"Loud lyrics improve hard reading."}]',
   '3', '본문 핵심: 작업의 종류에 따라 다르다.', 'low', 9, null),
  ('a0000006-0000-0000-0000-000000000006', 'blank', 'Fill in the blank: For tasks that are familiar or repetitive, gentle music helps the mind stay ____.',
   '[{"key":"1","text":"alert"},{"key":"2","text":"asleep"},{"key":"3","text":"quiet"},{"key":"4","text":"hungry"}]',
   '1', 'stay alert.', 'low', 9, null),
  ('a0000006-0000-0000-0000-000000000006', 'vocabulary', 'In the passage, "steal focus" most nearly means:',
   '[{"key":"1","text":"to give attention"},{"key":"2","text":"to take attention away"},{"key":"3","text":"to read carefully"},{"key":"4","text":"to play loudly"}]',
   '2', 'steal focus → 집중을 빼앗다.', 'low', 9, null);

-- 7: Whistled language
insert into te_questions (passage_id, topic, prompt, choices, correct_answer, explanation, difficulty, grade_level, org_id) values
  ('a0000007-0000-0000-0000-000000000007', 'main_idea', 'What is the writer''s main point?',
   '[{"key":"1","text":"Whistling is only a hobby."},{"key":"2","text":"A whistled language is a real language, and saving it matters."},{"key":"3","text":"La Gomera is too noisy for normal speech."},{"key":"4","text":"All languages should use whistling."}]',
   '2', '본문 전체에서 강조: 진짜 언어이며 보존 가치 있음.', 'low', 10, null),
  ('a0000007-0000-0000-0000-000000000007', 'blank', 'Fill in the blank: A skilled whistler can be understood from ____ kilometers away.',
   '[{"key":"1","text":"two"},{"key":"2","text":"twenty"},{"key":"3","text":"a hundred"},{"key":"4","text":"five hundred"}]',
   '1', 'two kilometers away.', 'low', 10, null),
  ('a0000007-0000-0000-0000-000000000007', 'vocabulary', 'In the passage, "skilled" most nearly means:',
   '[{"key":"1","text":"untrained"},{"key":"2","text":"well-trained"},{"key":"3","text":"forgetful"},{"key":"4","text":"young"}]',
   '2', 'skilled whistler → 능숙한.', 'low', 10, null);

-- 8: Coral reefs
insert into te_questions (passage_id, topic, prompt, choices, correct_answer, explanation, difficulty, grade_level, org_id) values
  ('a0000008-0000-0000-0000-000000000008', 'main_idea', 'What is the passage mostly about?',
   '[{"key":"1","text":"Coral reefs are only for tourists."},{"key":"2","text":"Coral reefs do many vital jobs beyond looking beautiful."},{"key":"3","text":"Reefs cover most of the ocean floor."},{"key":"4","text":"Reefs cause storms."}]',
   '2', '전체 단락이 다양한 기능 (생물 거주, 폭풍 막기) 강조.', 'low', 9, null),
  ('a0000008-0000-0000-0000-000000000008', 'blank', 'Fill in the blank: Coral reefs are home to about a ____ of all sea creatures.',
   '[{"key":"1","text":"half"},{"key":"2","text":"third"},{"key":"3","text":"quarter"},{"key":"4","text":"tenth"}]',
   '3', 'a quarter of all sea creatures.', 'low', 9, null),
  ('a0000008-0000-0000-0000-000000000008', 'vocabulary', 'In the passage, "shield" most nearly means:',
   '[{"key":"1","text":"a thing that protects from harm"},{"key":"2","text":"a deep cave"},{"key":"3","text":"a fishing net"},{"key":"4","text":"an empty space"}]',
   '1', 'shield → 방패, 보호 장치.', 'low', 9, null);

-- 9: Compliments
insert into te_questions (passage_id, topic, prompt, choices, correct_answer, explanation, difficulty, grade_level, org_id) values
  ('a0000009-0000-0000-0000-000000000009', 'main_idea', 'What is the main idea?',
   '[{"key":"1","text":"Compliments are empty words."},{"key":"2","text":"The brain treats kind words as real rewards, so compliments matter."},{"key":"3","text":"Money is the only thing the brain values."},{"key":"4","text":"Brain scans cannot detect emotions."}]',
   '2', '본문 핵심: 친절한 말이 보상 영역을 활성화 → 진짜 가치.', 'low', 9, null),
  ('a0000009-0000-0000-0000-000000000009', 'blank', 'Fill in the blank: A short honest compliment ____ nothing, yet it gives a real gift to the listener.',
   '[{"key":"1","text":"weighs"},{"key":"2","text":"costs"},{"key":"3","text":"hurts"},{"key":"4","text":"says"}]',
   '2', 'costs nothing → 비용이 들지 않는다.', 'low', 9, null),
  ('a0000009-0000-0000-0000-000000000009', 'vocabulary', 'In the passage, "sincere" most nearly means:',
   '[{"key":"1","text":"fake or playful"},{"key":"2","text":"honest and truly meant"},{"key":"3","text":"loud and quick"},{"key":"4","text":"strange"}]',
   '2', 'sincere compliment → 진심 어린 칭찬.', 'low', 9, null);

-- 10: Cities hotter
insert into te_questions (passage_id, topic, prompt, choices, correct_answer, explanation, difficulty, grade_level, org_id) values
  ('a000000a-0000-0000-0000-00000000000a', 'main_idea', 'What is the passage about?',
   '[{"key":"1","text":"Why cities are hotter than nearby forests, and what we can do."},{"key":"2","text":"How concrete is the best material for cities."},{"key":"3","text":"Why summers are always cool in forests."},{"key":"4","text":"How forests cause heat waves."}]',
   '1', '도입·전개·해결책 흐름.', 'low', 10, null),
  ('a000000a-0000-0000-0000-00000000000a', 'blank', 'Fill in the blank: The temperature inside a city can be ____ to seven degrees higher than the temperature in a nearby forest.',
   '[{"key":"1","text":"one"},{"key":"2","text":"three"},{"key":"3","text":"five"},{"key":"4","text":"ten"}]',
   '3', 'five to seven degrees higher.', 'low', 10, null),
  ('a000000a-0000-0000-0000-00000000000a', 'vocabulary', 'In the passage, "cure" most nearly means:',
   '[{"key":"1","text":"a solution to a problem"},{"key":"2","text":"a kind of disease"},{"key":"3","text":"a city park"},{"key":"4","text":"a paint color"}]',
   '1', 'The cure is simple → 해결책.', 'low', 10, null);

-- 11~15 (Balls, Stew, Soccer math, Slow reading, Animal weather)
insert into te_questions (passage_id, topic, prompt, choices, correct_answer, explanation, difficulty, grade_level, org_id) values
  ('a000000b-0000-0000-0000-00000000000b', 'main_idea', 'What is the writer''s main point?',
   '[{"key":"1","text":"Modern toys have replaced the ball."},{"key":"2","text":"The ball survives because it teaches body and mind."},{"key":"3","text":"Balls are too simple to be useful."},{"key":"4","text":"Different cultures use different toys completely."}]',
   '2', '본문 결론: 단순한 게 가장 많이 가르친다.', 'low', 9, null),
  ('a000000b-0000-0000-0000-00000000000b', 'blank', 'Fill in the blank: Simple things last because they ____ the most.',
   '[{"key":"1","text":"cost"},{"key":"2","text":"teach"},{"key":"3","text":"break"},{"key":"4","text":"hide"}]',
   '2', 'teach the most.', 'low', 9, null),
  ('a000000b-0000-0000-0000-00000000000b', 'vocabulary', 'In the passage, "predict" most nearly means:',
   '[{"key":"1","text":"to guess what will happen"},{"key":"2","text":"to remember the past"},{"key":"3","text":"to ask a question"},{"key":"4","text":"to throw away"}]',
   '1', 'predict → 예측하다.', 'low', 9, null),

  ('a000000c-0000-0000-0000-00000000000c', 'main_idea', 'What is the main idea?',
   '[{"key":"1","text":"Old food is always spoiled."},{"key":"2","text":"Some dishes taste better after a day because flavors spread and soften."},{"key":"3","text":"Stews should be eaten immediately."},{"key":"4","text":"Fridge cooling destroys taste."}]',
   '2', '전체 단락이 다음날의 맛 향상 이유 설명.', 'low', 9, null),
  ('a000000c-0000-0000-0000-00000000000c', 'blank', 'Fill in the blank: The next-day version is smoother and more ____.',
   '[{"key":"1","text":"sharp"},{"key":"2","text":"balanced"},{"key":"3","text":"frozen"},{"key":"4","text":"loud"}]',
   '2', 'smoother and more balanced.', 'low', 9, null),
  ('a000000c-0000-0000-0000-00000000000c', 'vocabulary', 'In the passage, "evenly" most nearly means:',
   '[{"key":"1","text":"in an equal way throughout"},{"key":"2","text":"in patches"},{"key":"3","text":"loudly"},{"key":"4","text":"rarely"}]',
   '1', 'spread evenly → 고르게.', 'low', 9, null),

  ('a000000d-0000-0000-0000-00000000000d', 'main_idea', 'What is the writer''s main idea?',
   '[{"key":"1","text":"Soccer balls have a random pattern."},{"key":"2","text":"The pattern of a soccer ball follows a mathematical rule."},{"key":"3","text":"Mathematicians invented soccer."},{"key":"4","text":"The pattern was chosen only for beauty."}]',
   '2', '본문 핵심: 수학적 규칙이 디자인을 결정.', 'low', 10, null),
  ('a000000d-0000-0000-0000-00000000000d', 'blank', 'Fill in the blank: A soccer ball is built from twenty white six-sided pieces and twelve black ____-sided pieces.',
   '[{"key":"1","text":"three"},{"key":"2","text":"four"},{"key":"3","text":"five"},{"key":"4","text":"seven"}]',
   '3', 'twelve black five-sided pieces.', 'low', 10, null),
  ('a000000d-0000-0000-0000-00000000000d', 'vocabulary', 'In the passage, "wrap" most nearly means:',
   '[{"key":"1","text":"to cover the surface of"},{"key":"2","text":"to throw away"},{"key":"3","text":"to count"},{"key":"4","text":"to break apart"}]',
   '1', 'wrap a ball → 공을 감싸다.', 'low', 10, null),

  ('a000000e-0000-0000-0000-00000000000e', 'main_idea', 'What is the writer''s main point?',
   '[{"key":"1","text":"Reading fast always wins."},{"key":"2","text":"The goal of reading is not speed but understanding and remembering."},{"key":"3","text":"Speed reading helps comprehension."},{"key":"4","text":"Slow reading wastes time."}]',
   '2', '본문 결론: 책을 머릿속에 가지고 다니는 것이 목표.', 'low', 10, null),
  ('a000000e-0000-0000-0000-00000000000e', 'blank', 'Fill in the blank: Comprehension drops sharply past a certain ____.',
   '[{"key":"1","text":"library"},{"key":"2","text":"point"},{"key":"3","text":"chapter"},{"key":"4","text":"book"}]',
   '2', 'past a certain point.', 'low', 10, null),
  ('a000000e-0000-0000-0000-00000000000e', 'vocabulary', 'In the passage, "carry the book inside your head" most nearly means:',
   '[{"key":"1","text":"to physically hold a book"},{"key":"2","text":"to remember and use what you read"},{"key":"3","text":"to forget the book"},{"key":"4","text":"to copy the book"}]',
   '2', '비유 표현: 책을 머릿속에 가지고 다니다 = 기억하고 활용하다.', 'low', 10, null),

  ('a000000f-0000-0000-0000-00000000000f', 'main_idea', 'What is the passage mostly about?',
   '[{"key":"1","text":"Old farmers were better than modern forecasts."},{"key":"2","text":"Animals sense weather changes before people do, and this knowledge is still useful."},{"key":"3","text":"Satellites are useless."},{"key":"4","text":"Birds always fly low."}]',
   '2', '본문 흐름: 동물 관찰 → 과학적 이유 → 지금도 유효.', 'low', 9, null),
  ('a000000f-0000-0000-0000-00000000000f', 'blank', 'Fill in the blank: Animals feel changes in air pressure and humidity faster than ____ do.',
   '[{"key":"1","text":"plants"},{"key":"2","text":"people"},{"key":"3","text":"radios"},{"key":"4","text":"clouds"}]',
   '2', 'faster than people do.', 'low', 9, null),
  ('a000000f-0000-0000-0000-00000000000f', 'vocabulary', 'In the passage, "forecasts" most nearly means:',
   '[{"key":"1","text":"weather predictions"},{"key":"2","text":"history books"},{"key":"3","text":"farming tools"},{"key":"4","text":"animal types"}]',
   '1', 'weather forecasts → 일기예보.', 'low', 9, null);
