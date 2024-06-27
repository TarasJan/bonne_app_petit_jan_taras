# frozen_string_literal: true

FactoryBot.define do
  factory :ingredient do
    unit { Unit::AVAILABLE_UNITS.sample }
    amount { Faker::Number.between(from: 0.0, to: 50.0) }
    product
    recipe
  end
end
