# Handles all logic for creating trades
class Portfolios::UpdateTradeForm
  # TODO: ensure portfolio is an instance of portfolio
  # TODO: add validations on params
  # TODO: consider using new instance of model and validating on it directly

  Result = Struct.new(:success, :trade)

  def initialize(portfolio, params)
    @portfolio = portfolio
    @trade = portfolio.trades.find(params['id'])
    @params = params

    run!
  end

  def result
    Result.new(success?, trade)
  end

  private

  attr_reader :portfolio, :params, :stock, :trade

  def run!
    # TODO: raise error if trade can't be found
    stock_symbol = params['symbol']

    # TODO: ensure symbol update is working as expected
    @stock = if stock_symbol.present?
               Stock.find_or_create_by(symbol: stock_symbol)
             else
               trade.stock
             end

    trade.update(trade_attributes)
  end

  def trade_attributes
    params.except('id', 'symbol').merge(stock: stock)
  end

  def success?
    # TODO: check for trade update errors
    true
  end
end
