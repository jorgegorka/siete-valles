# frozen_string_literal: true

require 'rails_helper'

describe AchievementsController do
  describe '#index' do
    subject { get :index }

    it { is_expected.to have_http_status :success }
  end
end
