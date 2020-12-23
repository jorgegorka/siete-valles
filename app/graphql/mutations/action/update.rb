# frozen_string_literal: true

module Mutations
  module Action
    class Update < Mutations::BaseMutation
      graphql_name 'UpdateAction'

      argument :id, String, required: true
      argument :name, String, required: true
      argument :value, Integer, required: true

      field :errors, [String], null: true
      field :action, Types::ActionType, null: true

      def resolve(params)
        action = Actions::Persistence.update(params)

        {
          errors: action.errors.full_messages,
          action: action
        }
      end
    end
  end
end
