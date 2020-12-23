# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Rule, type: :model do
  it_behaves_like 'uuidable'

  it { is_expected.to belong_to :reward }

  it { is_expected.to have_many :conditions }

  it { is_expected.to validate_presence_of(:reward_id) }
  it { is_expected.to validate_presence_of(:name) }
end
