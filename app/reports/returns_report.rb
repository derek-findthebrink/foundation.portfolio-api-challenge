# Extracts, calculates and produces the required data to show portfolio returns
class ReturnsReport
  # TODO: Add tests
  Result = Struct.new(:success, :returns)

  Return = Struct.new(:symbol, :holding, :current_price) do
    delegate :quantity, :average_unit_purchase_cost_cents, to: :holding

    def total_purchase_cost_cents
      quantity * average_unit_purchase_cost_cents
    end

    def current_market_price_cents
      current_price.price_cents
    end

    def current_holding_value_cents
      quantity * current_market_price_cents
    end

    def net_return_cents
      current_holding_value_cents - total_purchase_cost_cents
    end
  end

  def initialize(portfolio)
    @portfolio = portfolio
    @holdings_result = HoldingsReport.new(portfolio).result
    @symbols = holdings_result.symbols
    @current_holdings = holdings_result.holdings.to_h { |holding| [holding[:symbol], holding] }
    @current_prices = fetch_current_prices
  end

  def result
    Result.new(true, returns)
  end

  private

  attr_reader :portfolio, :current_holdings, :current_prices, :symbols,
              :holdings_result

  def returns
    final = []

    current_prices.each do |current_price|
      symbol = current_price.stock.symbol
      holding = current_holdings[symbol]
      final << Return.new(symbol, holding, current_price)
    end

    final
  end

  def fetch_current_prices
    StockPrice.most_recent_prices_by_stock.joins(:stock)
              .includes(:stock)
              .where({ stocks: { symbol: symbols } })
  end
end
