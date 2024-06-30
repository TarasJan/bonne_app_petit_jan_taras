# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Recipes', type: :request do
  describe 'GET /search' do
    describe 'errors' do
      subject(:parsed_response) do
        JSON.parse(response.body)
      end

      context 'when called with negative minimal rating' do
        it 'returns status code Bad Request with meaningful error' do
          get '/api/v1/recipes/search', params: { product_ids: SecureRandom.uuid, min_rating: -5 }

          expect(response).to have_http_status(:bad_request)
          expect(parsed_response).to match('min_rating' => ['must be greater or equal to 0'])
        end
      end

      context 'when called with minimal rating greater than 5' do
        it 'returns status code Bad Request with meaningful error' do
          get '/api/v1/recipes/search', params: { product_ids: SecureRandom.uuid, min_rating: 5.2 }

          expect(response).to have_http_status(:bad_request)
          expect(parsed_response).to match('min_rating' => ['must be less or equal to 5'])
        end
      end

      context 'cold param is non boolean' do
        it 'returns status code Bad Request with meaningful error' do
          get '/api/v1/recipes/search', params: { product_ids: SecureRandom.uuid, cold: 123 }

          expect(response).to have_http_status(:bad_request)
          expect(parsed_response).to match('cold' => ['must be boolean'])
        end
      end
    end

    context 'empty search query' do
      let(:product_ids) { '' }

      it 'responds with not found status' do
        get '/api/v1/recipes/search', params: { product_ids: }

        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)).to eq([])
      end
    end

    describe 'product search' do
      let(:ham) { create(:product, name: 'ham') }
      let(:egg) { create(:product, name: 'egg') }
      let(:salt) { create(:product, name: 'salt') }
      let(:lemon) { create(:product, name: 'lemon') }
      let(:rum) { create(:product, name: 'rum') }

      # not used in any recipes
      let!(:exotic_mushroom) { create(:product, name: 'exotic mushroom') }

      let(:scrambled_eggs) { create(:recipe, title: 'Scrambled eggs', ratings: 5, cook_time: 10) }
      let(:mojito) { create(:recipe, title: 'Mojito', cook_time: 0) }
      let(:sandwich) { create(:recipe, title: 'Sandwich', ratings: 3, cook_time: 0) }

      before do
        create(:ingredient, product: egg, recipe: scrambled_eggs)
        create(:ingredient, product: salt, recipe: scrambled_eggs)
        create(:ingredient, product: ham, recipe: scrambled_eggs)
        create(:ingredient, product: ham, recipe: sandwich, amount: 1, unit: 'slice')
        create(:ingredient, product: salt, recipe: mojito)
        create(:ingredient, product: lemon, recipe: mojito)
        create(:ingredient, product: rum, recipe: mojito)
      end

      context 'searching for lemon' do
        subject(:parsed_response) do
          JSON.parse(response.body)
        end

        let(:product_ids) do
          lemon.id
        end

        it 'returns mojito recipe as the first and only match' do
          get '/api/v1/recipes/search', params: { product_ids: }

          expect(response).to have_http_status(:ok)
          expect(parsed_response.first['title']).to eq('Mojito')
          expect(parsed_response.size).to eq(1)
        end
      end

      context 'searching for lemon, rum, salt and ham' do
        subject(:parsed_response) do
          JSON.parse(response.body)
        end

        let(:product_ids) do
          [lemon.id, salt.id, ham.id, rum.id].join(',')
        end

        it 'returns tequilla recipe as the first and scrambled eggs as second, and lastly sandwich' do
          get '/api/v1/recipes/search', params: { product_ids: }

          expect(response).to have_http_status(:ok)
          expect(parsed_response.first['title']).to eq('Mojito')
          expect(parsed_response.second['title']).to eq('Scrambled eggs')
          expect(parsed_response.third['title']).to eq('Sandwich')
          expect(parsed_response.size).to eq(3)
        end
      end

      describe 'min rating filter' do
        subject(:parsed_response) do
          JSON.parse(response.body)
        end

        let(:product_ids) do
          ham.id
        end

        it 'returns 5 star dish cold dish - scrambed eggs' do
          get '/api/v1/recipes/search', params: { product_ids:, min_rating: 5 }

          expect(response).to have_http_status(:ok)
          expect(parsed_response.first['title']).to eq('Scrambled eggs')
          expect(parsed_response.size).to eq(1)
        end
      end

      describe 'cold filter' do
        subject(:parsed_response) do
          JSON.parse(response.body)
        end

        let(:product_ids) do
          ham.id
        end

        it 'returns only cold dish - sandwich' do
          get '/api/v1/recipes/search', params: { product_ids:, cold: true }

          expect(response).to have_http_status(:ok)
          expect(parsed_response.first['title']).to eq('Sandwich')
          expect(parsed_response.size).to eq(1)
        end
      end

      describe 'response shape' do
        subject(:parsed_response) do
          JSON.parse(response.body)
        end

        let(:product_ids) do
          ham.id
        end

        it 'returns only cold dish - sandwich' do
          get '/api/v1/recipes/search', params: { product_ids:, cold: true }

          expect(response).to have_http_status(:ok)
          expect(parsed_response).to match([
                                             {
                                               'author' => sandwich.author,
                                               'cook_time' => sandwich.cook_time,
                                               'id' => sandwich.id,
                                               'prep_time' => sandwich.prep_time,
                                               'ratings' => sandwich.ratings,
                                               'title' => sandwich.title,
                                               'ingredients' => [{
                                                 'amount' => 1,
                                                 'name' => ham.name,
                                                 'product_id' => ham.id,
                                                 'unit' => 'slice',
                                                 'id' => an_instance_of(String)
                                               }]
                                             }
                                           ])
        end
      end
    end
  end
end
