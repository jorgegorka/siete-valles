# frozen_string_literal: true

module Rules
  class Persistence
    class << self
      def create(params)
        reward = find_reward(params.delete(:reward_id))
        reward.rules.create(params)
      end

      def update(params)
        rule = Rule.find_by(uuid: params.delete(:id))
        if params[:reward_id].present?
          reward = find_reward(params.delete(:reward_id))
          rule.reward_id = reward.id
        end
        rule.update(params)

        rule
      end

      def destroy(rule_uuid)
        rule = Rule.find_by(uuid: rule_uuid)
        rule.destroy
      end

      private

      def find_reward(reward_id)
        Reward.find_by(uuid: reward_id)
      end
    end
  end
end
