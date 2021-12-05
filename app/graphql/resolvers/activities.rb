module Resolvers
  class Activities < Resolvers::Base
    type '[Types::ActivityType]', null: true

    description 'Find all activities or filter by date'
    argument :id, String, required: false, default_value: ''
    argument :starts_at, GraphQL::Types::ISO8601DateTime, required: false, default_value: nil
    argument :ends_at, GraphQL::Types::ISO8601DateTime, required: false, default_value: nil

    def resolve(id:, starts_at:, ends_at:)
      @db_query = Activity
      filter_uuid(id)
      filter_date_range(starts_at, ends_at)

      db_query.order(:created_at)
    end
  end
end
