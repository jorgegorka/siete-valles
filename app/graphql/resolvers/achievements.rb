# frozen_string_literal: true

module Resolvers
  class Achievements < Resolvers::Base
    type '[Types::AchievementType]', null: true

    description 'Find all achievements or filter by receiver or reward'
    argument :id, String, required: false, default_value: ''
    argument :receiver_id, String, required: false, default_value: ''
    argument :reward_id, String, required: false, default_value: ''

    def resolve(id:, receiver_id:, reward_id:)
      @db_query = Achievement
      filter_uuid(id)
      filter_receiver(receiver_id)
      filter_reward(reward_id)
      
      db_query.order(:created_at)
    end
  end
end
