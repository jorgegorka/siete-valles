# frozen_string_literal: true

module Mutations
  module Event
    class Create < Mutations::BaseMutation
      graphql_name 'CreateEvent'

      argument :name, String, required: true
      argument :value, String, required: true

      field :errors, [String], null: true
      field :event, Types::EventType, null: true

      def resolve(params)
        event = Events::Persistence.create(params)

        {
          event: event,
          errors: event.errors.full_messages
        }
      end
    end
  end
end
