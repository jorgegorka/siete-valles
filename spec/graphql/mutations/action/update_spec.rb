# frozen_string_literal: true

require 'rails_helper'

describe Mutations::Action::Update, type: :request do
  let(:action) { create(:action) }
  let(:query) do
    <<~GQL
      mutation {
        updateAction (
          input: {
            id: "#{action.uuid}"
            name: "Wintersun"
            value: 93
          }
        ) {
          action {
            name
            value
          }
          errors
        }
      }
    GQL
  end

  describe 'update_action' do
    subject do
      post '/graphql', params: { query: query }
      parse_graphql_response(response.body)['updateAction']['action']
    end

    it { is_expected.to include 'name' => 'Wintersun' }
    it { is_expected.to include 'value' => 93 }
  end
end
