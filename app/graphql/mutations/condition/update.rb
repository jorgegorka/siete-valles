# frozen_string_literal: true

module Mutations
  module Condition
    class Update < Mutations::BaseMutation
      graphql_name 'UpdateCondition'

      argument :rule_id, String, required: true
      argument :id, String, required: true
      argument :operation, String, required: false
      argument :expression, String, required: false
      argument :value, Integer, required: false
      argument :action_id, String, required: false

      field :errors, [String], null: true
      field :condition, Types::ConditionType, null: true

      def resolve(params)
        condition = Conditions::Persistence.update(params)

        {
          errors: condition.errors.full_messages,
          condition: condition
        }
      end
    end
  end
end
