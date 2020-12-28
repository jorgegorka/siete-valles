# frozen_string_literal: true

require 'rails_helper'

describe Events::Persistence do
  let(:name) { 'Toundra' }
  let(:value) { 13 }
  let(:params) do
    {
      name: name,
      value: value
    }
  end
  let(:event_persistence) { described_class }

  describe '.create' do
    it { expect { event_persistence.create(params) }.to change { Event.count }.by(1) }

    context 'new event' do
      subject { event_persistence.create(params) }

      it { expect(subject.name).to eql name }
      it { expect(subject.value).to eql value }
    end
  end

  describe '.update' do
    let(:event) { create(:event) }
    let(:params) { { id: event.uuid, name: 'The Police' } }

    subject { event_persistence.update(params) }

    it { expect(subject.name).to eql 'The Police' }
  end

  describe '.destroy' do
    let!(:event) { create(:event) }

    it { expect { event_persistence.destroy(event.uuid) }.to change { Event.count }.by(-1) }
  end
end
