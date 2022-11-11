# Handles all logic for creating trades
class Portfolios::CreateTradeForm
  # TODO: ensure portfolio is an instance of portfolio
  # TODO: add validations on params
  # TODO: consider using new instance of model and validating on it directly

  Result = Struct.new(:success, :trade)

  def initialize(portfolio, params)
    @portfolio = portfolio
    @params = params

    run!
  end

  def result
    Result.new(success?, trade)
  end

  private

  attr_reader :portfolio, :params, :stock, :trade

  def run!
    stock_symbol = params['symbol'].downcase
    @stock = find_or_create_stock(stock_symbol)

    @trade = portfolio.trades.create(trade_attributes)
  end

  def trade_attributes
    params.except('symbol').merge({ stock: stock, time: Time.current })
  end

  def find_or_create_stock(symbol)
    stock = Stock.find_by(symbol: symbol)

    return stock if stock.present?

    Stock.create!(symbol: symbol)
  end

  def success?
    # TODO: check for trade creation errors
    # NOTE: in this case, stock find/create errors are not expected
    true
  end
end
