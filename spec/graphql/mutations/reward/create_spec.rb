# frozen_string_literal: true

require 'rails_helper'

describe Mutations::Reward::Create, type: :request do
  let(:result_info) do
    <<~RESULT
      {
        name
        category
      }
    RESULT
  end
  let(:query) do
    <<~GQL
      mutation {
        createReward (
          #{input_params}
        ) {
          reward #{result_info}
          errors
        }
      }
    GQL
  end

  describe 'create reward' do
    subject do
      post '/graphql', params: { query: query }
      parse_graphql_response(response.body)['createReward']
    end

    context 'basic input' do
      let(:name) { 'Les Discretes' }
      let(:category) { :badge }
      let(:input_params) do
        <<~PARAMS
          input: {
            name: "#{name}"
            category: "#{category}"
          }
        PARAMS
      end

      it { is_expected.to match(a_hash_including('reward' => { 'name' => name, 'category' => category.to_s })) }
      it { is_expected.to include 'errors' => [] }
    end
  end
end
