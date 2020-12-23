# frozen_string_literal: true

require 'rails_helper'

describe Actions::Persistence do
  let(:name) { 'Toundra' }
  let(:value) { 13 }
  let(:params) do
    {
      name: name,
      value: value
    }
  end
  let(:action_persistence) { described_class }

  describe '.create' do
    it { expect { action_persistence.create(params) }.to change { Action.count }.by(1) }

    context 'new action' do
      subject { action_persistence.create(params) }

      it { expect(subject.name).to eql name }
      it { expect(subject.value).to eql value }
    end
  end

  describe '.update' do
    let(:action) { create(:action) }
    let(:params) { { id: action.uuid, name: 'The Police' } }

    subject { action_persistence.update(params) }

    it { expect(subject.name).to eql 'The Police' }
  end

  describe '.destroy' do
    let!(:action) { create(:action) }
    let(:params) { { id: action.uuid } }

    it { expect { action_persistence.destroy(params) }.to change { Action.count }.by(-1) }
  end
end
