# frozen_string_literal: true

FactoryBot.define do
  factory :action do
    name { Faker::Marketing.buzzwords }
    value { Faker::Number.number(digits: 2) }
  end
end
