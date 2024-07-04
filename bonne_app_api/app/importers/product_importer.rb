# frozen_string_literal: true

class ProductImporter
  attr_reader :source_data

  def initialize(source_data)
    @source_data = source_data
  end

  def call!
    CSVProducers::Product.new(source_data).produce_csv! unless File.exist?('db/products.csv')

    csv_text = File.read('db/products.csv')
    csv = CSV.parse(csv_text, headers: true).map(&:to_h)
    Product.import(csv , on_duplicate_key_ignore: true)
  end
end
