# frozen_string_literal: true

require 'rails_helper'

describe Mutations::Receiver::Create, type: :request do
  let(:result_info) do
    <<~RESULT
      {
        externalId
        points
      }
    RESULT
  end
  let(:query) do
    <<~GQL
      mutation {
        createReceiver (
          #{input_params}
        ) {
          receiver #{result_info}
          errors
        }
      }
    GQL
  end

  describe 'create receiver' do
    subject do
      post '/graphql', params: { query: query }
      parse_graphql_response(response.body)['createReceiver']
    end

    context 'basic input' do
      let(:externalId) { 'MonoInc' }
      let(:category) { :badge }
      let(:input_params) do
        <<~PARAMS
          input: {
            externalId: "#{externalId}"
          }
        PARAMS
      end

      it { is_expected.to match(a_hash_including('receiver' => { 'externalId' => externalId, 'points' => 0 })) }
      it { is_expected.to include 'errors' => [] }
    end
  end
end
