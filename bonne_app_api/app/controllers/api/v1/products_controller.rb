# frozen_string_literal: true

module Api
  module V1
    class ProductsController < ApplicationController
      def index
        contract = Products::IndexContract.new.call(permitted_params.to_h)

        if contract.success?
          render json: ProductRepository.most_common(limit), each_serializer: ProductSerializer
        else
          render json: contract.errors.to_h, status: 400
        end
      end

      private

      def limit
        permitted_params['limit'] || 100
      end

      def permitted_params
        params.permit(:limit)
      end
    end
  end
end
