# frozen_string_literal: true

require 'rails_helper'

describe Mutations::Receiver::Update, type: :request do
  let(:receiver) { create(:receiver) }
  let(:query) do
    <<~GQL
      mutation {
        updateReceiver (
          input: {
            id: "#{receiver.uuid}"
            externalId: "DarkTranquility"
            points: 456
          }
        ) {
          receiver {
            externalId
            points
          }
          errors
        }
      }
    GQL
  end

  describe 'update_receiver' do
    subject do
      post '/graphql', params: { query: query }
      parse_graphql_response(response.body)['updateReceiver']['receiver']
    end

    it { is_expected.to include 'externalId' => 'DarkTranquility' }
    it { is_expected.to include 'points' => 456 }
  end
end
