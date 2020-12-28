# frozen_string_literal: true

require 'rails_helper'

describe Activities::Persistence do
  let(:receiver) { create(:receiver, points: 100) }
  let(:event) { create(:event, value: 7) }
  let(:event_id) { event.uuid }
  let(:params) do
    {
      receiver_id: receiver.uuid,
      event_id: event_id
    }
  end
  let(:activity_persistence) { described_class }

  describe '.create' do
    it { expect { activity_persistence.create(params) }.to change { Activity.count }.by(1) }

    context 'when event is present' do
      subject { activity_persistence.create(params) }

      it { expect(subject.receiver).to eql receiver }
      it { expect(subject.event).to eql event }
      it { expect(subject.value).to eql event.value }
      it { expect(subject.reload.receiver.points).to eql 100 + 7 }
    end

    context 'when event is not present' do
      let(:event_id) {}

      subject { activity_persistence.create(params) }

      it { expect(subject.receiver).to eql receiver }
      it { expect(subject.event).to be_nil }
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
