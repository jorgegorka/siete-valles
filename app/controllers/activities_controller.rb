# frozen_string_literal: true

class ActivitiesController < ApplicationController
  def index
    @activities = Activity.order(created_at: :desc).limit(50)
  end
end
