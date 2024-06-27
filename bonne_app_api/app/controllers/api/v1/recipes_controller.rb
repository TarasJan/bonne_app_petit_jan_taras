# frozen_string_literal: true

module Api
  module V1
    class RecipesController < ApplicationController
      def search
        recipes = RecipeRepository.find_for_products(product_ids)
        render json: recipes, status: recipes.empty? ? 404 : 200
      end

      private

      def product_ids
        search_params['product_ids'].split(',')
      end

      def search_params
        params.permit(:product_ids)
      end
    end
  end
end
