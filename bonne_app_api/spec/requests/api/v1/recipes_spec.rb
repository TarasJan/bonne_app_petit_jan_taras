# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Recipes', type: :request do
  describe 'GET /search' do
    context "empty search query" do
      let(:product_ids) { "" }

      it 'responds with not found status' do
        get '/api/v1/recipes/search', params: {product_ids:}

        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)).to eq([])
      end
    end

    describe "product search" do
      let(:ham) { create(:product, name: 'ham') }
      let(:egg) { create(:product, name: 'egg') }
      let(:salt) { create(:product, name: 'salt') }
      let(:lemon) { create(:product, name: 'lemon') }
      let(:rum) { create(:product, name: 'rum') }

      # not used in any recipes
      let!(:exotic_mushroom) { create(:product, name: 'exotic mushroom') }

      let(:scrambled_eggs) { create(:recipe, title: 'Scrambled eggs') }
      let(:mojito) { create(:recipe, title: 'Mojito') }

      before do
        create(:ingredient, product: egg, recipe: scrambled_eggs)
        create(:ingredient, product: salt, recipe: scrambled_eggs)
        create(:ingredient, product: ham, recipe: scrambled_eggs)
        create(:ingredient, product: salt, recipe: mojito)
        create(:ingredient, product: lemon, recipe: mojito)
        create(:ingredient, product: rum, recipe: mojito)
      end
      
      context "searching for lemon" do
        let(:product_ids) do
          lemon.id
        end

        subject(:parsed_response) do
          JSON.parse(response.body)
        end

        it "returns mojito recipe as the first and only match" do
          get '/api/v1/recipes/search', params: {product_ids:}
        
          expect(response).to have_http_status(:ok)
          expect(parsed_response.first['title']).to eq('Mojito')
          expect(parsed_response.size).to eq(1)
        end
      end

      context "searching for lemon, rum, salt and ham" do
        let(:product_ids) do
          [lemon.id, salt.id, ham.id, rum.id].join(',')
        end

        subject(:parsed_response) do
          JSON.parse(response.body)
        end

        it "returns tequilla recipe as the first and scrambled eggs as second" do
          get '/api/v1/recipes/search', params: {product_ids:}
        
          expect(response).to have_http_status(:ok)
          expect(parsed_response.first['title']).to eq('Mojito')
          expect(parsed_response.second['title']).to eq('Scrambled eggs')
          expect(parsed_response.size).to eq(2)
        end
      end
    end
  end
end
