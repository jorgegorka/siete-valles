# frozen_string_literal: true

require 'rails_helper'

describe Mutations::Rule::Update, type: :request do
  let(:reward) { create(:reward) }
  let(:starts_at) { 4.days.from_now.beginning_of_day.iso8601 }
  let(:ends_at) { 14.days.from_now.end_of_day.iso8601 }
  let(:rule) { create(:rule) }
  let(:query) do
    <<~GQL
      mutation {
        updateRule (
          input: {
            id: "#{rule.uuid}"
            rewardId: "#{reward.uuid}"
            startsAt: "#{starts_at}"
            endsAt: "#{ends_at}"
          }
        ) {
          rule {
            reward {
              id
            }
            startsAt
            endsAt
          }
          errors
        }
      }
    GQL
  end

  describe 'update_rule' do
    subject do
      post '/graphql', params: { query: query }
      parse_graphql_response(response.body)['updateRule']['rule']
    end

    it { is_expected.to include 'reward' => { 'id' => reward.uuid } }
    it { is_expected.to include 'startsAt' => starts_at }
    it { is_expected.to include 'endsAt' => ends_at }
  end
end
