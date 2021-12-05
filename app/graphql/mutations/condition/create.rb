module Mutations
  module Condition
    class Create < Mutations::BaseMutation
      graphql_name 'CreateCondition'

      argument :rule_id, String, required: true
      argument :operation, String, required: true
      argument :expression, String, required: true
      argument :value, Integer, required: true
      argument :event_id, String, required: false

      field :errors, [String], null: true
      field :condition, Types::ConditionType, null: true

      def resolve(params)
        condition = Conditions::Persistence.create(params)

        {
          condition: condition,
          errors: condition.errors.full_messages
        }
      end
    end
  end
end
