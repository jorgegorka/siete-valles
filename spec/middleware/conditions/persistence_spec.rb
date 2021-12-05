# frozen_string_literal: true

require 'rails_helper'

describe Conditions::Persistence do
  let(:rule) { create(:rule) }
  let(:event) { create(:event) }
  let(:operation) { :points }
  let(:expression) { :gt }
  let(:params) do
    {
      rule_id: rule.uuid,
      event_id: event.uuid,
      operation: operation,
      expression: :gt,
      value: 175
    }
  end
  let(:condition_persistence) { described_class }

  describe '.create' do
    it { expect { condition_persistence.create(params) }.to change { Condition.count }.by(1) }

    context 'new condition' do
      subject { condition_persistence.create(params) }

      it { expect(subject.operation).to eql 'points' }
      it { expect(subject.expression).to eql 'gt' }
      it { expect(subject.event).to eq event }
      it { expect(subject.value).to eql 175 }
    end
  end

  describe '.update' do
    let(:condition) { create(:condition) }
    let(:event) { create(:event, name: 'Voivod') }
    let(:params) { { rule_id: condition.rule.uuid, id: condition.uuid, event_id: event.uuid } }

    subject { condition_persistence.update(params) }

    it { expect(subject.event.name).to eql 'Voivod' }
  end

  describe '.destroy' do
    let!(:condition) { create(:condition, operation: operation, expression: expression, value: 1) }
    let(:params) { { rule_id: condition.rule.uuid, id: condition.uuid } }

    it { expect { condition_persistence.destroy(params) }.to change { Condition.count }.by(-1) }
  end
end
