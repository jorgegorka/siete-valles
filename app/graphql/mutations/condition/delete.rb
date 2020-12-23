# frozen_string_literal: true

module Mutations
  module Condition
    class Delete < Mutations::BaseMutation
      graphql_name 'DeleteCondition'

      argument :rule_id, String, required: true
      argument :id, String, required: true

      field :errors, [String], null: true
      field :message, String, null: false

      def resolve(params)
        condition = Conditions::Persistence.destroy(params)

        if condition.destroyed?
          {
            errors: [],
            message: 'Condition was deleted'
          }
        else
          {
            errors: condition.errors.full_messages,
            message: ''
          }
        end
      end
    end
  end
end
