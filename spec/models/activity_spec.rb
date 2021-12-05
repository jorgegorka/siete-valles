require 'rails_helper'

RSpec.describe Activity, type: :model do
  it_behaves_like 'uuidable'

  it { is_expected.to belong_to :event }
  it { is_expected.to belong_to :receiver }

  describe 'after create' do
    let(:activity) { build(:activity) }

    it 'enqueue a job to check for rewards' do
      expect(AchievementsJob).to receive(:perform_later)
      activity.save
    end
  end
end
