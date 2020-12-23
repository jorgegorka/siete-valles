# frozen_string_literal: true

module Mutations
  module Receiver
    class Update < Mutations::BaseMutation
      graphql_name 'UpdateReceiver'

      argument :id, String, required: true
      argument :external_id, String, required: false
      argument :points, Integer, required: false

      field :errors, [String], null: true
      field :receiver, Types::ReceiverType, null: true

      def resolve(params)
        receiver = Receivers::Persistence.update(params)

        {
          errors: receiver.errors.full_messages,
          receiver: receiver
        }
      end
    end
  end
end
