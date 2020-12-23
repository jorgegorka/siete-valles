# frozen_string_literal: true

require 'rails_helper'

describe Achievements::Persistence do
  let(:receiver) { create(:receiver) }
  let(:reward) { create(:reward) }
  let(:params) do
    {
      receiver_id: receiver.uuid,
      reward_id: reward.uuid
    }
  end
  let(:achievement_persistence) { described_class }

  describe '.create' do
    it { expect { achievement_persistence.create(params) }.to change { Achievement.count }.by(1) }

    context 'new achievement' do
      subject { achievement_persistence.create(params) }

      it { expect(subject.receiver).to eql receiver }
      it { expect(subject.reward).to eql reward }
    end
  end

  describe '.update' do
    let(:achievement) { create(:achievement) }
    let(:params) { { id: achievement.uuid } }

    subject { achievement_persistence.update(params) }

    it { expect { subject }.to raise_error(Exceptions::OperationNotAllowed) }
  end

  describe '.destroy' do
    let!(:achievement) { create(:achievement) }
    let(:params) { { id: achievement.uuid } }

    it { expect { achievement_persistence.destroy(params) }.to change { Achievement.count }.by(-1) }
  end
end
