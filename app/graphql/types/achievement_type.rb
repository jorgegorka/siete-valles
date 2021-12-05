module Types
  class AchievementType < Types::BaseObject
    field :id, String, null: false, method: :uuid
    field :reward, Types::RewardType, null: true
    field :receiver, Types::ReceiverType, null: true
  end
end
