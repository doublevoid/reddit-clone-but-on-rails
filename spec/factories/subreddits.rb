FactoryBot.define do
  factory :subreddit do
    name { Faker::Internet.domain_word.capitalize }
    description { Faker::Lorem.sentence }
  end
end
