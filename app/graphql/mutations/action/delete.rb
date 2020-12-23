# frozen_string_literal: true

module Mutations
  module Action
    class Delete < Mutations::BaseMutation
      graphql_name 'DeleteAction'

      argument :id, String, required: true

      field :errors, [String], null: true
      field :message, String, null: false

      def resolve(params)
        action = Actions::Persistence.destroy(params)

        if action.destroyed?
          {
            errors: [],
            message: 'Action was deleted'
          }
        else
          {
            errors: action.errors.full_messages,
            message: ''
          }
        end
      end
    end
  end
end
