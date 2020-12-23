# frozen_string_literal: true

module Resolvers
  class Rules < Resolvers::Base
    type '[Types::RuleType]', null: true

    description 'Find all rules or filter by id'
    argument :id, String, required: false, default_value: ''
    argument :available_at, GraphQL::Types::ISO8601DateTime, required: false, default_value: ''

    def resolve(id:, available_at:)
      @db_query = Rule
      filter_uuid(id)
      filter_available(available_at)

      db_query.order(%i[reward_id created_at])
    end

    private

    def filter_available(available_at)
      return if available_at.blank?

      @db_query = db_query.within_period(available_at)
    end
  end
end
