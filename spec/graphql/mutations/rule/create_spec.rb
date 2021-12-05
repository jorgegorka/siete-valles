# frozen_string_literal: true

require 'rails_helper'

describe Mutations::Rule::Create, type: :request do
  let(:result_info) do
    <<~RESULT
      {
        reward {
          id
        }
        startsAt
        endsAt
      }
    RESULT
  end
  let(:query) do
    <<~GQL
      mutation {
        createRule (
          #{input_params}
        ) {
          rule #{result_info}
          errors
        }
      }
    GQL
  end

  describe 'create rule' do
    subject do
      post '/graphql', params: { query: query }
      parse_graphql_response(response.body)['createRule']
    end

    context 'basic input' do
      let(:reward) { create(:reward) }
      let(:starts_at) { 4.days.from_now.beginning_of_day.iso8601 }
      let(:ends_at) { 14.days.from_now.end_of_day.iso8601 }
      let(:name) { 'Myrkur' }
      let(:input_params) do
        <<~PARAMS
          input: {
            name: "#{name}"
            rewardId: "#{reward.uuid}"
            startsAt: "#{starts_at}"
            endsAt: "#{ends_at}"
          }
        PARAMS
      end

      it { is_expected.to match(a_hash_including('rule' => { 'reward' => { 'id' => reward.uuid }, 'startsAt' => starts_at, 'endsAt' => ends_at })) }
      it { is_expected.to include 'errors' => [] }
    end
  end
end
