FactoryBot.define do
  factory :post do
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }
    link { Faker::Internet.url }
    association :subreddit
    association :user
  end
end
