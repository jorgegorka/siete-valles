module Types
  class ActivityType < Types::BaseObject
    field :id, String, null: false, method: :uuid
    field :value, Integer, null: false
    field :receiver, Types::ReceiverType, null: false
    field :event, Types::EventType, null: false
  end
end
