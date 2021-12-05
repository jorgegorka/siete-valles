module Types
  class ReceiverType < Types::BaseObject
    field :id, String, null: false, method: :uuid
    field :external_id, String, null: false
    field :points, Integer, null: false
    field :achievements, [Types::AchievementType], null: true
    field :activities, [Types::ActivityType], null: true
  end
end
