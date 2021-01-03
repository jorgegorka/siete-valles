# frozen_string_literal: true

class AchievementsController < ApplicationController
  def index
    @achievements = Achievement.order(:receiver_id, created_at: :desc)
  end
end
