# Holds information on trades executed within a portfolio
class Trade < ApplicationRecord
  # NOTE: the values of these enums CANNOT BE CHANGED without also altering the
  # DB enum. Don't change 'em unless you also write a migration for this! :D
  BUY = 'BUY'.freeze
  SELL = 'SELL'.freeze

  belongs_to :portfolio
  belongs_to :stock

  delegate :symbol, to: :stock

  enum trade_type: {
    buy: BUY,
    sell: SELL
  }

  monetize :price_cents, allow_nil: false, numericality: {
    greater_than_or_equal_to: 0
  }

  # TODO: add validations (quantity, trade_type, stock)

  after_save :update_stock_price

  private

  # This only runs when a new trade is created
  def update_stock_price
    stock.stock_prices.create(time: Time.current, price: price)
  end
end
