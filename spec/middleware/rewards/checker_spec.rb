# frozen_string_literal: true

require 'rails_helper'

describe Rewards::Checker do
  let(:receiver) { create(:receiver) }
  let(:action) { create(:action, name: 'submit-article', value: 2) }
  let(:activity) { create(:activity, action: action, receiver: receiver) }

  describe '.acquired' do
    subject { described_class.acquired(activity) }

    it { is_expected.to be_empty }

    context 'when reward conditions are met' do
      let!(:condition) { create(:condition, action: action, operation: :counter, expression: :gte, value: 3) }
      let(:reward) { condition.rule.reward }

      before { 3.times { create(:activity, action: action, receiver: receiver) } }

      it { expect(Achievement.first.reward).to eq reward }
    end

    context 'when any reward conditions are met' do
      let!(:condition) { create(:condition, action: action, operation: :counter, expression: :gte, value: 2) }
      let(:rule) { condition.rule }
      let(:reward) { condition.rule.reward }
      let(:rule2) { create(:rule, reward: reward) }
      let!(:condition2) { create(:condition, rule: rule2, action: action, operation: :counter, expression: :gte, value: 12) }

      before { 3.times { create(:activity, action: action, receiver: receiver) } }

      it { expect(Achievement.first.reward).to eq reward }
    end

    context 'when none of the reward conditions are met' do
      let!(:condition) { create(:condition, action: action, operation: :counter, expression: :gte, value: 33) }
      let(:rule) { condition.rule }
      let(:reward) { condition.rule.reward }
      let(:rule2) { create(:rule, reward: reward) }
      let!(:condition2) { create(:condition, rule: rule2, action: action, operation: :counter, expression: :gte, value: 12) }

      before { 3.times { create(:activity, action: action, receiver: receiver) } }

      it { is_expected.to be_empty }
    end

    context 'when receiver already has acquired this reward' do
      let!(:achievement) { create(:achievement, receiver: receiver, reward: reward) }

      context 'when conditions are met' do
        let!(:condition) { create(:condition, action: action, operation: :counter, expression: :gte, value: 2) }
        let(:rule) { condition.rule }
        let(:reward) { condition.rule.reward }
        let(:rule2) { create(:rule, reward: reward) }
        let!(:condition2) { create(:condition, rule: rule2, action: action, operation: :counter, expression: :gte, value: 3) }

        before { 3.times { create(:activity, action: action, receiver: receiver) } }

        it { is_expected.to be_empty }
      end

      context 'when conditions are not met' do
        let!(:condition) { create(:condition, action: action, operation: :counter, expression: :gte, value: 33) }
        let(:rule) { condition.rule }
        let(:reward) { condition.rule.reward }

        before { 3.times { create(:activity, action: action, receiver: receiver) } }

        it { is_expected.to be_empty }
      end
    end
  end
end
