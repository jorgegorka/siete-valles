# frozen_string_literal: true

require 'rails_helper'

describe Conditions::Checker do
  let(:operation) { :counter }
  let(:expression) { :eq }
  let(:value) { 5 }
  let(:action) { create(:action, name: 'submit-article', value: 2) }
  let(:condition) { create(:condition, action: action, operation: operation, expression: expression, value: value) }
  let(:receiver) { create(:receiver) }
  let(:evaluator) { described_class.new(condition, receiver) }

  describe '#apply?' do
    subject { evaluator.apply? }

    context 'operation is counter' do
      context 'when expression is eq' do
        let(:expression) { :eq }
        let(:value) { 3 }

        it { is_expected.to be false }

        context 'when count equals conditions' do
          before { 3.times { create(:activity, action: action, receiver: receiver) } }

          it { is_expected.to be true }
        end

        context 'when count exceed conditions' do
          before { 6.times { create(:activity, action: action, receiver: receiver) } }

          it { is_expected.to be false }
        end
      end

      context 'when expression is gte' do
        let(:expression) { :gte }
        let(:value) { 3 }
        let(:action) { create(:action, name: 'submit-article', value: 5) }

        it { is_expected.to be false }

        context 'when count exceed conditions' do
          before { 4.times { create(:activity, action: action, receiver: receiver, value: action.value) } }

          it { is_expected.to be true }
        end

        context 'when count is equal than conditions' do
          before { 3.times { create(:activity, action: action, receiver: receiver, value: action.value) } }

          it { is_expected.to be true }
        end

        context 'when count is lower than conditions' do
          before { 1.times { create(:activity, action: action, receiver: receiver, value: action.value) } }

          it { is_expected.to be false }
        end
      end
    end

    context 'operation is points' do
      let(:operation) { :points }
      let(:activity) {}

      context 'when filtered by action' do
        let(:action) { create(:action, name: 'add-comment', value: 5) }

        context 'when expression is lt' do
          let(:expression) { :lt }
          let(:value) { 15 }

          it { is_expected.to be true }

          context 'when count exceed conditions' do
            before { 4.times { create(:activity, action: action, receiver: receiver, value: action.value) } }

            it { is_expected.to be false }
          end

          context 'when count is equal than conditions' do
            before { 3.times { create(:activity, action: action, receiver: receiver, value: action.value) } }

            it { is_expected.to be false }
          end

          context 'when count is lower than conditions' do
            before { 2.times { create(:activity, action: action, receiver: receiver, value: action.value) } }

            it { is_expected.to be true }
          end
        end
      end

      context 'when filter by any action' do
        let(:condition) { create(:condition, action: nil, operation: operation, expression: expression, value: value) }

        context 'when expression is gt' do
          let(:expression) { :gt }
          let(:value) { 6 }

          it { is_expected.to be false }

          context 'when count exceed conditions' do
            before { 5.times { create(:activity, receiver: receiver, value: 2) } }

            it { is_expected.to be true }
          end

          context 'when count is equal than conditions' do
            before { 3.times { create(:activity, receiver: receiver, value: 2) } }

            it { is_expected.to be false }
          end

          context 'when count is lower than conditions' do
            before { 2.times { create(:activity, receiver: receiver, value: 2) } }

            it { is_expected.to be false }
          end
        end
      end
    end

    context 'with date constraints' do
      let(:condition) { create(:condition, action: action, operation: operation, expression: expression, value: value, starts_at: 3.days.ago.beginning_of_day, ends_at: 8.days.from_now.end_of_day) }

      context 'when activities in time period fullfil condition' do
        before { 5.times { create(:activity, action: action, receiver: receiver) } }

        it { is_expected.to be true }
      end

      context 'when activities in time period do not fullfil condition' do
        before { 5.times { create(:activity, action: action, receiver: receiver, created_at: 1.month.ago) } }

        it { is_expected.to be false }
      end
    end
  end
end
