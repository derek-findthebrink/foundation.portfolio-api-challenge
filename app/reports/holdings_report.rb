class HoldingsReport
  Result = Struct.new(:success, :holdings)

  def initialize(portfolio)
    @portfolio = portfolio
    @quantities = fetch_quantities
    @average_buy_prices = fetch_average_buy_prices
    @symbols = quantities.keys
  end

  def result
    Result.new(true, data)
  end

  private

  attr_reader :portfolio, :quantities, :average_buy_prices, :symbols

  def data
    final = []

    symbols.each do |symbol|
      final << {
        symbol: symbol,
        signed_quantity: quantities[symbol],
        average_price_cents: average_buy_prices[symbol]
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

  def fetch_average_buy_prices
    portfolio.trades.joins(:stock)
             .where(trade_type: Trade::BUY)
             .group(:symbol)
             .pluck('symbol', 'AVG(price_cents)')
             .to_h
  end
end
