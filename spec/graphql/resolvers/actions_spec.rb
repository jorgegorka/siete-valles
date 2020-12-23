# frozen_string_literal: true

require 'rails_helper'

describe Resolvers::Actions, type: :request do
  let(:find_all) do
    <<~GQL
      query {
        actions {
          name
          value
          activities {
            id
          }
        }
      }
    GQL
  end
  let(:find_by_name) do
    <<~GQL
      query {
        actions(name: "#{query_string}") {
          name
        }
      }
    GQL
  end

  let!(:action1) { create(:action, name: 'My Dying Bride') }
  let!(:action2) { create(:action, name: 'Katatonia') }
  let!(:action3) { create(:action, name: 'Volbeat') }

  describe 'actions' do
    subject do
      post '/graphql', params: { query: query }
      parse_graphql_response(response.body)['actions']
    end

    context 'a generic query' do
      let(:query) { find_all }

      it { is_expected.to match(array_including(a_hash_including('name' => action1.name))) }
      it { is_expected.to match(array_including(a_hash_including('name' => action2.name))) }
      it { is_expected.to match(array_including(a_hash_including('name' => action3.name))) }
    end

    context 'a query with a name' do
      let(:query) { find_by_name }
      let(:query_string) { 'kata' }

      it { is_expected.to_not match(array_including(a_hash_including('name' => action1.name))) }
      it { is_expected.to match(array_including(a_hash_including('name' => action2.name))) }
      it { is_expected.to_not match(array_including(a_hash_including('name' => action3.name))) }
    end
  end
end
