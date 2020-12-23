# frozen_string_literal: true

class Reward < ApplicationRecord
  enum category: { badge: 0, level: 1 }

  has_many :rules, dependent: :destroy
  has_many :achievements, dependent: :destroy

  validates :category, presence: true
  validates :name, presence: true

  scope :active, -> { where(active: true) }

  class << self
    def excluding_ids(ids)
      return self if ids.empty?

      where('id NOT IN (?)', ids)
    end
  end
end
