class Api::V1::ProductsController < ApplicationController
  def index
    render json: ProductRepository.most_common(limit), each_serializer: ProductSerializer
  end

  private

  def limit
    permitted_params["limit"] || 100
  end

  def permitted_params
    params.permit(:limit)
  end
end
