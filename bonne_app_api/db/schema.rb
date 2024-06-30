# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 20_240_625_154_326) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'pgcrypto'
  enable_extension 'plpgsql'

  create_table 'ingredients', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'unit'
    t.float 'amount'
    t.uuid 'product_id', null: false
    t.uuid 'recipe_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['product_id'], name: 'index_ingredients_on_product_id'
    t.index %w[recipe_id product_id], name: 'index_ingredients_on_recipe_id_and_product_id', unique: true
    t.index ['recipe_id'], name: 'index_ingredients_on_recipe_id'
  end

  create_table 'products', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['name'], name: 'index_products_on_name', unique: true
  end

  create_table 'recipes', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'title'
    t.integer 'cook_time'
    t.integer 'prep_time'
    t.float 'ratings'
    t.string 'author'
    t.string 'category'
    t.string 'image_url'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[title author], name: 'index_recipes_on_title_and_author', unique: true
  end

  add_foreign_key 'ingredients', 'products'
  add_foreign_key 'ingredients', 'recipes'
end
