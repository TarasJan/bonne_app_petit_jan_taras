# frozen_string_literal: true

FactoryBot.define do
  factory :recipe do
    title { Faker::Food.dish }
    cook_time { Faker::Number.between(from: 0, to: 200) }
    prep_time { Faker::Number.between(from: 0, to: 200) }
    ratings { Faker::Number.between(from: 0.0, to: 5.0) }
    author { Faker::Name.name }
    image_url { Faker::Internet.url(host: 'example.com') }
  end
end
