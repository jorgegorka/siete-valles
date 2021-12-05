module Types
  class EventType < Types::BaseObject
    field :id, String, null: false, method: :uuid
    field :name, String, null: false
    field :value, Integer, null: false
    field :activities, [Types::ActivityType], null: true
  end
end
