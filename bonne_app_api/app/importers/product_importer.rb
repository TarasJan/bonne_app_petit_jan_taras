# frozen_string_literal: true

class ProductImporter
  attr_reader :source_data

  def initialize(source_data)
    @source_data = source_data
  end

  def call!
    Product.import(transformed_data, on_duplicate_key_ignore: true)
  end

  private

  def transformed_data
    source_data.pluck('ingredients').flatten.map do |description|
      DescriptionInterpreter.new(description).with_product_name.call
    end
  end
end
