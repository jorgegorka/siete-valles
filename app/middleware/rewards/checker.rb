module Rewards
  class Checker
    attr_reader :reward, :activity

    class << self
      def acquired(activity)
        Reward.active.excluding_ids(activity.receiver.reward_ids).all.map { |reward| new(reward, activity).achieved }.compact
      end
    end

    def initialize(reward, activity)
      @reward = reward
      @activity = activity
    end

    def achieved
      valid = rules.any? { |rule| Rules::Checker.new(rule, receiver).apply? }

      valid ? reward : nil
    end

    private

    def receiver
      activity.receiver
    end

    def rules
      reward.rules.within_period(activity.created_at)
    end
  end
end
