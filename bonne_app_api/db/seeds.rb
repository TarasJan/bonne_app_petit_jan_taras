# frozen_string_literal: true

require 'csv'

SOURCE_FILE = 'tmp/recipes.json'

# App hosted on Fly.io offers a subset of the whole data file
def read_source_data!
  file = File.read(SOURCE_FILE)
  JSON.parse(file)
rescue StandardError => e
  abort(e)
end

Rails.logger.info('Starting database seeding...')

unless File.exist?(SOURCE_FILE)
  Rails.logger.warn("Seed data file #{SOURCE_FILE} with source data not found!")
  Rails.logger.warn("Trying to download #{SOURCE_FILE} from Pennylane servers")
  Rake::Task['recipes:download'].invoke
end

data = read_source_data!

Rails.logger.info('Seeding Products...')

ProductImporter.new(data).call!

product_map = Product.pluck(:name,:id).to_h
Rails.logger.info('Seeding Recipes and their Ingredients...')
RecipeImporter.new(data, product_map).call!

Rails.logger.info('Seeding database completed successfully')
