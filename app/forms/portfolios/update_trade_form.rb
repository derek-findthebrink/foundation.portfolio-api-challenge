# Handles all logic for creating trades
class Portfolios::UpdateTradeForm
  # TODO: add tests!
  Result = Struct.new(:success, :trade)

  def initialize(portfolio, params)
    # IDEA: ensure portfolio is an instance of portfolio
    @portfolio = portfolio
    @params = params
    @trade = portfolio.trades.find_by_id(params['id'])
    # IDEA: add validations on params
    @success = false

    return unless trade.present?

    run!
  end

  def result
    Result.new(success?, trade)
  end

  private

  attr_reader :portfolio, :params, :stock, :trade

  def run!
    @stock = if stock_symbol.present?
               Stock.find_or_create_by(symbol: stock_symbol)
             else
               trade.stock
             end

    @success = if trade.update(trade_attributes)
                 true
               else
                 false
               end
  end

  def trade_attributes
    params.except('id', 'symbol').merge(stock: stock)
  end

  def stock_symbol
    params['symbol']
  end

  def success?
    @success
  end
end
