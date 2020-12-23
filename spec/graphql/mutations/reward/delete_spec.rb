# frozen_string_literal: true

require 'rails_helper'

describe Mutations::Reward::Delete, type: :request do
  let(:reward) { create(:reward) }
  let(:query) do
    <<~GQL
      mutation {
        deleteReward (
          input: {
            id: "#{reward.uuid}"
          }
        ) {
          message
          errors
        }
      }
    GQL
  end

  describe 'delete reward' do
    subject do
      post '/graphql', params: { query: query }
      parse_graphql_response(response.body)['deleteReward']
    end

    it { is_expected.to include 'message' => 'Reward was deleted' }
    it { is_expected.to include 'errors' => [] }
  end
end
