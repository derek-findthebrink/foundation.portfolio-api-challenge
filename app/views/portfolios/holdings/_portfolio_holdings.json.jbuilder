json.holdings do
  json.array! portfolio_holdings do |holding|
    json.symbol holding.symbol
    json.quantity holding.quantity
    json.average_price Money.from_cents(holding.average_unit_purchase_cost_cents, 'CAD').format
  end
end
