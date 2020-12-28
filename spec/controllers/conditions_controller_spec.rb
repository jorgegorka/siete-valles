# frozen_string_literal: true

require 'rails_helper'

describe ConditionsController do
  let(:operation) { :points }
  let(:rule) { create(:rule) }
  let(:params) do
    {
      rule_id: rule.uuid,
      operation: operation,
      expression: :gte,
      value: 1
    }
  end

  describe '#new' do
    let(:params) { { rule_id: rule.uuid } }

    subject { get :new, params: params }

    it { is_expected.to have_http_status :success }
  end

  describe '#create' do
    subject { post :create, params: params }

    it { is_expected.to have_http_status :redirect }

    it { is_expected.to redirect_to rule_path(id: rule.uuid) }

    it { expect { subject }.to change { Condition.count }.by(1) }

    context 'new condition' do
      let(:new_condition) { Condition.find_by(operation: operation) }

      before { subject }

      it { expect(new_condition.expression).to eql 'gte' }
      it { expect(new_condition.value).to eql 1 }
    end
  end

  describe '#edit' do
    let(:condition) { create(:condition) }
    let(:params) { { rule_id: rule.uuid, id: condition.uuid } }

    subject { get :new, params: params }

    it { is_expected.to have_http_status :success }
  end

  describe '#update' do
    let(:condition) { create(:condition, rule: rule) }
    let(:expression) { :lt }
    let(:condition_uuid) { condition.uuid }
    let(:params) { { rule_id: rule.uuid, id: condition.uuid, expression: expression } }

    subject { put :update, params: params }

    it { is_expected.to have_http_status :redirect }

    it { is_expected.to redirect_to rule_path(id: rule.uuid) }

    context 'updated condition' do
      let(:updated_condition) { Condition.find_by(expression: expression) }

      before { subject }

      it { expect(updated_condition.expression).to eql expression.to_s }
    end
  end

  describe '#destroy' do
    let!(:condition) { create(:condition, rule: rule) }
    let(:params) { { rule_id: rule.uuid, id: condition.uuid } }

    subject { delete :destroy, params: params }

    it { is_expected.to have_http_status :redirect }

    it { is_expected.to redirect_to rule_path(id: rule.uuid) }

    it { expect { subject }.to change { Condition.count }.by(-1) }
  end
end
