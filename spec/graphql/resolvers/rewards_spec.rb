# frozen_string_literal: true

require 'rails_helper'

describe Resolvers::Rewards, type: :request do
  let(:find_all) do
    <<~GQL
      query {
        rewards {
          name
          imageUrl
          rules {
            id
          }
          achievements{
            id
          }
        }
      }
    GQL
  end
  let(:find_by_name) do
    <<~GQL
      query {
        rewards(name: "#{query_string}") {
          name
        }
      }
    GQL
  end
  let(:find_by_active) do
    <<~GQL
      query {
        rewards(active: #{query_string}) {
          name
        }
      }
    GQL
  end

  let!(:reward1) { create(:reward, name: 'My Dying Bride') }
  let!(:reward2) { create(:reward, name: 'Katatonia') }
  let!(:reward3) { create(:reward, name: 'Volbeat') }
  let!(:reward4) { create(:reward, name: 'Deep Purple', active: false) }

  describe 'rewards' do
    subject do
      post '/graphql', params: { query: query }
      parse_graphql_response(response.body)['rewards']
    end

    context 'a generic query' do
      let(:query) { find_all }

      it { is_expected.to match(array_including(a_hash_including('name' => reward1.name))) }
      it { is_expected.to match(array_including(a_hash_including('name' => reward2.name))) }
      it { is_expected.to match(array_including(a_hash_including('name' => reward3.name))) }
    end

    context 'a query with a name' do
      let(:query) { find_by_name }
      let(:query_string) { 'bri' }

      it { is_expected.to match(array_including(a_hash_including('name' => reward1.name))) }
      it { is_expected.to_not match(array_including(a_hash_including('name' => reward2.name))) }
      it { is_expected.to_not match(array_including(a_hash_including('name' => reward3.name))) }
    end

    context 'a query with active' do
      let(:query) { find_by_active }
      let(:query_string) { false }

      it { is_expected.to_not match(array_including(a_hash_including('name' => reward1.name))) }
      it { is_expected.to_not match(array_including(a_hash_including('name' => reward2.name))) }
      it { is_expected.to_not match(array_including(a_hash_including('name' => reward3.name))) }
      it { is_expected.to match(array_including(a_hash_including('name' => reward4.name))) }
    end
  end
end
