json.returns do
  json.array! portfolio_returns do |portfolio_return|
    json.symbol portfolio_return[:symbol]
    json.quantity portfolio_return[:quantity]
    json.average_purchase_cost_per_stock Money.from_cents(portfolio_return[:average_purchase_cost_per_stock_cents],
                                                          'CAD').format
    json.average_purchase_cost Money.from_cents(portfolio_return[:purchase_value_cents], 'CAD').format
    json.current_stock_value Money.from_cents(portfolio_return[:current_price_cents], 'CAD').format
    json.current_holding_value Money.from_cents(portfolio_return[:current_holding_value_cents], 'CAD').format
    json.return Money.from_cents(portfolio_return[:net_return_cents], 'CAD').format
  end
end
