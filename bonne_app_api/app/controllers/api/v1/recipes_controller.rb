# frozen_string_literal: true

module Api
  module V1
    class RecipesController < ApplicationController
      def search
        contract = Recipes::SearchContract.new.call(search_params.to_h)

        if contract.success?
          render json: recipes.limit(20), status: recipes.empty? ? 404 : 200
        else
          render json: contract.errors.to_h, status: 400
        end
      end

      private

      def recipes
        query = RecipeRepository.find_for_products(product_ids)
        query = query.cold if only_cold?

        query = query.with_ratings_better_or_equal_to(min_rating) if min_rating.positive?

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
