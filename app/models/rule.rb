class Rule < ApplicationRecord
  belongs_to :reward

  has_many :conditions, dependent: :destroy

  validates :reward_id, presence: true
  validates :name, presence: true

  class << self
    def within_period(activity_time)
      where('(starts_at >= :activity_time OR starts_at IS NULL) AND (ends_at <= :activity_time OR ends_at IS NULL)', { activity_time: activity_time })
    end
  end
end
