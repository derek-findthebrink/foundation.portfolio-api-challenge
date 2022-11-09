# Holds historical price data
class StockPrice < ApplicationRecord
  belongs_to :stock

  monetize :price_cents, allow_nil: false, numericality: {
    greater_than_or_equal_to: 0
  }

  # TODO: add validations (price: in range)
end
