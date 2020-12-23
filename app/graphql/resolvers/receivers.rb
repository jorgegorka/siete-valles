# frozen_string_literal: true

module Resolvers
  class Receivers < Resolvers::Base
    type '[Types::ReceiverType]', null: true

    description 'Find all receivers or filter by id'
    argument :id, String, required: false, default_value: ''

    def resolve(id:)
      @db_query = Receiver
      filter_uuid(id)

      db_query.order(:points)
    end
  end
end
