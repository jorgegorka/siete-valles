# frozen_string_literal: true

module ConditionsHelper
  def operations_select
    [
      ['Points', :points],
      ['Count', :counter]
    ]
  end

  def expressions_select
    [
      ['Greater than or equal to', :gte],
      ['Greater than', :gt],
      ['Equal to', :eq],
      ['Lower than', :lt],
      ['Lower than or equal to', :lte]
    ]
  end
end
