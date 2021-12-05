# frozen_string_literal: true

require 'rails_helper'

describe Mutations::Receiver::Delete, type: :request do
  let(:receiver) { create(:receiver) }
  let(:query) do
    <<~GQL
      mutation {
        deleteReceiver (
          input: {
            id: "#{receiver.uuid}"
          }
        ) {
          message
          errors
        }
      }
    GQL
  end

  describe 'delete receiver' do
    subject do
      post '/graphql', params: { query: query }
      parse_graphql_response(response.body)['deleteReceiver']
    end

    it { is_expected.to include 'message' => 'Receiver was deleted' }
    it { is_expected.to include 'errors' => [] }
  end
end
