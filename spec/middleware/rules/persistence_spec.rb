# frozen_string_literal: true

require 'rails_helper'

describe Rules::Persistence do
  let(:reward) { create(:reward) }
  let(:params) do
    {
      name: 'Wasp',
      reward_id: reward.uuid
    }
  end
  let(:rule_persistence) { described_class }

  describe '.create' do
    it { expect { rule_persistence.create(params) }.to change { Rule.count }.by(1) }

    context 'new rule' do
      subject { rule_persistence.create(params) }

      it { expect(subject.reward).to eql reward }
    end
  end

  describe '.update' do
    let(:rule) { create(:rule) }
    let(:reward) { create(:reward, name: 'Lustre') }
    let(:params) { { id: rule.uuid, reward_id: reward.uuid } }

    subject { rule_persistence.update(params) }

    it { expect(subject.reward.name).to eql 'Lustre' }
  end

  describe '.destroy' do
    let!(:rule) { create(:rule) }

    it { expect { rule_persistence.destroy(rule.uuid) }.to change { Rule.count }.by(-1) }
  end
end
