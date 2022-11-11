class HoldingsReport
  Result = Struct.new(:success, :holdings)

  def initialize(portfolio)
    @portfolio = portfolio
    @quantities = fetch_quantities
    @symbols = quantities.keys
    @purchase_values = fetch_purchase_values
  end

  def result
    Result.new(true, data)
  end

  private

  attr_reader :portfolio, :quantities, :purchase_values, :symbols

  def data
    final = []

    symbols.each do |symbol|
      final << {
        symbol: symbol,
        signed_quantity: quantities[symbol],
        average_price_cents: purchase_values[symbol] / quantities[symbol]
      }
    end

    final
  end

  def fetch_quantities
    portfolio.trades.joins(:stock)
             .select(:symbol, :signed_quantity)
             .group(:symbol)
             .having('SUM(signed_quantity) > 0')
             .pluck('symbol', 'SUM(signed_quantity)')
             .to_h
  end

  def fetch_purchase_values
    trades = portfolio.trades.joins(:stock)
                      .includes(:stock)
                      .where({ trade_type: Trade::BUY, stocks: { symbol: symbols } })

    trades.each_with_object({}) do |trade, acc|
      acc[trade.stock.symbol] ||= 0
      acc[trade.stock.symbol] += trade.price_cents * trade.signed_quantity
    end
  end
end
