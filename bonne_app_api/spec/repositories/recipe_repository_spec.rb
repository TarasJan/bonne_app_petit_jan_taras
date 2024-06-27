# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RecipeRepository do
  let(:ham) { create(:product, name: 'ham') }
  let(:egg) { create(:product, name: 'egg') }
  let(:salt) { create(:product, name: 'salt') }
  let(:lemon) { create(:product, name: 'lemon') }

  # not used in any recipes
  let!(:exotic_mushroom) { create(:product, name: 'exotic mushroom') }

  let(:scrambled_eggs) { create(:recipe, title: 'Scrambled eggs') }
  let(:tequilla) { create(:recipe, title: 'Tequilla') }

  before do
    create(:ingredient, product: egg, recipe: scrambled_eggs)
    create(:ingredient, product: salt, recipe: scrambled_eggs)
    create(:ingredient, product: ham, recipe: scrambled_eggs)
    create(:ingredient, product: salt, recipe: tequilla)
    create(:ingredient, product: lemon, recipe: tequilla)
  end

  describe '#self.find_for_products' do
    subject(:recipes_found) do
      described_class.find_for_products(product_ids)
    end

    context 'searching for unused product' do
      let(:product_ids) { [exotic_mushroom.id] }

      it 'returns empty collection' do
        expect(recipes_found).to be_empty
      end
    end

    context 'searching for eggs, ham, salt and unused product' do
      context 'first recommendation' do
        subject(:first_recommendation) do
          recipes_found.first
        end

        let(:product_ids) { [salt.id, egg.id, ham.id, exotic_mushroom.id] }

        it 'suggest scrambled eggs first as it matches most ingredients' do
          expect(first_recommendation).to eq(scrambled_eggs)
        end
      end
    end

    context 'Searching for salt and egg' do
      context 'first recommendation' do
        subject(:first_recommendation) do
          recipes_found.first
        end

        let(:product_ids) { [salt.id, egg.id] }

        it 'suggest scrambled eggs first as it matches most ingredients' do
          expect(first_recommendation).to eq(scrambled_eggs)
        end
      end

      context 'second recommendation' do
        subject(:second_recommendation) do
          recipes_found.second
        end

        let(:product_ids) { [salt.id, egg.id] }

        it 'suggests tequilla as second as it contains salt' do
          expect(second_recommendation).to eq(tequilla)
        end
      end
    end
  end
end
