class Activity < ApplicationRecord
  belongs_to :event
  belongs_to :receiver

  after_create :increase_receiver_points
  after_create :check_for_new_rewards
  after_destroy :decrease_receiver_points

  scope :within_period, ->(starts_at, ends_at) { where(created_at: starts_at..ends_at) }

  private

  def increase_receiver_points
    Receivers::Persistence.update(id: receiver.uuid, points: receiver.points + value)
  end

  def decrease_receiver_points
    Receivers::Persistence.update(id: receiver.uuid, points: receiver.points - value)
  end

  def check_for_new_rewards
    AchievementsJob.perform_later(self)
  end
end
