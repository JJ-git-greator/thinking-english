-- =====================================================================
-- Sample te_passages for Phase 1 testing
-- Style: EBS 수능특강/수능완성 모의 — 3~4 te_paragraphs each
-- Public (org_id = NULL) so both academy students and B2C can access.
-- =====================================================================

-- Insert passages with explicit UUIDs so we can reference them for paragraphs
insert into te_passages (id, title, body, source, grade_level, difficulty, org_id)
values
  (
    '11111111-1111-1111-1111-111111111111',
    'The Hidden Cost of Free Choice',
    'Behavioral economists have long studied how people make decisions when given many options. Surprisingly, more choice does not always mean more happiness.',
    'EBS Adapted',
    11,
    'mid',
    null
  ),
  (
    '22222222-2222-2222-2222-222222222222',
    'Why Forests Quietly Talk to Each Other',
    'For most of human history, forests were imagined as collections of separate trees competing for sunlight. Recent science suggests the opposite.',
    'EBS Adapted',
    10,
    'mid',
    null
  ),
  (
    '33333333-3333-3333-3333-333333333333',
    'Why Mistakes Make Better Learners',
    'Many students believe that good learners rarely make mistakes. The opposite is true.',
    'EBS Adapted',
    9,
    'low',
    null
  );

-- Paragraphs for Passage 1
insert into te_paragraphs (passage_id, ord, body) values
  ('11111111-1111-1111-1111-111111111111', 0, 'When shoppers walk into a store offering 24 different kinds of jam, they often pause longer at the display than those who see only 6 kinds. Yet a famous experiment found that the larger selection led to far fewer actual purchases. The presence of many options can feel exciting, but it quietly raises the cost of choosing.'),
  ('11111111-1111-1111-1111-111111111111', 1, 'This phenomenon, sometimes called "choice overload," reveals a quiet trade-off. Each additional option forces the brain to compare, evaluate, and worry about what is being given up. As the mental cost grows, the joy of finally choosing shrinks. People begin to fear making the wrong decision more than they enjoy any particular outcome.'),
  ('11111111-1111-1111-1111-111111111111', 2, 'For students, this hidden cost matters more than it seems. A learner who tries to study from twenty different books often ends up mastering none of them. Restricting one''s options is sometimes the most powerful way to make consistent progress, because the brain can finally focus on doing instead of choosing.'),
  ('11111111-1111-1111-1111-111111111111', 3, 'In the end, freedom of choice is valuable only when it serves a goal. Choice for its own sake can paralyze us. The wise move is to design our environment so that fewer, better options remain in front of us.');

-- Paragraphs for Passage 2
insert into te_paragraphs (passage_id, ord, body) values
  ('22222222-2222-2222-2222-222222222222', 0, 'Beneath the soil of an ordinary forest lies an enormous network of fungal threads. These threads connect the roots of different trees, sometimes across great distances. Scientists call it the "wood wide web," and it allows trees to share resources in surprising ways.'),
  ('22222222-2222-2222-2222-222222222222', 1, 'Through this underground system, a tall mother tree can send sugars to a smaller seedling struggling in the shade. Trees attacked by insects can send chemical warnings to their neighbors, giving them time to prepare defenses. The forest, in this view, behaves less like a battlefield and more like a community.'),
  ('22222222-2222-2222-2222-222222222222', 2, 'This finding changes how we should think about ecosystems. Removing a single old tree may not be a small act; it can disconnect dozens of other trees from a shared support system. Protecting biodiversity means protecting the invisible connections, not only the visible plants.');

-- Paragraphs for Passage 3
insert into te_paragraphs (passage_id, ord, body) values
  ('33333333-3333-3333-3333-333333333333', 0, 'When a learner answers a difficult question wrong and then sees the correct answer, the brain responds with a strong burst of attention. This moment of surprise creates the perfect condition for memory formation. In other words, a corrected mistake is often remembered far longer than an answer that came easily.'),
  ('33333333-3333-3333-3333-333333333333', 1, 'This is why simply re-reading notes is one of the weakest study habits. Re-reading feels productive, but the brain is not surprised by anything. Quiz-style practice, even when answers come out wrong, trains memory because it forces the brain to predict, fail, and then update its understanding.'),
  ('33333333-3333-3333-3333-333333333333', 2, 'For this reason, the best students treat wrong answers as a tool, not a punishment. They look for the question type that defeats them most often, and they go back to it on purpose. Comfort is the enemy of growth; well-designed difficulty is its friend.');
