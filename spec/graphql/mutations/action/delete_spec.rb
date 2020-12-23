# frozen_string_literal: true

require 'rails_helper'

describe Mutations::Action::Delete, type: :request do
  let(:action) { create(:action) }
  let(:action_uuid) { action.uuid }
  let(:query) do
    <<~GQL
      mutation {
        deleteAction (
          input: {
            id: "#{action_uuid}"
          }
        ) {
          message
          errors
        }
      }
    GQL
  end

  describe 'delete action' do
    subject do
      post '/graphql', params: { query: query }
      parse_graphql_response(response.body)['deleteAction']
    end

    it { is_expected.to include 'message' => 'Action was deleted' }
    it { is_expected.to include 'errors' => [] }
  end
end
