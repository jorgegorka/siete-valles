# frozen_string_literal: true

module Mutations
  module Receiver
    class Delete < Mutations::BaseMutation
      graphql_name 'DeleteReceiver'

      argument :id, String, required: true

      field :errors, [String], null: true
      field :message, String, null: false

      def resolve(params)
        receiver = Receivers::Persistence.destroy(params)

        if receiver.destroyed?
          {
            errors: [],
            message: 'Receiver was deleted'
          }
        else
          {
            errors: receiver.errors.full_messages,
            message: ''
          }
        end
      end
    end
  end
end
