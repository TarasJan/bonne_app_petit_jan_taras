# frozen_string_literal: true

class Recipe < ApplicationRecord
  validates :title, :prep_time, :cook_time, :author, presence: true
  validates :title, uniqueness: { scope: :author }
  validates :ratings, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
  validates :cook_time, :prep_time, numericality: { greater_than_or_equal_to: 0 }

  has_many :ingredients
  has_many :products, through: :ingredients

  accepts_nested_attributes_for :ingredients
end
