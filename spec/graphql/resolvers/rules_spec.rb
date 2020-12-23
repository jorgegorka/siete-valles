# frozen_string_literal: true

require 'rails_helper'

describe Resolvers::Rules, type: :request do
  let(:find_all) do
    <<~GQL
      query {
        rules {
          reward {
            name
          }
          conditions {
            id
          }
        }
      }
    GQL
  end
  let(:find_by_id) do
    <<~GQL
      query {
        rules(id: "#{query_string}") {
          id
        }
      }
    GQL
  end

  let!(:rule1) { create(:rule) }
  let!(:rule2) { create(:rule) }
  let!(:rule3) { create(:rule) }

  describe 'rules' do
    subject do
      post '/graphql', params: { query: query }
      parse_graphql_response(response.body)['rules']
    end

    context 'a generic query' do
      let(:query) { find_all }

      it { is_expected.to match(array_including(a_hash_including('reward' => { 'name' => rule1.reward.name }))) }
      it { is_expected.to match(array_including(a_hash_including('reward' => { 'name' => rule2.reward.name }))) }
      it { is_expected.to match(array_including(a_hash_including('reward' => { 'name' => rule3.reward.name }))) }
    end

    context 'a query with an id' do
      let(:query) { find_by_id }
      let(:query_string) { rule2.uuid }

      it { is_expected.to_not match(array_including(a_hash_including('id' => rule1.uuid))) }
      it { is_expected.to match(array_including(a_hash_including('id' => rule2.uuid))) }
      it { is_expected.to_not match(array_including(a_hash_including('id' => rule3.uuid))) }
    end
  end
end
