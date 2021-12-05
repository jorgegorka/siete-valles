# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reward, type: :model do
  it_behaves_like 'uuidable'

  it { is_expected.to have_many :rules }
  it { is_expected.to have_many :achievements }

  it { is_expected.to validate_presence_of(:category) }
  it { is_expected.to validate_presence_of(:name) }

  it { should define_enum_for(:category).with_values(%i[badge level]) }
end
