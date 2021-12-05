class ReceiversController < ApplicationController
  def index
    @receivers = Receiver.order(points: :desc, external_id: :asc).page(params[:page])
  end

  def show
    @receiver = Receiver.find_by(uuid: params[:id])
    @activities = @receiver.activities.page(params[:page])
  end
end
