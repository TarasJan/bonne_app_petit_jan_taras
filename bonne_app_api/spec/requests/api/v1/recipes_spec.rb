# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Recipes', type: :request do
  describe 'GET /search' do
    it 'responds with ok status' do
      get '/api/v1/recipes/search'

      expect(response).to have_http_status(:ok)
    end
  end
end
