# frozen_string_literal: true

FactoryBot.define do
  factory :condition do
    rule
    operation { %i[points counter].sample }
    expression { %i[gte gt eq lt lte].sample }
    value { Faker::Number.number(digits: 3) }
  end
end
