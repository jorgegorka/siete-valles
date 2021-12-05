# frozen_string_literal: true

require 'rails_helper'

describe Mutations::Event::Update, type: :request do
  let(:event) { create(:event) }
  let(:query) do
    <<~GQL
      mutation {
        updateEvent (
          input: {
            id: "#{event.uuid}"
            name: "Wintersun"
            value: 93
          }
        ) {
          event {
            name
            value
          }
          errors
        }
      }
    GQL
  end

  describe 'update_event' do
    subject do
      post '/graphql', params: { query: query }
      parse_graphql_response(response.body)['updateEvent']['event']
    end

    it { is_expected.to include 'name' => 'Wintersun' }
    it { is_expected.to include 'value' => 93 }
  end
end
