# frozen_string_literal: true

class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :title, :author, :ratings, :prep_time, :cook_time
  has_many :ingredients
end
