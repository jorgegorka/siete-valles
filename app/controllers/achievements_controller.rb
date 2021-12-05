class AchievementsController < ApplicationController
  def index
    @achievements = Achievement.order(:receiver_id, created_at: :desc).page(params[:page])
  end
end
