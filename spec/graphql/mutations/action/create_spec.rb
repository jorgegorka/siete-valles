# frozen_string_literal: true

require 'rails_helper'

describe Mutations::Action::Create, type: :request do
  let(:result_info) do
    <<~RESULT
      {
        name
        value
      }
    RESULT
  end
  let(:query) do
    <<~GQL
      mutation {
        createAction (
          #{input_params}
        ) {
          action #{result_info}
          errors
        }
      }
    GQL
  end

  describe 'create action' do
    subject do
      post '/graphql', params: { query: query }
      parse_graphql_response(response.body)['createAction']
    end

    context 'basic input' do
      let(:name) { 'Amorphis' }
      let(:value) { 13 }
      let(:input_params) do
        <<~PARAMS
          input: {
            name: "#{name}"
            value: "#{value}"
          }
        PARAMS
      end

      it { is_expected.to match(a_hash_including('action' => { 'name' => name, 'value' => value })) }
      it { is_expected.to include 'errors' => [] }
    end
  end
end
