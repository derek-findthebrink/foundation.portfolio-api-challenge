json.returns do
  json.array! portfolio_returns do |portfolio_return|
    json.symbol portfolio_return.symbol
    json.quantity portfolio_return.quantity
    json.average_cost_per_unit Money.from_cents(portfolio_return.average_unit_purchase_cost_cents, 'CAD').format
    json.total_purchase_cost Money.from_cents(portfolio_return.total_purchase_cost_cents, 'CAD').format
    json.current_stock_value Money.from_cents(portfolio_return.current_market_price_cents, 'CAD').format
    json.current_holding_value Money.from_cents(portfolio_return.current_holding_value_cents, 'CAD').format
    json.unrealized_gain_or_loss Money.from_cents(portfolio_return.net_return_cents, 'CAD').format
  end
end
