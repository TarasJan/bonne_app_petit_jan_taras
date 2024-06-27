# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProductRepository do
  describe '#self.most_common' do
    subject(:repository_call) { described_class.most_common }

    before do
      (1..10).each do |count|
        create(:product, :with_ingredients, ingredient_count: count)
      end
    end

    it 'returns most common recipes ordered by frequency of use as ingredients' do
      expect(repository_call.map { |product| product.ingredients.size }).to eq([*1..10].reverse)
    end
  end
end
