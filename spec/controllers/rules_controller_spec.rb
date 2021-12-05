# frozen_string_literal: true

require 'rails_helper'

describe RulesController do
  let(:name) { 'Toundra' }
  let(:reward) { create(:reward) }
  let(:rule) { create(:rule) }
  let(:params) do
    {
      rule: {
        name: name,
        reward_id: reward.uuid
      }
    }
  end

  describe '#index' do
    subject { get :index }

    it { is_expected.to have_http_status :success }

    it { is_expected.to render_template(:index) }
  end

  describe '#show' do
    let!(:condition) { create(:condition, rule: rule, event: nil) }

    subject { get :show, params: { id: rule.uuid } }

    it { is_expected.to have_http_status :success }

    it { is_expected.to render_template(:show) }
  end

  describe '#new' do
    subject { get :new }

    it { is_expected.to have_http_status :success }
  end

  describe '#create' do
    subject { post :create, params: params }

    it { is_expected.to have_http_status :redirect }

    it { expect { subject }.to change { Rule.count }.by(1) }

    context 'new rule' do
      let(:new_rule) { Rule.find_by(name: name) }

      before { subject }

      it { expect(new_rule.name).to eql name }
      it { expect(new_rule.reward).to eql reward }
    end
  end

  describe '#edit' do
    let(:params) { { id: rule.uuid } }

    subject { get :new, params: params }

    it { is_expected.to have_http_status :success }
  end

  describe '#update' do
    let(:rule) { create(:rule) }
    let(:name) { 'Mono Inc.' }
    let(:rule_uuid) { rule.uuid }
    let(:params) { { id: rule_uuid, rule: { name: name } } }

    subject { put :update, params: params }

    it { is_expected.to have_http_status :redirect }

    context 'updated rule' do
      let(:updated_rule) { Rule.find_by(name: name) }

      before { subject }

      it { expect(updated_rule.name).to eql name }
    end
  end

  describe '#destroy' do
    let!(:rule) { create(:rule) }
    let(:params) { { id: rule.uuid } }

    subject { delete :destroy, params: params }

    it { is_expected.to have_http_status :redirect }

    it { expect { subject }.to change { Rule.count }.by(-1) }
  end
end
