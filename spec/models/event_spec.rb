# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
  it_behaves_like 'uuidable'

  it { is_expected.to have_many :activities }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:value) }
  it { is_expected.to validate_numericality_of(:value) }
end
