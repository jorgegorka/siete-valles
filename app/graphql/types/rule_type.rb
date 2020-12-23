# frozen_string_literal: true

module Types
  class RuleType < Types::BaseObject
    field :id, String, null: false, method: :uuid
    field :starts_at, GraphQL::Types::ISO8601DateTime, null: true
    field :ends_at, GraphQL::Types::ISO8601DateTime, null: true
    field :reward, Types::RewardType, null: false
    field :conditions, [Types::ConditionType], null: true
  end
end
