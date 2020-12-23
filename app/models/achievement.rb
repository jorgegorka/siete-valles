# frozen_string_literal: true

class Achievement < ApplicationRecord
  belongs_to :reward
  belongs_to :receiver
end
