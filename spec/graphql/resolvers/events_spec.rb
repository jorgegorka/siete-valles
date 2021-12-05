require 'rails_helper'

describe Resolvers::Events, type: :request do
  let(:find_all) do
    <<~GQL
      query {
        events {
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
        events(name: "#{query_string}") {
          name
        }
      }
    GQL
  end

  let!(:event1) { create(:event, name: 'My Dying Bride') }
  let!(:event2) { create(:event, name: 'Katatonia') }
  let!(:event3) { create(:event, name: 'Volbeat') }

  describe 'events' do
    subject do
      post '/graphql', params: { query: query }
      parse_graphql_response(response.body)['events']
    end

    context 'a generic query' do
      let(:query) { find_all }

      it { is_expected.to match(array_including(a_hash_including('name' => event1.name))) }
      it { is_expected.to match(array_including(a_hash_including('name' => event2.name))) }
      it { is_expected.to match(array_including(a_hash_including('name' => event3.name))) }
    end

    context 'a query with a name' do
      let(:query) { find_by_name }
      let(:query_string) { 'kata' }

      it { is_expected.to_not match(array_including(a_hash_including('name' => event1.name))) }
      it { is_expected.to match(array_including(a_hash_including('name' => event2.name))) }
      it { is_expected.to_not match(array_including(a_hash_including('name' => event3.name))) }
    end
  end
end
