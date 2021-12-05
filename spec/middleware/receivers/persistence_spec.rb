# frozen_string_literal: true

require 'rails_helper'

describe Receivers::Persistence do
  let(:receiver_persistence) { described_class }

  describe '.create' do
    let(:receiver_id) {}
    let(:params) { { external_id: 'your-id' } }
    it { expect { receiver_persistence.create(params) }.to change { Receiver.count }.by(1) }

    context 'new receiver' do
      subject { receiver_persistence.create(params) }

      it { expect(subject.points).to be_zero }
      it { expect(subject.achievements).to be_empty }
      it { expect(subject.external_id).to eql 'your-id' }
    end
  end

  describe '.update' do
    let(:receiver) { create(:receiver) }
    let(:params) { { id: receiver.uuid, points: 4321 } }

    subject { receiver_persistence.update(params) }

    it { expect(subject.points).to eql 4321 }
  end

  describe '.destroy' do
    let!(:receiver) { create(:receiver) }
    let(:params) { { id: receiver.uuid } }

    it { expect { receiver_persistence.destroy(params) }.to change { Receiver.count }.by(-1) }
  end
end
