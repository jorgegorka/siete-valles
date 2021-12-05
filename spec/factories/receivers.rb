# frozen_string_literal: true

FactoryBot.define do
  factory :receiver do
    external_id { Faker::Science.element }
  end
end
