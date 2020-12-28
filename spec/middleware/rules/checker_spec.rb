# frozen_string_literal: true

require 'rails_helper'

describe Rules::Checker do
  let(:receiver) { create(:receiver) }
  let(:rule) { create(:rule) }
  let(:event) { create(:event, name: 'like-article', value: 1) }
  let(:event2) { create(:event, name: 'update-profile', value: 100) }
  let!(:condition) { create(:condition, rule: rule, event: event, operation: :counter, expression: :eq, value: 5) }
  let!(:condition2) { create(:condition, rule: rule, event: nil, operation: :points, expression: :gte, value: 50) }
  let(:rules_checker) { described_class.new(rule, receiver) }

  describe '#apply?' do
    subject { rules_checker.apply? }

    context 'when all conditions are valid' do
      before do
        5.times { create(:activity, event: event, receiver: receiver, value: event.value) }
        create(:activity, event: event2, receiver: receiver, value: event2.value)
      end

      it { is_expected.to be true }
    end

    context 'when some conditions are valid' do
      before do
        5.times { create(:activity, event: event, receiver: receiver, value: event.value) }
        create(:activity, event: event2, receiver: receiver, value: 44)
      end

      it { is_expected.to be false }
    end
  end
end
