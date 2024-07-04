class AddGinIndexToProducts < ActiveRecord::Migration[7.1]
  def change
    enable_extension 'pg_trgm'

    remove_index :products, :name
    add_index :products, :name, using: :gin, opclass: :gin_trgm_ops
  end
end
