FactoryBot.define do
  factory :rule do
    name { Faker::Hipster.word }
    reward
  end
end
