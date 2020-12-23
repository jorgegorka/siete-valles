# frozen_string_literal: true

module Mutations
  module Rule
    class Delete < Mutations::BaseMutation
      graphql_name 'DeleteRule'

      argument :id, String, required: true

      field :errors, [String], null: true
      field :message, String, null: false

      def resolve(id:)
        rule = Rules::Persistence.destroy(id)

        if rule.destroyed?
          {
            errors: [],
            message: 'Rule was deleted'
          }
        else
          {
            errors: rule.errors.full_messages,
            message: ''
          }
        end
      end
    end
  end
end
