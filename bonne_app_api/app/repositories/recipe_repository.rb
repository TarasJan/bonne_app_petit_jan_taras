# frozen_string_literal: true

class RecipeRepository
  def self.find_for_products(product_ids)
    Recipe
      .select('recipes.*, COUNT(*) as count_all')
      .joins(:ingredients)
      .where('ingredients.product_id' => product_ids)
      .group('recipes.id')
      .order(count_all: :desc)
  end
end
