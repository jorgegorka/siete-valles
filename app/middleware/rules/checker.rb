# frozen_string_literal: true

module Rules
  class Checker
    attr_reader :receiver, :rule

    def initialize(rule, receiver)
      @rule = rule
      @receiver = receiver
    end

    def apply?
      return false if conditions.size.zero?

      conditions.all? { |condition| Conditions::Checker.new(condition, receiver).apply? }
    end

    private

    def conditions
      rule.conditions
    end
  end
end
