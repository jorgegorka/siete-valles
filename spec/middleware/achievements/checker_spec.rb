# frozen_string_literal: true

require 'rails_helper'

describe Achievements::Checker do
  let!(:activity) { create(:activity) }
  let(:receiver) { activity.receiver }
  let(:achievements_checker) { described_class.new(activity) }

  describe '#new_rewards' do
    it { expect { achievements_checker.new_rewards }.to change { Achievement.count }.by(0) }

    context 'when there is an achievement' do
      let(:condition) { create(:condition, event: activity.event, operation: :points, expression: :lt, value: 10_000) }
      let!(:reward) { condition.rule.reward }
      it { expect { achievements_checker.new_rewards }.to change { Achievement.count }.by(1) }

      context 'new achievement' do
        before { achievements_checker.new_rewards }

        subject { receiver.achievements.last }

        it { expect(subject.receiver).to eql receiver }
        it { expect(subject.reward).to eql reward }
      end
    end

    context 'when there is more than one achievement' do
      let!(:condition) { create(:condition, event: activity.event, operation: :points, expression: :lt, value: 10_000) }
      let!(:condition2) { create(:condition, event: activity.event, operation: :counter, expression: :gte, value: 1) }

      it { expect { achievements_checker.new_rewards }.to change { Achievement.count }.by(2) }

      context 'new achievement' do
        before { achievements_checker.new_rewards }

        subject { receiver.achievements }

        it { is_expected.to eq Achievement.all }
      end
    end

    context 'when an achievement has been already obtained' do
      let!(:condition) { create(:condition, event: activity.event, operation: :counter, expression: :gte, value: 1) }

      before { create(:achievement, receiver: receiver, reward: condition.rule.reward) }

      it { expect { achievements_checker.new_rewards }.to change { Achievement.count }.by(0) }
    end
  end
end
