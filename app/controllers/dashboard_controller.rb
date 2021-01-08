# frozen_string_literal: true

class DashboardController < ApplicationController
  def index
    @total_achievements = Achievement.count
    @total_activities = Activity.count
    @total_receivers = Receiver.count
  end
end
