class ReturnsReport
  Result = Struct.new(:success, :returns)

  def initialize(portfolio)
    @portfolio = portfolio
    @holdings = HoldingsReport.new(portfolio).result['holdings']
    @current_holdings_symbols = holdings.map { |holding| holding[:symbol] }
  end

  def result
    Result.new(true, returns)
  end

  private

  attr_reader :portfolio, :holdings, :current_holdings_symbols

  def returns
    data = purchase_values
    final = []

    current_prices.each do |current_price|
      symbol = current_price.stock.symbol
      purchase_data = data[symbol]
      current_holding_value_cents = current_price.price_cents * purchase_data[:quantity]
      current_price_data = {
        current_price_cents: current_price.price_cents,
        current_holding_value_cents: current_holding_value_cents,
        net_return_cents: current_holding_value_cents - purchase_data[:purchase_value_cents]
      }
      final << purchase_data.merge(current_price_data)
    end

    final
  end

  def purchase_values
    holdings.each_with_object({}) do |holding, acc|
      purchase_value = {
        symbol: holding[:symbol],
        quantity: holding[:signed_quantity],
        average_purchase_cost_per_stock_cents: holding[:average_price_cents],
        purchase_value_cents: holding[:signed_quantity] * holding[:average_price_cents]
      }
      acc[holding[:symbol]] = purchase_value
    end
  end

  def current_prices
    StockPrice.most_recent_prices_by_stock.joins(:stock)
              .includes(:stock)
              .where({ stocks: { symbol: current_holdings_symbols } })
  end
end
