# frozen_string_literal: true

class CreateRecipes < ActiveRecord::Migration[7.1]
  def change
    create_table :recipes, id: :uuid do |t|
      t.string :title
      t.integer :cook_time
      t.integer :prep_time
      t.float :ratings
      t.string :author
      t.string :category
      t.string :image_url

      t.index %i[title author], unique: true

      t.timestamps
    end
  end
end
