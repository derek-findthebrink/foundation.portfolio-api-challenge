class ReturnsReport
  Result = Struct.new(:success, :returns)

  def initialize(portfolio)
    @portfolio = portfolio
    @current_holdings = fetch_current_holdings
    @current_holdings_symbols = extract_current_holdings_symbols
    @purchase_values = fetch_purchase_values
    @current_prices = fetch_current_prices
  end

  def result
    Result.new(true, returns)
  end

  private

  attr_reader :portfolio, :current_holdings, :current_prices, :current_holdings_symbols,
              :purchase_values

  def returns
    final = []

    current_prices.each do |current_price|
      symbol = current_price.stock.symbol
      quantity = current_holdings[symbol]
      purchase_cost = purchase_values[symbol]
      market_unit_cost = current_price.price_cents
      current_holding_value_cents = quantity * market_unit_cost

      return_data = {
        symbol: symbol,
        quantity: quantity,
        purchase_cost_cents: purchase_cost,
        current_market_price_cents: current_price.price_cents,
        current_holding_value_cents: current_holding_value_cents,
        net_return_cents: current_holding_value_cents - purchase_cost
      }
      final << return_data
    end

    final
  end

  def fetch_purchase_values
    trades = portfolio.trades.joins(:stock)
                      .includes(:stock)
                      .where({ stocks: { symbol: current_holdings_symbols } })

    trades.each_with_object({}) do |trade, acc|
      acc[trade.stock.symbol] ||= 0
      acc[trade.stock.symbol] += trade.price_cents * trade.signed_quantity
    end
  end

  def fetch_current_holdings
    portfolio.trades.joins(:stock)
             .select(:symbol, :signed_quantity)
             .group(:symbol)
             .having('SUM(signed_quantity) > 0')
             .pluck('symbol', 'SUM(signed_quantity)')
             .to_h
  end

  def extract_current_holdings_symbols
    current_holdings.map do |holding|
      symbol, _quantity = holding
      symbol
    end
  end

  def fetch_current_prices
    StockPrice.most_recent_prices_by_stock.joins(:stock)
              .includes(:stock)
              .where({ stocks: { symbol: current_holdings_symbols } })
  end
end
