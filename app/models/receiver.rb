# frozen_string_literal: true

class Receiver < ApplicationRecord
  has_many :achievements, dependent: :destroy
  has_many :activities, dependent: :destroy

  validates :external_id, presence: true

  def reward_ids
    achievements.pluck(:reward_id)
  end
end
