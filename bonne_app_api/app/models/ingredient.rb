# frozen_string_literal: true

class Ingredient < ApplicationRecord
  validates :product_id, uniqueness: { scope: :recipe_id }

  belongs_to :product
  belongs_to :recipe
end
