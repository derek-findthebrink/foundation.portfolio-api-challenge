# Handles all logic for creating trades
class Portfolios::CreateTradeForm
  # IDEA: consider using new instance of model and validating on it directly

  Result = Struct.new(:success, :trade)

  def initialize(portfolio, params)
    # IDEA: ensure portfolio is an instance of portfolio
    @portfolio = portfolio
    # IDEA: add validations on params
    @params = params
    @success = false

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
    @success = if trade.persisted?
                 true
               else
                 # IDEA: add error message to Result
                 false
               end
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
    # NOTE: in this case, stock find/create errors are not expected
    @success
  end
end
