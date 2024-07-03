# frozen_string_literal: true

class ProductRepository
  # Fetches products most commonly used in recipes
  def self.most_common
    Product
      .joins(:ingredients)
      .group('products.id')
      .select('products.*, COUNT(*) as mentions')
      .order(mentions: :desc)
  end

  def self.search(name:)
    most_common.ransack(name_i_cont: name).result
  end
end