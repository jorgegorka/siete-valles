# frozen_string_literal: true

module Resolvers
  module QueryFinders
    def filter_uuid(uuid)
      return if uuid.blank?

      @db_query = db_query.where(uuid: uuid)
    end

    def filter_name(name)
      return db_query if name.blank?

      @db_query = db_query.where('NAME LIKE ?', "%#{name}%")
    end

    def filter_date_range(starts_at, ends_at)
      return db_query if starts_at.blank? && ends_at.blank?

      @db_query = db_query.where(created_at: starts_at..ends_at)
    end

    def filter_receiver(receiver_id)
      return if receiver_id.blank?

      @db_query = db_query.includes(:receiver).where(receivers: { uuid: receiver_id })
    end

    def filter_reward(reward_id)
      return if reward_id.blank?

      @db_query = db_query.includes(:reward).where(rewards: { uuid: reward_id })
    end
  end
end
