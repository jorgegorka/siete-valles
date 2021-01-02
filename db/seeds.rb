# frozen_string_literal: true

Achievement.delete_all
Activity.delete_all
Receiver.delete_all
Event.delete_all
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
pageview1 = Reward.create(
  name: 'Viewed 10 pages',
  category: :badge,
  description: 'You have visited 10 pages from our website'
)
pageview2 = Reward.create(
  name: 'Viewed 80 pages',
  category: :badge,
  description: 'You have visited 80 pages from our website'
)
pageview3 = Reward.create(
  name: 'Viewed 166 pages',
  category: :badge,
  description: 'You have visited 166 pages from our website'
)

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

view_page = Event.create(
  name: 'Pageview',
  value: 1
)

add_comment = Event.create(
  name: 'Submit Comment',
  value: 2
)

Event.create(
  name: 'Like Post',
  value: 1
)

Event.create(
  name: 'Submit Article',
  value: 13
)

Event.create(
  name: 'Add Photo To Profile',
  value: 7
)

# Rules and conditions

rule_page1 = Rule.create(name: 'More than 10 points', reward: pageview1)
rule_page1.conditions.create(
  operation: :points,
  expression: :gt,
  value: 10,
  event: view_page
)

rule_page2 = Rule.create(name: 'More than 80 points', reward: pageview2)
rule_page2.conditions.create(
  operation: :points,
  expression: :gt,
  value: 80,
  event: view_page
)

rule_page3 = Rule.create(name: 'More than 166 points', reward: pageview3)
rule_page3.conditions.create(
  operation: :points,
  expression: :gt,
  value: 166,
  event: view_page
)

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
  event: add_comment,
  operation: :counter,
  expression: :eq,
  value: 1
)

rule5 = Rule.create(name: 'At least 15 comments', reward: comment2)
rule5.conditions.create(
  event: add_comment,
  operation: :counter,
  expression: :eq,
  value: 15
)

rule6 = Rule.create(name: 'At least 45 comments', reward: comment3)
rule6.conditions.create(
  event: add_comment,
  operation: :counter,
  expression: :eq,
  value: 45
)

Receiver.create(external_id: 'user-1')
Receiver.create(external_id: 'user-2')
Receiver.create(external_id: 'company-1')

Activity.create(receiver_id: receiver_id, event: event, value: value)
