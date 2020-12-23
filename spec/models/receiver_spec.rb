# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Receiver, type: :model do
  it_behaves_like 'uuidable'

  it { is_expected.to have_many :achievements }
  it { is_expected.to have_many :activities }

  it { is_expected.to validate_presence_of(:external_id) }
end
