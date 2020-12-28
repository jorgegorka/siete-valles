# frozen_string_literal: true

class ConditionsController < ApplicationController
  before_action :find_condition, only: %i[edit]
  before_action :events_for_select, only: %i[new create edit update]
  before_action :find_event_uuid, only: %i[edit]

  def index
    @conditions = rule.conditions.order(:reward_id, :name)
  end

  def new
    @rule = rule
  end

  def edit
  end


  def create
    @condition = Conditions::Persistence.create(condition_params)
    if @condition.errors.empty?
      redirect_to rule_path(id: rule.uuid), notice: 'Condition created successfully.'
    else
      render partial: 'form'
    end
  end

  def update
    @condition = Conditions::Persistence.update(condition_params)

    if @condition.errors.empty?
      redirect_to rule_path(id: rule.uuid), notice: 'Condition updated successfully.'
    else
      render partial: 'form'
    end
  end

  def destroy
    @condition = Conditions::Persistence.destroy(condition_params)

    message = if @condition.errors.empty?
                { notice: 'Condition deleted successfully.' }
              else
                { error: 'Active conditions can not be deleted.' }
              end

    redirect_to rule_path(id: rule.uuid), message
  end

  private

  def condition_params
    params.permit(%i[id rule_id event_id operation expression value])
  end


  def find_condition
    @condition = rule.conditions.find_by!(uuid: params[:id])
  end

  def rule
    @rule ||= Rule.find_by!(uuid: params[:rule_id])
  end

  def events_for_select
    @events = Event.order(:name).all
  end

  def find_event_uuid
    return if @condition&.event_id.blank?

    @event_uuid = Event.find(@condition.event_id).uuid
  end
end
