# frozen_string_literal: true

module Api
  module V1
    class RecipesController < ApplicationController
      def search
        recipes = RecipeRepository.find_for_products(search_params.split(','))
        render json: recipes, status: recipes.empty? ? 404 : 200
      end

      private

      def search_params
        params.require(:product_ids)
      end
    end
  end
end
