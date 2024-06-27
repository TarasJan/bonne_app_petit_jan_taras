# frozen_string_literal: true

module Api
  module V1
    class RecipesController < ApplicationController
      def search
        render json: recipes, status: recipes.empty? ? 404 : 200
      end

      private

      def recipes
        query = RecipeRepository.find_for_products(product_ids)
        if only_cold?
          query = query.cold
        end

        if min_rating > 0
          query = query.with_ratings_better_or_equal_to(min_rating)
        end
        
        query
      end

      def only_cold?
        ActiveModel::Type::Boolean.new.cast(search_params['cold'])
      end

      def min_rating
        search_params['min_rating'].to_i
      end

      def product_ids
        search_params['product_ids'].split(',')
      end

      def search_params
        params.permit(:product_ids, :cold, :min_rating)
      end
    end
  end
end
