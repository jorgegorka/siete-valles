# frozen_string_literal: true

require 'rails_helper'

describe Resolvers::Achievements, type: :request do
  let(:find_all) do
    <<~GQL
      query {
        achievements {
          receiver {
            externalId
            points
          }
          reward {
            name
          }
        }
      }
    GQL
  end
  let(:find_by_receiver) do
    <<~GQL
      query {
        achievements(receiverId: "#{query_string}") {
          id
          receiver {
            externalId
            points
          }
        }
      }
    GQL
  end
  let(:find_by_reward) do
    <<~GQL
      query {
        achievements(rewardId: "#{query_string}") {
          id
          receiver {
            externalId
            points
          }
        }
      }
    GQL
  end

  let!(:achievement1) { create(:achievement) }
  let!(:achievement2) { create(:achievement) }
  let!(:achievement3) { create(:achievement) }

  describe 'achievements' do
    subject do
      post '/graphql', params: { query: query }
      parse_graphql_response(response.body)['achievements']
    end

    context 'a generic query' do
      let(:query) { find_all }

      it { is_expected.to match(array_including(a_hash_including('receiver' => { 'externalId' => achievement1.receiver.external_id, 'points' => achievement1.receiver.points }))) }
      it { is_expected.to match(array_including(a_hash_including('receiver' => { 'externalId' => achievement2.receiver.external_id, 'points' => achievement2.receiver.points }))) }
      it { is_expected.to match(array_including(a_hash_including('receiver' => { 'externalId' => achievement3.receiver.external_id, 'points' => achievement3.receiver.points }))) }
    end

    context 'a query with a receiver' do
      let(:query) { find_by_receiver }
      let(:query_string) { achievement1.receiver.uuid }

      it { is_expected.to match(array_including(a_hash_including('receiver' => { 'externalId' => achievement1.receiver.external_id, 'points' => achievement1.receiver.points }))) }
      it { is_expected.to_not match(array_including(a_hash_including('receiver' => { 'externalId' => achievement2.receiver.external_id, 'points' => achievement2.receiver.points }))) }
      it { is_expected.to_not match(array_including(a_hash_including('receiver' => { 'externalId' => achievement3.receiver.external_id, 'points' => achievement3.receiver.points }))) }
    end

    context 'a query with a reward' do
      let(:query) { find_by_reward }
      let(:query_string) { achievement3.reward.uuid }

      it { is_expected.to_not match(array_including(a_hash_including('receiver' => { 'externalId' => achievement1.receiver.external_id, 'points' => achievement1.receiver.points }))) }
      it { is_expected.to_not match(array_including(a_hash_including('receiver' => { 'externalId' => achievement2.receiver.external_id, 'points' => achievement2.receiver.points }))) }
      it { is_expected.to match(array_including(a_hash_including('receiver' => { 'externalId' => achievement3.receiver.external_id, 'points' => achievement3.receiver.points }))) }
    end
  end
end
