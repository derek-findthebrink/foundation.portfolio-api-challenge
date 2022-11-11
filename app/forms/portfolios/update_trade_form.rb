# Handles all logic for creating trades
class Portfolios::UpdateTradeForm
  Result = Struct.new(:success, :trade)

  def initialize(portfolio, params)
    # IDEA: ensure portfolio is an instance of portfolio
    @portfolio = portfolio
    @trade = portfolio.trades.find(params['id'])
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
    stock_symbol = params['symbol']

    @stock = if stock_symbol.present?
               Stock.find_or_create_by(symbol: stock_symbol)
             else
               trade.stock
             end

    updated = trade.update(trade_attributes)

    @success = if updated
                 true
               else
                 false
               end
  end

  def trade_attributes
    params.except('id', 'symbol').merge(stock: stock)
  end

  def success?
    @success
  end
end
