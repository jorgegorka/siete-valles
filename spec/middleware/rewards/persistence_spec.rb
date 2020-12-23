# frozen_string_literal: true

require 'rails_helper'

describe Rewards::Persistence do
  let(:name) { 'Toundra' }
  let(:category) { :badge }
  let(:params) do
    {
      name: name,
      category: category
    }
  end
  let(:reward_persistence) { described_class }

  describe '.create' do
    it { expect { reward_persistence.create(params) }.to change { Reward.count }.by(1) }

    context 'new reward' do
      subject { reward_persistence.create(params) }

      it { expect(subject.name).to eql name }
      it { expect(subject.category).to eql 'badge' }
    end
  end

  describe '.update' do
    let(:reward) { create(:reward) }
    let(:params) { { id: reward.uuid, name: 'The Police' } }

    subject { reward_persistence.update(params) }

    it { expect(subject.name).to eql 'The Police' }
  end

  describe '.destroy' do
    let!(:reward) { create(:reward, :level) }

    it { expect { reward_persistence.destroy(reward.uuid) }.to change { Reward.count }.by(-1) }
  end
end
