# frozen_string_literal: true

class CreateIngredients < ActiveRecord::Migration[7.1]
  def change
    create_table :ingredients, id: :uuid do |t|
      t.integer :unit
      t.float :amount
      t.belongs_to :product, null: false, foreign_key: true, type: :uuid
      t.belongs_to :recipe, null: false, foreign_key: true, type: :uuid

      t.timestamps

      t.index %i[recipe_id product_id], unique: true
    end
  end
end
