# frozen_string_literal: true

require 'rails_helper'

describe Activities::Persistence do
  let(:receiver) { create(:receiver, points: 100) }
  let(:action) { create(:action, value: 7) }
  let(:action_id) { action.uuid }
  let(:params) do
    {
      receiver_id: receiver.uuid,
      action_id: action_id
    }
  end
  let(:activity_persistence) { described_class }

  describe '.create' do
    it { expect { activity_persistence.create(params) }.to change { Activity.count }.by(1) }

    context 'when action is present' do
      subject { activity_persistence.create(params) }

      it { expect(subject.receiver).to eql receiver }
      it { expect(subject.action).to eql action }
      it { expect(subject.value).to eql action.value }
      it { expect(subject.reload.receiver.points).to eql 100 + 7 }
    end

    context 'when action is not present' do
      let(:action_id) {}

      subject { activity_persistence.create(params) }

      it { expect(subject.receiver).to eql receiver }
      it { expect(subject.action).to be_nil }
    end
  end

  describe '.update' do
    let(:activity) { create(:activity) }
    let(:params) { { id: activity.uuid } }

    subject { activity_persistence.update(params) }

    it { expect { subject }.to raise_error(Exceptions::OperationNotAllowed) }
  end

  describe '.destroy' do
    let!(:activity) { create(:activity) }
    let(:params) { { id: activity.uuid } }

    it { expect { activity_persistence.destroy(params) }.to change { Activity.count }.by(-1) }
  end
end
