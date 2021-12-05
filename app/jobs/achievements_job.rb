class AchievementsJob < ApplicationJob
  def perform(activity)
    Achievements::Checker.new(activity).new_rewards
  end
end
