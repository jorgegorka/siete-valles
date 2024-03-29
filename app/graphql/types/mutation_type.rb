module Types
  class MutationType < Types::BaseObject
    field :create_receiver, mutation: Mutations::Receiver::Create
    field :update_receiver, mutation: Mutations::Receiver::Update
    field :delete_receiver, mutation: Mutations::Receiver::Delete
    field :create_activity, mutation: Mutations::Activity::Create
    field :create_event, mutation: Mutations::Event::Create
    field :update_event, mutation: Mutations::Event::Update
    field :delete_event, mutation: Mutations::Event::Delete
    field :create_reward, mutation: Mutations::Reward::Create
    field :update_reward, mutation: Mutations::Reward::Update
    field :delete_reward, mutation: Mutations::Reward::Delete
    field :create_rule, mutation: Mutations::Rule::Create
    field :update_rule, mutation: Mutations::Rule::Update
    field :delete_rule, mutation: Mutations::Rule::Delete
    field :create_condition, mutation: Mutations::Condition::Create
    field :update_condition, mutation: Mutations::Condition::Update
    field :delete_condition, mutation: Mutations::Condition::Delete
  end
end
