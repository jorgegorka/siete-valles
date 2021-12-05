# frozen_string_literal: true

FactoryBot.define do
  factory :reward do
    name { Faker::Beer.name }
    active { true }
    category { %i[badge level].sample }
    description { Faker::Beer.style }
    image_url { Faker::LoremPixel.image(size: '100x100', is_gray: false, category: 'abstract') }

    trait :badge do
      category { :badge }
    end

    trait :level do
      category { :level }
    end
  end
end
