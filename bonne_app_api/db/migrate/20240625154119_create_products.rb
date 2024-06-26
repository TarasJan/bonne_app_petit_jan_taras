# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products, id: :uuid do |t|
      t.string :name

      t.timestamps

      t.index :name, unique: true
    end
  end
end
