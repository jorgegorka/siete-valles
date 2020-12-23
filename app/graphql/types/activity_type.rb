# frozen_string_literal: true

module Types
  class ActivityType < Types::BaseObject
    field :id, String, null: false, method: :uuid
    field :receiver, Types::ReceiverType, null: false
    field :action, Types::ActionType, null: false
  end
end
