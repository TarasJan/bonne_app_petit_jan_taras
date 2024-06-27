# frozen_string_literal: true

class ProductRepository
  # Fetches products most commonly used in recipes
  def self.most_common(limit = 10)
    Product
      .joins(:ingredients)
      .group('products.id')
      .select('products.*, COUNT(*) as count_all')
      .order(count_all: :desc)
      .limit(limit)
  end
end
