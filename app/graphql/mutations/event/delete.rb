# frozen_string_literal: true

module Mutations
  module Event
    class Delete < Mutations::BaseMutation
      graphql_name 'DeleteEvent'

      argument :id, String, required: true

      field :errors, [String], null: true
      field :message, String, null: false

      def resolve(id:)
        event = Events::Persistence.destroy(id)

        if event.destroyed?
          {
            errors: [],
            message: 'Event was deleted'
          }
        else
          {
            errors: event.errors.full_messages,
            message: ''
          }
        end
      end
    end
  end
end
