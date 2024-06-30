# frozen_string_literal: true

class IngredientSerializer < ActiveModel::Serializer
  attributes :id, :unit, :amount, :name, :product_id
end
