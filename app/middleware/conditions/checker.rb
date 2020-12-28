# frozen_string_literal: true

module Conditions
  class Checker
    def initialize(condition, receiver)
      @condition = condition
      @receiver = receiver
    end

    def apply?
      condition.counter? ? check_counter_condition : check_points_condition
    end

    private

    attr_reader :condition, :receiver

    def check_counter_condition
      compare_values(total_activities, condition.value, condition.expression.to_sym)
    end

    def check_points_condition
      compare_values(activities_value, condition.value, condition.expression.to_sym)
    end

    def activities
      receiver.activities.within_period(condition.starts_at, condition.ends_at)
    end

    def total_activities
      activities.where(event_id: condition.event_id).count
    end

    def activities_value
      activities.sum(:value)
    end

    def compare_values(left_value, right_value, expression)
      Comparer.new(left_value, right_value).send(expression)
    end
  end
end
