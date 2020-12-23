# frozen_string_literal: true

FactoryBot.define do
  factory :rule do
    name { Faker::Hipster.word }
    reward
  end
end
