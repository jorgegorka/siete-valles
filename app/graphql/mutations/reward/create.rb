module Mutations
  module Reward
    class Create < Mutations::BaseMutation
      graphql_name 'CreateReward'

      argument :name, String, required: true
      argument :category, String, required: true

      field :errors, [String], null: true
      field :reward, Types::RewardType, null: true

      def resolve(params)
        reward = Rewards::Persistence.create(params)

        {
          reward: reward,
          errors: reward.errors.full_messages
        }
      end
    end
  end
end
