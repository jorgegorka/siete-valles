# frozen_string_literal: true

require 'rails_helper'

describe Mutations::Condition::Update, type: :request do
  let(:event) { create(:event) }
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
            eventId: "#{event.uuid}"
            operation: "#{operation}"
            expression: "#{expression}"
            value: #{value}
          }
        ) {
          condition {
            rule {
              id
            }
            event {
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

    it { is_expected.to include 'event' => { 'id' => event.uuid } }
    it { is_expected.to include 'operation' => operation.to_s }
    it { is_expected.to include 'expression' => expression.to_s }
    it { is_expected.to include 'value' => value }
  end
end
