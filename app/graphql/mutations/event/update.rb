module Mutations
  module Event
    class Update < Mutations::BaseMutation
      graphql_name 'UpdateEvent'

      argument :id, String, required: true
      argument :name, String, required: true
      argument :value, Integer, required: true

      field :errors, [String], null: true
      field :event, Types::EventType, null: true

      def resolve(params)
        event = Events::Persistence.update(params)

        {
          errors: event.errors.full_messages,
          event: event
        }
      end
    end
  end
end
