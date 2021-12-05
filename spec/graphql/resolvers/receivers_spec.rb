require 'rails_helper'

describe Resolvers::Receivers, type: :request do
  let(:find_all) do
    <<~GQL
      query {
        receivers {
          externalId
          points
          achievements {
            id
          }
          activities {
            id
          }
        }
      }
    GQL
  end
  let(:find_by_id) do
    <<~GQL
      query {
        receivers(id: "#{query_string}") {
          externalId
        }
      }
    GQL
  end

  let!(:receiver1) { create(:receiver, external_id: 'Baroness') }
  let!(:receiver2) { create(:receiver, external_id: 'Amon Amarth') }
  let!(:receiver3) { create(:receiver, external_id: 'Children of Bodom') }

  describe 'receivers' do
    subject do
      post '/graphql', params: { query: query }
      parse_graphql_response(response.body)['receivers']
    end

    context 'a generic query' do
      let(:query) { find_all }

      it { is_expected.to match(array_including(a_hash_including('externalId' => receiver1.external_id))) }
      it { is_expected.to match(array_including(a_hash_including('externalId' => receiver2.external_id))) }
      it { is_expected.to match(array_including(a_hash_including('externalId' => receiver3.external_id))) }
    end

    context 'a query with an id' do
      let(:query) { find_by_id }
      let(:query_string) { receiver3.uuid }

      it { is_expected.to_not match(array_including(a_hash_including('externalId' => receiver1.external_id))) }
      it { is_expected.to_not match(array_including(a_hash_including('externalId' => receiver2.external_id))) }
      it { is_expected.to match(array_including(a_hash_including('externalId' => receiver3.external_id))) }
    end
  end
end
