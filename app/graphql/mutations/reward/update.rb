# frozen_string_literal: true

module Mutations
  module Reward
    class Update < Mutations::BaseMutation
      graphql_name 'UpdateReward'

      argument :id, String, required: true
      argument :name, String, required: true
      argument :category, String, required: true

      field :errors, [String], null: true
      field :reward, Types::RewardType, null: true

      def resolve(params)
        reward = Rewards::Persistence.update(params)

        {
          errors: reward.errors.full_messages,
          reward: reward
        }
      end
    end
  end
end
