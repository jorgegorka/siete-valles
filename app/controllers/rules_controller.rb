# frozen_string_literal: true

class RulesController < ApplicationController
  before_action :find_rule, only: %i[show edit]
  before_action :rewards_for_select, only: %i[new create edit update]

  def index
    @rules = Rule.order(:reward_id, :name)
  end

  def show; end

  def new; end

  def edit; end

  def create
    @rule = Rules::Persistence.create(rule_params)
    if @rule.errors.empty?
      redirect_to rules_path, notice: 'Rule created successfully.'
    else
      render partial: 'form'
    end
  end

  def update
    @rule = Rules::Persistence.update(update_params.merge(id: params[:id]))
    if @rule.errors.empty?
      redirect_to rules_path, notice: 'Rule updated successfully.'
    else
      render partial: 'form'
    end
  end

  def destroy
    @rule = Rules::Persistence.destroy(destroy_params)

    if @rule.errors.empty?
      redirect_to rules_path, notice: 'Rule deleted successfully.'
    else
      redirect_to rules_path, error: 'Active rules can not be deleted.'
    end
  end

  private

  def rule_params
    params.require(:rule).permit(%i[name reward_id starts_at ends_at])
  end

  def update_params
    rule_params.merge(id: params[:id])
  end

  def destroy_params
    params.require(:id)
  end

  def find_rule
    @rule = Rule.find_by!(uuid: params[:id])
  end

  def rewards_for_select
    @rewards = Reward.order(:name).all.collect { |reward| [ reward.name, reward.uuid ] }
  end
end
