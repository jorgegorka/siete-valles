# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Condition, type: :model do
  it_behaves_like 'uuidable'

  it { is_expected.to belong_to :rule }
  it { is_expected.to belong_to(:event).optional }

  it { is_expected.to validate_presence_of(:operation) }
  it { is_expected.to validate_presence_of(:expression) }
  it { is_expected.to validate_presence_of(:value) }
  it { is_expected.to validate_numericality_of(:value) }

  it { is_expected.to define_enum_for(:operation).with_values(%i[points counter]) }
  it { is_expected.to define_enum_for(:expression).with_values(%i[gte gt eq lt lte]) }
end
