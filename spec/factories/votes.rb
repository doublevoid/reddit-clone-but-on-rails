# spec/factories/votes.rb
FactoryBot.define do
  factory :vote do
    value { [1, -1].sample }
    association :user

    trait :for_post do
      association :voteable, factory: :post
    end

    trait :for_comment do
      association :voteable, factory: :comment
    end
  end
end
