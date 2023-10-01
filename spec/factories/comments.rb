FactoryBot.define do
  factory :comment do
    body { Faker::Lorem.paragraph }
    association :post
    association :user
  end
end
