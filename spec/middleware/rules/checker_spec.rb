# frozen_string_literal: true

require 'rails_helper'

describe Rules::Checker do
  let(:receiver) { create(:receiver) }
  let(:rule) { create(:rule) }
  let(:action) { create(:action, name: 'like-article', value: 1) }
  let(:action2) { create(:action, name: 'update-profile', value: 100) }
  let!(:condition) { create(:condition, rule: rule, action: action, operation: :counter, expression: :eq, value: 5) }
  let!(:condition2) { create(:condition, rule: rule, action: nil, operation: :points, expression: :gte, value: 50) }
  let(:rules_checker) { described_class.new(rule, receiver) }

  describe '#apply?' do
    subject { rules_checker.apply? }

    context 'when all conditions are valid' do
      before do
        5.times { create(:activity, action: action, receiver: receiver, value: action.value) }
        create(:activity, action: action2, receiver: receiver, value: action2.value)
      end

      it { is_expected.to be true }
    end

    context 'when some conditions are valid' do
      before do
        5.times { create(:activity, action: action, receiver: receiver, value: action.value) }
        create(:activity, action: action2, receiver: receiver, value: 44)
      end

      it { is_expected.to be false }
    end
  end
end
