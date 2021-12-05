module Achievements
  class Checker
    attr_reader :activity

    def initialize(activity)
      @activity = activity
    end

    def new_rewards
      rewards.each do |reward|
        Achievements::Persistence.create(
          reward_id: reward.uuid,
          receiver_id: activity.receiver.external_id
        )
      end
    end

    private

    def rewards
      @rewards ||= Rewards::Checker.acquired(activity)
    end
  end
end
