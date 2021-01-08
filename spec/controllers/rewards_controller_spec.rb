# frozen_string_literal: true

require 'rails_helper'

describe RewardsController do
  let(:name) { 'Toundra' }
  let(:category) { :badge }
  let(:params) do
    {
      reward: {
        name: name,
        category: category
      }
    }
  end

  describe '#show' do
    let(:reward) { create(:reward) }

    subject { get :show, params: { id: reward.uuid } }

    it { is_expected.to have_http_status :success }
  end

  describe '#new' do
    subject { get :new }

    it { is_expected.to have_http_status :success }
  end

  describe '#create' do
    subject { post :create, params: params }

    it { is_expected.to have_http_status :redirect }

    it { expect { subject }.to change { Reward.count }.by(1) }

    context 'new reward' do
      let(:new_reward) { Reward.find_by(name: name) }

      before { subject }

      it { expect(new_reward.name).to eql name }
      it { expect(new_reward.category).to eql 'badge' }
    end
  end

  describe '#edit' do
    let(:reward) { create(:reward) }
    let(:params) { { id: reward.uuid } }

    subject { get :new, params: params }

    it { is_expected.to have_http_status :success }
  end

  describe '#update' do
    let(:reward) { create(:reward) }
    let(:name) { 'Mono Inc.' }
    let(:reward_uuid) { reward.uuid }
    let(:params) { { id: reward_uuid, reward: { name: name } } }

    subject { put :update, params: params }

    it { is_expected.to have_http_status :redirect }

    context 'updated reward' do
      let(:updated_reward) { Reward.find_by(name: name) }

      before { subject }

      it { expect(updated_reward.name).to eql name }
    end
  end

  describe '#destroy' do
    let!(:reward) { create(:reward) }
    let(:params) { { id: reward.uuid } }

    subject { delete :destroy, params: params }

    it { is_expected.to have_http_status :redirect }

    it { expect { subject }.to change { Reward.count }.by(-1) }
  end
end
