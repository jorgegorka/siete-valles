# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Activity, type: :model do
  it_behaves_like 'uuidable'

  it { is_expected.to belong_to :event }
  it { is_expected.to belong_to :receiver }
end
