# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  subject(:ingredient) do
    build(:ingredient)
  end

  let(:product) { create(:product) }
  let(:recipe) { create(:recipe) }

  it { is_expected.to validate_uniqueness_of(:product_id).scoped_to(:recipe_id).case_insensitive }
end
