# frozen_string_literal: true

module Resolvers
  class Rewards < Resolvers::Base
    type '[Types::RewardType]', null: true

    description 'Find all rewards or filter by name or active status'
    argument :id, String, required: false, default_value: ''
    argument :name, String, required: false, default_value: ''
    argument :active, Boolean, required: false, default_value: true

    def resolve(id:, name:, active:)
      @db_query = Reward
      filter_uuid(id)
      filter_name(name)
      filter_active(active)

      db_query.order(:name)
    end

    private

    def filter_active(active)
      @db_query = db_query.where(active: active)
    end
  end
end
