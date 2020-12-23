# frozen_string_literal: true

module Mutations
  module Receiver
    class Create < Mutations::BaseMutation
      graphql_name 'CreateReceiver'

      argument :external_id, String, required: true

      field :errors, [String], null: true
      field :receiver, Types::ReceiverType, null: true

      def resolve(params)
        receiver = Receivers::Persistence.create(params)

        {
          receiver: receiver,
          errors: receiver.errors.full_messages
        }
      end
    end
  end
end
