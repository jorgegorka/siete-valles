# frozen_string_literal: true

class ConditionsController < ApplicationController
  before_action :find_condition, only: %i[edit]

  def index
    @conditions = rule.conditions.order(:reward_id, :name)
  end

  def new; end

  def edit
  end

  def create
    @condition = Conditions::Persistence.create(condition_params)
    if @condition.errors.empty?
      redirect_to rule_conditions_path(rule_id: rule.uuid), notice: 'Condition created successfully.'
    else
      render partial: 'form'
    end
  end

  def update
    @condition = Conditions::Persistence.update(update_params.merge(id: params[:id]))

    if @condition.errors.empty?
      redirect_to rule_conditions_path(rule_id: rule.uuid), notice: 'Condition updated successfully.'
    else
      render partial: 'form'
    end
  end

  def destroy
    @condition = Conditions::Persistence.destroy(destroy_params)

    if @condition.errors.empty?
      redirect_to rule_conditions_path(rule_id: rule.uuid), notice: 'Condition deleted successfully.'
    else
      redirect_to rule_conditions_path(rule_id: rule.uuid), error: 'Active conditions can not be deleted.'
    end
  end

  private

  def condition_params
    params.require(:condition).permit(%i[operation expression value]).merge(rule_id: params[:rule_id])
  end

  def update_params
    condition_params.merge(id: params[:id])
  end

  def destroy_params
    params.permit(:rule_id, :id)
  end

  def find_condition
    @condition = Condition.find_by!(uuid: params[:id])
  end

  def rule
    @rule ||= Rule.find_by!(uuid: params[:rule_id])
  end
end
