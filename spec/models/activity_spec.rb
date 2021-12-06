require 'rails_helper'

RSpec.describe Activity, type: :model do
  it_behaves_like 'uuidable'

  it { is_expected.to belong_to :event }
  it { is_expected.to belong_to :receiver }

  describe 'after create' do
    let(:activity) { build(:activity) }
    let(:receiver) { activity.receiver }
    let(:points) { receiver.points + activity.value }

    it 'enqueue a job to check for rewards' do
      expect(AchievementsJob).to receive(:perform_later).with(activity)

      activity.save
    end

    it 'adds points to receiver' do
      expect(Receivers::Persistence).to receive(:update).with(id: receiver.uuid, points: points)

      activity.save
    end
  end

  describe 'after destroy' do
    let(:activity) { create(:activity) }
    let(:receiver) { activity.receiver }
    let(:points) { receiver.points - activity.value }

    it 'removes points from receiver' do
      expect(Receivers::Persistence).to receive(:update).with(id: receiver.uuid, points: points)

      activity.destroy
    end
  end
end
