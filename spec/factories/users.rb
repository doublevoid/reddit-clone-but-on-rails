# frozen_string_literal: true
FactoryBot.define do
  factory :user do
    username { Faker::Internet.unique.username }
    email { Faker::Internet.unique.email }
    password { 'password123' }
    password_confirmation { 'password123' }

    trait :confirmed do
      confirmed_at { Time.now }
    end
  end
end
