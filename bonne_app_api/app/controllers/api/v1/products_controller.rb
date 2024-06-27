class Api::V1::ProductsController < ApplicationController
  def most_common
    render json: ProductRepository.most_common(limit), each_serializer: ProductSerializer
  end

  private

  def limit
    permitted_params["limit"] || 10
  end

  def permitted_params
    params.permit(:limit)
  end
end
