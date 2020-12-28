# frozen_string_literal: true

require 'rails_helper'

describe Mutations::Activity::Create, type: :request do
  let(:result_info) do
    <<~RESULT
      {
        receiver {
          externalId
        }
        event {
          id
        }
      }
    RESULT
  end
  let(:query) do
    <<~GQL
      mutation {
        createActivity (
          #{input_params}
        ) {
          activity #{result_info}
          errors
        }
      }
    GQL
  end

  describe 'create activity' do
    subject do
      post '/graphql', params: { query: query }
      parse_graphql_response(response.body)['createActivity']
    end

    context 'basic input' do
      let(:receiver) { create(:receiver) }
      let(:event) { create(:event) }
      let(:input_params) do
        <<~PARAMS
          input: {
            receiverId: "#{receiver.uuid}"
            eventId: "#{event.uuid}"
          }
        PARAMS
      end

      it { is_expected.to match(a_hash_including('activity' => a_hash_including('event' => { 'id' => event.uuid }))) }
      it { is_expected.to match(a_hash_including('activity' => a_hash_including('receiver' => { 'externalId' => receiver.external_id }))) }
      it { is_expected.to include 'errors' => [] }
    end
  end
end
