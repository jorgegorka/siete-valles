# frozen_string_literal: true

require 'rails_helper'

describe ActivitiesController do
  describe '#index' do
    subject { get :index }

    it { is_expected.to have_http_status :success }
  end
end
