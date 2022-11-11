json.array! portfolio_holdings do |holding|
  json.symbol holding[:symbol]
  json.quantity holding[:signed_quantity]
  json.average_price Money.from_cents(holding[:average_price_cents], 'CAD').format
end
