# Holds historical price data
class StockPrice < ApplicationRecord
  belongs_to :stock

  monetize :price_cents, allow_nil: false, numericality: {
    greater_than_or_equal_to: 0
  }

  delegate :symbol, to: :stock

  # TODO: test this
  # NOTE: This is definitely a personal choice for me. There are some more details
  # in the README on why I'm doing this, including reasons on why and why not to not do this :D
  # NOTE: This query finds and matches the most recent stock price for each stock
  # IDEA: consider using a more specific time format on the DB to avoid trades
  # happening at the exact same time (enable this query to have a really strong tie-breaker)
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
