require 'rails_helper'

RSpec.describe "Api::V1::Products", type: :request do
  before do
    5.times do
      create(:product, :with_ingredients, ingredient_count: 5)
    end

    7.times do
      create(:product, :with_ingredients, ingredient_count: 3)
    end
  end

  describe "GET /most_common" do
    subject(:parsed_response) do
      JSON.parse(response.body)
    end

    it "responds with 10 most common products" do
      get "/api/v1/products/most_common"

      expect(response).to have_http_status(:ok)
      expect(parsed_response.size).to eq(10)
      expect(parsed_response.pluck("mentions").sum).to eq(40)
    end

    context "with limit param" do
      it "adjusts number of returned items to limit" do
        get "/api/v1/products/most_common", params: { limit: 5 }

        expect(response).to have_http_status(:ok)
        expect(parsed_response.size).to eq(5)
        expect(parsed_response.pluck("mentions").sum).to eq(25)
      end
    end
  end
end
