# frozen_string_literal: true

class RecipeImporter
  attr_reader :source_data, :product_map

  def initialize(source_data, product_map)
    @source_data = source_data
    @product_map = product_map
  end

  def call!
    Recipe.import(
      transformed_data,
      recursive: true,
      on_duplicate_key_ignore: true
    )
  end

  private

  def transformed_data
    source_data.map do |recipe_data|
      # cuisine field was empty in source data therefore skipping
      recipe_data.delete('cuisine')

      ingredient_data = recipe_data.delete('ingredients').map do |description|
        DescriptionInterpreter.new(description).with_all.call.tap do |ingredient|
          ingredient[:product_id] = product_map[ingredient.delete(:name)]
        end
      end
      .uniq do |ingredient|
        ingredient[:product_id]
      end

      recipe = Recipe.build(recipe_data.transform_keys('image' => 'image_url'))
      ingredient_data.each do |data|
        recipe.ingredients.build(data)
      end

      recipe
    end
  end
end
