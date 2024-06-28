# frozen_string_literal: true

SOURCE_FILE = 'tmp/recipes.json'


# App hosted on Fly.io offers a subset of the whole data file
def read_source_data!(limit: 1000)
  file = File.read(SOURCE_FILE)
  JSON.parse(file).first(limit)
rescue StandardError => e
  abort(e)
end

Rails.logger.info('Starting database seeding...')

unless File.exist?(SOURCE_FILE)
  Rails.logger.warn("Seed data file #{SOURCE_FILE} with source data not found!")
  Rails.logger.warn("Trying to download #{SOURCE_FILE} from Pennylane servers")
  Rake::Task['recipes:download'].invoke
end

data = read_source_data!(limit: 1000)

Rails.logger.info('Seeding Products...')

ProductImporter.new(data).call!
Rails.logger.info('Seeding Recipes and their Ingredients...')
RecipeImporter.new(data).call!

Rails.logger.info('Seeding database completed successfully')
