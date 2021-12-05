module Resolvers
  class Events < Resolvers::Base
    type '[Types::EventType]', null: true

    description 'Find all events or filter by name'
    argument :id, String, required: false, default_value: ''
    argument :name, String, required: false, default_value: ''

    def resolve(id:, name:)
      @db_query = Event
      filter_uuid(id)
      filter_name(name)

      db_query.order(:created_at)
    end
  end
end
