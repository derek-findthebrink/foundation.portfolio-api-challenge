json.trade do
  # TODO: format quantity to rounded
  # TODO: format price_cents
  json.extract! trade, :id, :trade_type, :quantity, :time
  json.symbol trade.stock.symbol
  json.quantity trade.quantity.to_i
  # TODO: reconsider how these are displayed once holdings report is complete
  json.unit_price trade.price.format(symbol: false)
  json.currency trade.price_currency
end
