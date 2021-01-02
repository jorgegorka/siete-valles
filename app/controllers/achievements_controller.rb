# frozen_string_literal: true

class AchievementsController < ApplicationController
  def index
    @achievements = Achievement.order(created_at: :desc)
  end
end
