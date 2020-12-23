# frozen_string_literal: true

module Mutations
  module Reward
    class Delete < Mutations::BaseMutation
      graphql_name 'DeleteReward'

      argument :id, String, required: true

      field :errors, [String], null: true
      field :message, String, null: false

      def resolve(id:)
        reward = Rewards::Persistence.destroy(id)

        if reward.destroyed?
          {
            errors: [],
            message: 'Reward was deleted'
          }
        else
          {
            errors: reward.errors.full_messages,
            message: ''
          }
        end
      end
    end
  end
end
