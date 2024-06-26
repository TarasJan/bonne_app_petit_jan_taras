# frozen_string_literal: true

class Product < ApplicationRecord
  validates :name, uniqueness: true

  has_many :ingredients
  has_many :recipes, through: :ingredients
end
