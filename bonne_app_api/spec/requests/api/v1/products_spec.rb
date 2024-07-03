# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Products', type: :request do
  subject(:parsed_response) do
    JSON.parse(response.body)
  end


  describe 'errors' do
    context 'with zero limit param' do
      it 'returns status code Bad Request with meaningful error' do
        get '/api/v1/products', params: { limit: 0 }

        expect(response).to have_http_status(:bad_request)
        expect(parsed_response).to match('limit' => ['must be greater than 0'])
      end
    end
  end

  describe 'response shape' do
    it 'has the required fields' do
      get '/api/v1/products', params: { limit: 1 }

      expect(parsed_response).to match(
        [
          {
            'id' => an_instance_of(String),
            'name' => an_instance_of(String),
            'mentions' => an_instance_of(Integer)
          }
        ]
      )
    end
  end

  describe 'GET /' do

    describe "non-search request" do
      before do
        5.times do
          create(:product, :with_ingredients, ingredient_count: 5)
        end
    
        7.times do
          create(:product, :with_ingredients, ingredient_count: 3)
        end
      end

      it 'responds with 12 most common products' do
        get '/api/v1/products'
  
        expect(response).to have_http_status(:ok)
        expect(parsed_response.size).to eq(12)
        expect(parsed_response.pluck('mentions').sum).to eq(46)
      end
  
      context 'with limit param' do
        it 'adjusts number of returned items to limit' do
          get '/api/v1/products', params: { limit: 5 }
  
          expect(response).to have_http_status(:ok)
          expect(parsed_response.size).to eq(5)
          expect(parsed_response.pluck('mentions').sum).to eq(25)
        end
      end
    end

    context 'with search param' do
      it "finds the products matching search string" do
        let(:kefir) do
          create(:product, :with_ingredients, name: "kefir", ingredient_count: 2)
        end

        before do

            create(:product, :with_ingredients, name: "sunflower", ingredient_count: 3)
        end

        it 'adjusts number of returned items to limit' do
          get '/api/v1/products', params: { search: kefir.name }
  
          expect(parsed_response).to match(
        [
          {
            'id' => kefir.id,
            'name' => kefir.name,
            'mentions' => 2
          }
        ]
      )
        end

  
      end
    end
  end
end
