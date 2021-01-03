# frozen_string_literal: true

module Shared
  module Finders
    private

    def find_receiver(receiver_id)
      Receiver.find_or_create_by(external_id: receiver_id)
    end

    def find_reward(reward_id)
      Reward.find_by(uuid: reward_id)
    end

    def find_event(event_id)
      Event.find_by(uuid: event_id)
    end
  end
end
