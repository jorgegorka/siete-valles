module Mutations
  module Rule
    class Update < Mutations::BaseMutation
      graphql_name 'UpdateRule'

      argument :id, String, required: true
      argument :name, String, required: false
      argument :reward_id, String, required: false
      argument :starts_at, GraphQL::Types::ISO8601DateTime, required: false
      argument :ends_at, GraphQL::Types::ISO8601DateTime, required: false

      field :errors, [String], null: true
      field :rule, Types::RuleType, null: true

      def resolve(params)
        rule = Rules::Persistence.update(params)

        {
          errors: rule.errors.full_messages,
          rule: rule
        }
      end
    end
  end
end
