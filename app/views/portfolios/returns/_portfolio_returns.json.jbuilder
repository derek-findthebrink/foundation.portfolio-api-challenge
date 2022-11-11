json.returns do
  json.array! portfolio_returns do |portfolio_return|
    json.symbol portfolio_return[:symbol]
    json.quantity portfolio_return[:quantity]
    json.purchase_cost Money.from_cents(portfolio_return[:purchase_cost_cents], 'CAD').format
    json.current_stock_value Money.from_cents(portfolio_return[:current_market_price_cents], 'CAD').format
    json.current_holding_value Money.from_cents(portfolio_return[:current_holding_value_cents], 'CAD').format
    json.net_return Money.from_cents(portfolio_return[:net_return_cents], 'CAD').format
  end
end
