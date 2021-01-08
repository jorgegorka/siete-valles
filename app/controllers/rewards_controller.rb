# frozen_string_literal: true

class RewardsController < ApplicationController
  before_action :find_reward, only: %i[edit]

  def index
    @rewards = Reward.order(:active, :category, :name).page(params[:page])
  end

  def show
    @reward = Reward.find_by(uuid: params[:id])
  end

  def new; end

  def edit; end

  def create
    @reward = Rewards::Persistence.create(reward_params)
    if @reward.errors.empty?
      redirect_to rewards_path, notice: 'Reward created successfully.'
    else
      render partial: 'form'
    end
  end

  def update
    @reward = Rewards::Persistence.update(update_params.merge(id: params[:id]))
    if @reward.errors.empty?
      redirect_to rewards_path, notice: 'Reward updated successfully.'
    else
      render partial: 'form'
    end
  end

  def destroy
    @reward = Rewards::Persistence.destroy(destroy_params)

    if @reward.errors.empty?
      redirect_to rewards_path, notice: 'Reward deleted successfully.'
    else
      redirect_to rewards_path, error: 'Active rewards can not be deleted.'
    end
  end

  private

  def reward_params
    params.require(:reward).permit(%i[name category description])
  end

  def update_params
    reward_params.merge(id: params[:id])
  end

  def destroy_params
    params.require(:id)
  end

  def find_reward
    @reward = Reward.find_by!(uuid: params[:id])
  end
end
