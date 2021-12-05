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
        value
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
            receiverId: "#{receiver.external_id}"
            eventId: "#{event.uuid}"
          }
        PARAMS
      end



        it { is_expected.to match(a_hash_including('activity' => a_hash_including('event' => { 'id' => event.uuid }))) }
        it { is_expected.to match(a_hash_including('activity' => a_hash_including('receiver' => { 'externalId' => receiver.external_id }))) }
        it { is_expected.to match(a_hash_including('activity' => a_hash_including('value' => event.value))) }
        it { is_expected.to include 'errors' => [] }


      context 'when receiver does not exist' do
        let(:visitor_id) { "new_visitor" }
        let(:input_params) do
          <<~PARAMS
            input: {      
              receiverId: "#{visitor_id}"
              eventId: "#{event.uuid}"  
            }
          PARAMS
        end

        it { is_expected.to match(a_hash_including('activity' => a_hash_including('event' => { 'id' => event.uuid }))) }
        it { is_expected.to match(a_hash_including('activity' => a_hash_including('receiver' => { 'externalId' => visitor_id }))) }
        it { is_expected.to match(a_hash_including('activity' => a_hash_including('value' => event.value))) }
        it { is_expected.to include 'errors' => [] }
      end

      context 'when value is set' do
        let(:value) { 42 }
        let(:input_params) do
          <<~PARAMS
            input: {  
              receiverId: "#{receiver.external_id}"
              eventId: "#{event.uuid}"
              value: #{value}
            }
          PARAMS
        end

        it { is_expected.to match(a_hash_including('activity' => a_hash_including('event' => { 'id' => event.uuid }))) }
        it { is_expected.to match(a_hash_including('activity' => a_hash_including('receiver' => { 'externalId' => receiver.external_id }))) }
        it { is_expected.to match(a_hash_including('activity' => a_hash_including('value' => value))) }
        it { is_expected.to include 'errors' => [] }
      end
    end
  end
end
