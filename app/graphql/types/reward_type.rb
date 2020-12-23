# frozen_string_literal: true

module Types
  class RewardType < Types::BaseObject
    field :id, String, null: false, method: :uuid
    field :name, String, null: false
    field :category, String, null: false
    field :active, Boolean, null: false
    field :image_url, String, null: true
    field :achievements, [Types::AchievementType], null: true
    field :rules, [Types::RuleType], null: true
  end
end
