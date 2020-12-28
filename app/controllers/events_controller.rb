# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :find_event, only: %i[edit]

  def index
    @events = Event.order(:name)
  end

  def new; end

  def edit; end

  def create
    @event = Events::Persistence.create(event_params)
    if @event.errors.empty?
      redirect_to events_path, notice: 'Event created successfully.'
    else
      render partial: 'form'
    end
  end

  def update
    @event = Events::Persistence.update(update_params.merge(id: params[:id]))
    if @event.errors.empty?
      redirect_to events_path, notice: 'Event updated successfully.'
    else
      render partial: 'form'
    end
  end

  def destroy
    @event = Events::Persistence.destroy(destroy_params)

    if @event.errors.empty?
      redirect_to events_path, notice: 'Event deleted successfully.'
    else
      redirect_to events_path, error: 'Active events can not be deleted.'
    end
  end

  private

  def event_params
    params.require(:event).permit(%i[name description value])
  end

  def update_params
    event_params.merge(id: params[:id])
  end

  def destroy_params
    params.require(:id)
  end

  def find_event
    @event = Event.find_by!(uuid: params[:id])
  end
end
