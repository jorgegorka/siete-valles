module Conditions
  class Persistence
    class << self
      def create(params)
        rule = find_rule(params.delete(:rule_id))
        if params[:event_id].present?
          event = find_event(params.delete(:event_id))
          params[:event_id] = event.id
        end
        rule.conditions.create(params)
      end

      def update(params)
        rule = find_rule(params.delete(:rule_id))
        condition = rule.conditions.find_by(uuid: params.delete(:id))
        if params[:event_id].present?
          event = find_event(params.delete(:event_id))
          condition.event_id = event.id
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

      def find_event(event_id)
        Event.find_by(uuid: event_id)
      end
    end
  end
end
