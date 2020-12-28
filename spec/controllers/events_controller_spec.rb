# frozen_string_literal: true

require 'rails_helper'

describe EventsController do
  let(:name) { 'download pdf' }
  let(:category) { :badge }
  let(:params) do
    {
      event: {
        name: name,
        description: 'PDF downloaded from the docs area',
        value: 4
      }
    }
  end

  describe '#new' do
    subject { get :new }

    it { is_expected.to have_http_status :success }
  end

  describe '#create' do
    subject { post :create, params: params }

    it { is_expected.to have_http_status :redirect }

    it { expect { subject }.to change { Event.count }.by(1) }

    context 'new event' do
      let(:new_event) { Event.find_by(name: name) }

      before { subject }

      it { expect(new_event.name).to eql name }
      it { expect(new_event.value).to eql 4 }
    end
  end

  describe '#edit' do
    let(:event) { create(:event) }
    let(:params) { { id: event.uuid } }

    subject { get :new, params: params }

    it { is_expected.to have_http_status :success }
  end

  describe '#update' do
    let(:event) { create(:event) }
    let(:name) { 'Mono Inc.' }
    let(:event_uuid) { event.uuid }
    let(:params) { { id: event_uuid, event: { name: name, value: 33 } } }

    subject { put :update, params: params }

    it { is_expected.to have_http_status :redirect }

    context 'updated event' do
      let(:updated_event) { Event.find_by(name: name) }

      before { subject }

      it { expect(updated_event.name).to eql name }

      it { expect(updated_event.value).to eql 33 }
    end
  end

  describe '#destroy' do
    let!(:event) { create(:event) }
    let(:params) { { id: event.uuid } }

    subject { delete :destroy, params: params }

    it { is_expected.to have_http_status :redirect }

    it { expect { subject }.to change { Event.count }.by(-1) }
  end
end
