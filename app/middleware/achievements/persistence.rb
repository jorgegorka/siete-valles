# frozen_string_literal: true

module Achievements
  class Persistence
    extend Shared::Finders

    class << self
      def create(params)
        receiver = find_receiver(params.delete(:receiver_id))
        reward = find_reward(params.delete(:reward_id))
        receiver.achievements.create(reward: reward)
      end

      def update(_params)
        raise Exceptions::OperationNotAllowed
      end

      def destroy(params)
        achievement = Achievement.find_by(uuid: params[:id])
        achievement.destroy
      end
    end
  end
end
