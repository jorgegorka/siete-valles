# frozen_string_literal: true

require 'rails_helper'

describe Mutations::Rule::Delete, type: :request do
  let(:rule) { create(:rule) }
  let(:query) do
    <<~GQL
      mutation {
        deleteRule (
          input: {
            id: "#{rule.uuid}"
          }
        ) {
          message
          errors
        }
      }
    GQL
  end

  describe 'delete rule' do
    subject do
      post '/graphql', params: { query: query }
      parse_graphql_response(response.body)['deleteRule']
    end

    it { is_expected.to include 'message' => 'Rule was deleted' }
    it { is_expected.to include 'errors' => [] }
  end
end
