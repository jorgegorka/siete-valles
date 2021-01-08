# frozen_string_literal: true

module Rules
  class Finder
    def initialize(params)
      @params = params
      @rules = Rule
    end

    def paginated
      page = params.delete(:page)
      limit = params.delete(:limit)

      find.page(page).per(limit)
    end

    def all
      find
    end

    private

    attr_accessor :rules, :params

    def find
      filter_by_reward
      order_results

      rules
    end

    def filter_by_reward
      return if params[:reward_id].blank?

      @rules = rules.includes(:reward).where('reward.uuid': params[:reward_id])
    end

    def order_results
      @rules = rules.order(:reward_id, :name)
    end
  end
end
