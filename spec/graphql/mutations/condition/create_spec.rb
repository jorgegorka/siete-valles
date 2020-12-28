# frozen_string_literal: true

require 'rails_helper'

describe Mutations::Condition::Create, type: :request do
  let(:result_info) do
    <<~RESULT
      {
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
    RESULT
  end
  let(:query) do
    <<~GQL
      mutation {
        createCondition (
          #{input_params}
        ) {
          condition #{result_info}
          errors
        }
      }
    GQL
  end

  describe 'create condition' do
    subject do
      post '/graphql', params: { query: query }
      parse_graphql_response(response.body)['createCondition']
    end

    context 'basic input' do
      let(:rule) { create(:rule) }
      let(:event) { create(:event) }
      let(:operation) { :points }
      let(:expression) { :lt }
      let(:value) { 72 }
      let(:input_params) do
        <<~PARAMS
          input: {
            ruleId: "#{rule.uuid}"
            eventId: "#{event.uuid}"
            operation: "#{operation}"
            expression: "#{expression}"
            value: #{value}
          }
        PARAMS
      end

      it { is_expected.to match(a_hash_including('condition' => { 'rule' => { 'id' => rule.uuid }, 'event' => { 'id' => event.uuid }, 'operation' => operation.to_s, 'expression' => expression.to_s, 'value' => value })) }
      it { is_expected.to include 'errors' => [] }
    end
  end
end
