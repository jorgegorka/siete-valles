# frozen_string_literal: true

module Mutations
  module Rule
    class Create < Mutations::BaseMutation
      graphql_name 'CreateRule'

      argument :name, String, required: true
      argument :reward_id, String, required: true
      argument :starts_at, GraphQL::Types::ISO8601DateTime, required: false
      argument :ends_at, GraphQL::Types::ISO8601DateTime, required: false

      field :errors, [String], null: true
      field :rule, Types::RuleType, null: true

      def resolve(params)
        rule = Rules::Persistence.create(params)

        {
          rule: rule,
          errors: rule.errors.full_messages
        }
      end
    end
  end
end
