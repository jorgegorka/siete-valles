# frozen_string_literal: true

module Shared
  module Finders
    private

    def find_receiver(receiver_id)
      Receiver.find_by(uuid: receiver_id)
    end

    def find_reward(reward_id)
      Reward.find_by(uuid: reward_id)
    end

    def find_action(action_id)
      Action.find_by(uuid: action_id)
    end
  end
end
