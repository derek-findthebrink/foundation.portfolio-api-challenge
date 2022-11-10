# Holds information on trades executed within a portfolio
class Trade < ApplicationRecord
  # NOTE: the values of these enums CANNOT BE CHANGED without also altering the
  # DB enum
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

  # TODO: add validations (quantity, type, stock)

  def order_total
    (price * quantity).format
  end
end
