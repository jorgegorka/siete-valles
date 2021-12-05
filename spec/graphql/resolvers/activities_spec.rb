require 'rails_helper'

describe Resolvers::Activities, type: :request do
  let(:find_all) do
    <<~GQL
      query {
        activities {
          event {
            name
          }
          receiver {
            points
          }
        }
      }
    GQL
  end
  let(:find_by_date_range) do
    <<~GQL
      query {
        activities(startsAt: "#{starts_at}", endsAt: "#{ends_at}") {
          event {
            name
          }
          receiver {
            points
          }
        }
      }
    GQL
  end

  let!(:activity1) { create(:activity) }
  let!(:activity2) { create(:activity) }
  let!(:activity3) { create(:activity, created_at: 12.days.ago) }

  describe 'activities' do
    subject do
      post '/graphql', params: { query: query }
      parse_graphql_response(response.body)['activities']
    end

    context 'a generic query' do
      let(:query) { find_all }

      it { is_expected.to match(array_including(a_hash_including('event' => { 'name' => activity1.event.name }))) }
      it { is_expected.to match(array_including(a_hash_including('event' => { 'name' => activity2.event.name }))) }
      it { is_expected.to match(array_including(a_hash_including('event' => { 'name' => activity3.event.name }))) }
    end

    context 'a query with a date range' do
      let(:query) { find_by_date_range }
      let(:starts_at) { 2.days.ago.beginning_of_day.iso8601 }
      let(:ends_at) { 2.days.from_now.beginning_of_day.iso8601 }

      it { is_expected.to match(array_including(a_hash_including('event' => { 'name' => activity1.event.name }))) }
      it { is_expected.to match(array_including(a_hash_including('event' => { 'name' => activity2.event.name }))) }
      it { is_expected.to_not match(array_including(a_hash_including('event' => { 'name' => activity3.event.name }))) }
    end
  end
end
