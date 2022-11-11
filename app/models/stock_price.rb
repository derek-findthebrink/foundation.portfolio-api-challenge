# Holds historical price data
class StockPrice < ApplicationRecord
  belongs_to :stock

  monetize :price_cents, allow_nil: false, numericality: {
    greater_than_or_equal_to: 0
  }

  # TODO: add validations (price: in range)

  delegate :symbol, to: :stock

  # TODO: test this
  # TODO: explain what this does
  scope :most_recent_prices_by_stock, lambda {
    from(
      <<-SQL
        (
          SELECT stock_prices.*
          FROM stock_prices JOIN (
             SELECT stock_id, MAX(time) AS time
             FROM stock_prices
             GROUP BY stock_id
          ) latest_by_time
          ON stock_prices.time = latest_by_time.time
          AND stock_prices.stock_id = stock_prices.stock_id
        ) stock_prices
      SQL
    )
  }
end
