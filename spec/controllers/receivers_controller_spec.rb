# frozen_string_literal: true

require 'rails_helper'

describe ReceiversController do
  describe '#index' do
    subject { get :index }

    it { is_expected.to have_http_status :success }
  end

  describe '#show' do
    let(:receiver) { create(:receiver) }

    subject { get :show, params: { id: receiver.uuid } }

    it { is_expected.to have_http_status :success }
  end
end
