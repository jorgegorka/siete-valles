# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :achievements, resolver: Resolvers::Achievements
    field :actions, resolver: Resolvers::Actions
    field :activities, resolver: Resolvers::Activities
    field :receivers, resolver: Resolvers::Receivers
    field :rewards, resolver: Resolvers::Rewards
    field :rules, resolver: Resolvers::Rules
  end
end
