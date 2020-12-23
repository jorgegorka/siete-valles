# frozen_string_literal: true

require 'rails_helper'

describe Mutations::Condition::Update, type: :request do
  let(:action) { create(:action) }
  let(:operation) { :points }
  let(:expression) { :lt }
  let(:value) { 72 }
  let(:condition) { create(:condition) }
  let(:rule_id) { condition.rule.uuid }
  let(:query) do
    <<~GQL
      mutation {
        updateCondition (
          input: {
            ruleId: "#{rule_id}"
            id: "#{condition.uuid}"
            actionId: "#{action.uuid}"
            operation: "#{operation}"
            expression: "#{expression}"
            value: #{value}
          }
        ) {
          condition {
            rule {
              id
            }
            action {
              id
            }
            operation
            expression
            value
          }
          errors
        }
      }
    GQL
  end

  describe 'update_condition' do
    subject do
      post '/graphql', params: { query: query }
      parse_graphql_response(response.body)['updateCondition']['condition']
    end

    it { is_expected.to include 'action' => { 'id' => action.uuid } }
    it { is_expected.to include 'operation' => operation.to_s }
    it { is_expected.to include 'expression' => expression.to_s }
    it { is_expected.to include 'value' => value }
  end
end
