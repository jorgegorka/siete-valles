# frozen_string_literal: true

module Mutations
  module Activity
    class Create < Mutations::BaseMutation
      graphql_name 'CreateActivity'

      argument :receiver_id, String, required: true
      argument :event_id, String, required: true

      field :errors, [String], null: true
      field :activity, Types::ActivityType, null: true

      def resolve(params)
        activity = Activities::Persistence.create(params)

        {
          activity: activity,
          errors: activity.errors.full_messages
        }
      end
    end
  end
end
