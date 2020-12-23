# frozen_string_literal: true

module Conditions
  class Comparer
    attr_reader :left_value, :right_value

    def initialize(left_value, right_value)
      @left_value = left_value
      @right_value = right_value
    end

    def gte
      left_value >= right_value
    end

    def gt
      left_value > right_value
    end

    def eq
      left_value == right_value
    end

    def lt
      left_value < right_value
    end

    def lte
      left_value <= right_value
    end
  end
end
