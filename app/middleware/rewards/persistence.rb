module Rewards
  class Persistence
    class << self
      def create(params)
        Reward.create(params)
      end

      def update(params)
        reward = Reward.find_by(uuid: params.delete(:id))
        reward.update(params)

        reward
      end

      def destroy(reward_uuid)
        reward = Reward.find_by(uuid: reward_uuid)
        reward.destroy

        reward
      end
  end
  end
end
