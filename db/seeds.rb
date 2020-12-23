# frozen_string_literal: true

Achievement.delete_all
Activity.delete_all
Receiver.delete_all
Action.delete_all
Condition.delete_all
Rule.delete_all
Reward.delete_all

# Levels

level1 = Reward.create(
  name: 'Level 1',
  category: :level,
  description: 'Congratulations! You got 10 points'
)
level2 = Reward.create(
  name: 'Level 2',
  category: :level,
  description: 'You are improving You got 50 points'
)
level3 = Reward.create(
  name: 'Level 3',
  category: :level,
  description: 'Master & commander You got 124 points'
)

# Badges

comment1 = Reward.create(
  name: 'Comment newbie',
  category: :badge,
  description: 'Your first comment'
)
comment2 = Reward.create(
  name: 'Comment amateur',
  category: :badge,
  description: 'You sent 15 comments'
)
comment3 = Reward.create(
  name: 'Comment pro',
  category: :badge,
  description: 'You sent 45 comments'
)

# Actions

add_comment = Action.create(
  name: 'Submit Comment',
  value: 2
)

Action.create(
  name: 'Like Post',
  value: 1
)

Action.create(
  name: 'Submit Article',
  value: 13
)

Action.create(
  name: 'Add Photo To Profile',
  value: 7
)

# Rules and conditions

rule1 = Rule.create(name: 'More than 10 points', reward: level1)
rule1.conditions.create(
  operation: :points,
  expression: :gt,
  value: 10
)

rule2 = Rule.create(name: 'More than 50 points',reward: level2)
rule2.conditions.create(
  operation: :points,
  expression: :gt,
  value: 50
)

rule3 = Rule.create(name: 'More than 124 points',reward: level3)
rule3.conditions.create(
  operation: :points,
  expression: :gt,
  value: 124
)

rule4 = Rule.create(name: 'At least one comments',reward: comment1)
rule4.conditions.create(
  action: add_comment,
  operation: :counter,
  expression: :eq,
  value: 1
)

rule5 = Rule.create(name: 'At least 15 comments', reward: comment2)
rule5.conditions.create(
  action: add_comment,
  operation: :counter,
  expression: :eq,
  value: 15
)

rule6 = Rule.create(name: 'At least 45 comments', reward: comment3)
rule6.conditions.create(
  action: add_comment,
  operation: :counter,
  expression: :eq,
  value: 45
)

Receiver.create(external_id: 'user-1')
Receiver.create(external_id: 'user-2')
Receiver.create(external_id: 'company-1')
