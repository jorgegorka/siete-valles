class Condition < ApplicationRecord
  enum operation: { points: 0, counter: 1 }
  enum expression: { gte: 0, gt: 1, eq: 2, lt: 3, lte: 4 }

  belongs_to :rule
  belongs_to :event, optional: true

  validates :operation, presence: true
  validates :expression, presence: true
  validates :value, presence: true, numericality: { only_integer: true }
end
