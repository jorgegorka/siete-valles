# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound do
    render nothing: true, status: :not_found
  end
end
