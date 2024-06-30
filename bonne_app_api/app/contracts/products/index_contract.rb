# frozen_string_literal: true

module Products
  class IndexContract < Dry::Validation::Contract
    params do
      optional(:limit).value(:integer)
    end

    rule(:limit) do
      key.failure('must be greater than 0') if key? && value <= 0
    end
  end
end
