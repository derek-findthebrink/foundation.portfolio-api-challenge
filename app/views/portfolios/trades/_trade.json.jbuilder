json.trade do
  json.extract! trade, :id, :trade_type, :quantity
  json.symbol trade.stock.symbol
  json.quantity trade.quantity
  json.unit_price trade.price.format
  json.time trade.time.to_formatted_s(:rfc822)
end
