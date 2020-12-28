# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    name { Faker::Marketing.buzzwords }
    description { Faker::Beer.style }
    value { Faker::Number.number(digits: 2) }
  end
end
