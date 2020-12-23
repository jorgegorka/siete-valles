# frozen_string_literal: true

require 'rails_helper'

describe Mutations::Reward::Update, type: :request do
  let(:reward) { create(:reward) }
  let(:query) do
    <<~GQL
      mutation {
        updateReward (
          input: {
            id: "#{reward.uuid}"
            name: "Wintersun"
            category: "level"
          }
        ) {
          reward {
            name
            category
          }
          errors
        }
      }
    GQL
  end

  describe 'update_reward' do
    subject do
      post '/graphql', params: { query: query }
      parse_graphql_response(response.body)['updateReward']['reward']
    end

    it { is_expected.to include 'name' => 'Wintersun' }
    it { is_expected.to include 'category' => 'level' }
  end
end
