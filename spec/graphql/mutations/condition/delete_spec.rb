# frozen_string_literal: true

require 'rails_helper'

describe Mutations::Condition::Delete, type: :request do
  let(:condition) { create(:condition) }
  let(:rule_id) { condition.rule.uuid }
  let(:query) do
    <<~GQL
      mutation {
        deleteCondition (
          input: {
            ruleId: "#{rule_id}"
            id: "#{condition.uuid}"
          }
        ) {
          message
          errors
        }
      }
    GQL
  end

  describe 'delete condition' do
    subject do
      post '/graphql', params: { query: query }
      parse_graphql_response(response.body)['deleteCondition']
    end

    it { is_expected.to match(a_hash_including('message' => 'Condition was deleted')) }
    it { is_expected.to match(a_hash_including('errors' => [])) }
  end
end
