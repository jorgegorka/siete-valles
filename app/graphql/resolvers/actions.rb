# frozen_string_literal: true

module Resolvers
  class Actions < Resolvers::Base
    type '[Types::ActionType]', null: true

    description 'Find all actions or filter by name'
    argument :id, String, required: false, default_value: ''
    argument :name, String, required: false, default_value: ''

    def resolve(id:, name:)
      @db_query = Action
      filter_uuid(id)
      filter_name(name)

      db_query.order(:created_at)
    end
  end
end
