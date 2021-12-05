# frozen_string_literal: true

require 'rails_helper'

describe Mutations::Event::Delete, type: :request do
  let(:event) { create(:event) }
  let(:event_uuid) { event.uuid }
  let(:query) do
    <<~GQL
      mutation { 
        deleteEvent (
          input: {
            id: "#{event_uuid}"
          }
        ) {
          message
          errors
        }
      }
    GQL
  end

  describe 'delete event' do
    subject do
      post '/graphql', params: { query: query }
      parse_graphql_response(response.body)['deleteEvent']
    end

    it { is_expected.to include 'message' => 'Event was deleted' }
    it { is_expected.to include 'errors' => [] }
  end
end
