# frozen_string_literal: true

module Recipes
  class SearchContract < Dry::Validation::Contract
    params do
      required(:product_ids).value(:string)
      optional(:cold).value(:bool)
      optional(:min_rating).value(:float)
    end

    rule(:min_rating) do
      key.failure('must be greater or equal to 0') if key? && value.to_f < 0
      key.failure('must be less or equal to 5') if key? && value.to_f > 5
    end
  end
end
