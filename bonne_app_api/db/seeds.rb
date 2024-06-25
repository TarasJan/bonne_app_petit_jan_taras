# frozen_string_literal: true

def transform_source_data(data)
  data.map do |recipe_data|
    # TODO: Recursively import ingredients
    recipe_data.delete('ingredients')

    # cuisine field was enpty in source data therefore skipping
    recipe_data.delete('cuisine')
    recipe_data.transform_keys('image' => 'image_url')
  end
end

begin
  file = File.read('tmp/recipes.json')
  data = JSON.parse(file)
rescue StandardError => e
  abort(e)
end

import_batch_data = transform_source_data(data)

Recipe.import(import_batch_data)
