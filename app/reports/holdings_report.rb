class HoldingsReport
  Result = Struct.new(:success, :holdings)

  def initialize(portfolio)
    @portfolio = portfolio
  end

  def result
    Result.new(true, data)
  end

  private

  attr_reader :portfolio

  def data
    final = []

    query.each do |row|
      symbol, signed_quantity, average_price_cents = row
      final << {
        symbol: symbol,
        signed_quantity: signed_quantity,
        average_price_cents: average_price_cents
      }
    end

    final
  end

  def query
    portfolio.trades.joins(:stock)
             .select(:symbol, :signed_quantity)
             .group(:symbol)
             .pluck('symbol', 'SUM(signed_quantity)', 'AVG(price_cents)')
  end
end
