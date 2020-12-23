# frozen_string_literal: true

module Conditions
  class Persistence
    class << self
      def create(params)
        rule = find_rule(params.delete(:rule_id))
        if params[:action_id].present?
          action = find_action(params.delete(:action_id))
          params[:action_id] = action.id
        end
        rule.conditions.create(params)
      end

      def update(params)
        rule = find_rule(params.delete(:rule_id))
        condition = rule.conditions.find_by(uuid: params.delete(:id))
        if params[:action_id].present?
          action = find_action(params.delete(:action_id))
          condition.action_id = action.id
        end
        condition.update(params)

        condition
      end

      def destroy(params)
        rule = find_rule(params.delete(:rule_id))
        condition = rule.conditions.find_by(uuid: params[:id])
        condition.destroy
      end

      private

      def find_rule(rule_id)
        Rule.find_by(uuid: rule_id)
      end

      def find_action(action_id)
        Action.find_by(uuid: action_id)
      end
    end
  end
end
