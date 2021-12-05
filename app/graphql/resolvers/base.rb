# frozen_string_literal: true

module Resolvers
  class Base < GraphQL::Schema::Resolver
    attr_reader :db_query

    include Resolvers::QueryFinders
  end
end
