require 'rails_helper'

describe AchievementsJob do
  let(:activity) { create(:activity) }
  let(:checker) { double(Achievements::Checker, new_rewards: true) }

  it { is_expected.to be_processed_in :default }

  it 'checks for new rewards' do
    expect(Achievements::Checker).to receive(:new).with(activity).and_return(checker)

    described_class.perform_now(activity)
  end
end
