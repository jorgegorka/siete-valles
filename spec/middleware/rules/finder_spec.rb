# frozen_string_literal: true

require 'rails_helper'

describe Rules::Finder do
  let(:limit) {}
  let(:page) {}
  let(:reward_id) {}
  let(:params) do
    {
      page: page,
      limit: limit,
      reward_id: reward_id
    }
  end
  let(:rules_finder) { described_class.new(params) }

  before { 7.times { create(:rule) } }

  describe '.paginated' do
    subject { rules_finder.paginated }

    context 'when page and limit' do
      let(:limit) { 3 }
      let(:page) { 3 }

      it { expect(subject.count).to eql 1 }
    end

    context 'when page is present and no limit' do
      let(:page) { 1 }

      it { expect(subject.count).to eql 7 }
    end

    context 'when reward id is present' do
      let(:reward) { Rule.first.reward }
      let(:reward_id) { reward.uuid }

      it { expect(subject.count).to eql Rule.where(reward_id: reward.id).count }
    end
  end

  describe '.all' do
    subject { rules_finder.all }

    it { expect(subject.count).to eql 7 }
  end
end
