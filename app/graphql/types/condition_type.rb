# frozen_string_literal: true

module Types
  class ConditionType < Types::BaseObject
    field :id, String, null: false, method: :uuid
    field :rule, Types::RuleType, null: false
    field :operation, String, null: false
    field :expression, String, null: false
    field :value, Integer, null: false
    field :starts_at, GraphQL::Types::ISO8601DateTime, null: true
    field :ends_at, GraphQL::Types::ISO8601DateTime, null: true
    field :event, Types::EventType, null: true
  end
end
