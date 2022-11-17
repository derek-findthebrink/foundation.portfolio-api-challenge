# Extracts, calculates and produces the required data to show portfolio holdings
class HoldingsReport
  # TODO: Add tests!
  Result = Struct.new(:success, :holdings, :symbols)

  Holding = Struct.new(:symbol, :quantity, :average_unit_purchase_cost_cents)

  def initialize(portfolio)
    @portfolio = portfolio
    @quantities = fetch_quantities
    @symbols = quantities.keys
    @purchase_values = fetch_purchase_values
  end

  def result
    Result.new(true, data, symbols)
  end

  private

  attr_reader :portfolio, :quantities, :purchase_values, :symbols

  def data
    final = []

    symbols.each do |symbol|
      quantity = quantities[symbol]
      purchase_value = purchase_values[symbol]
      final << Holding.new(symbol, quantity, purchase_value)
    end

    final
  end

  def fetch_quantities
    # IDEA: make a scope out of the commonly used components of this and other
    # reporting queries
    portfolio.trades.joins(:stock)
             .select(:symbol, :signed_quantity)
             .group(:symbol)
             .having('SUM(signed_quantity) > 0')
             .pluck('symbol', 'SUM(signed_quantity)')
             .to_h
  end

  def fetch_purchase_values
    trades = portfolio.trades.joins(:stock)
                      .where({ trade_type: Trade::BUY, stocks: { symbol: symbols } })

    intermediate = trades.each_with_object({}) do |trade, acc|
      acc[trade.stock.symbol] ||= { cost_cents: 0, quantity: 0 }
      acc[trade.stock.symbol][:cost_cents] += trade.price_cents * trade.signed_quantity
      acc[trade.stock.symbol][:quantity] += trade.signed_quantity
    end

    intermediate.transform_values do |value|
      value[:cost_cents] / value[:quantity]
    end
  end
end
