# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    name { SecureRandom.uuid }

    trait :with_ingredients do
      transient do
        ingredient_count { 5 }
      end
      after(:build) do |product, evaluator|
        product.ingredients = build_list(:ingredient, evaluator.ingredient_count)
      end
    end
  end
end
