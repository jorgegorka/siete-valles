# frozen_string_literal: true

module Mutations
  module Action
    class Create < Mutations::BaseMutation
      graphql_name 'CreateAction'

      argument :name, String, required: true
      argument :value, String, required: true

      field :errors, [String], null: true
      field :action, Types::ActionType, null: true

      def resolve(params)
        action = Actions::Persistence.create(params)

        {
          action: action,
          errors: action.errors.full_messages
        }
      end
    end
  end
end
