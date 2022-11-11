json.partial! partial: 'portfolios/returns/portfolio_returns', portfolio_returns: returns

json.partial! partial: 'portfolios/holdings/portfolio_holdings', portfolio_holdings: holdings

json.trades trade_query do |trade|
  json.symbol trade.symbol
  json.trade_type trade.trade_type
  json.quantity trade.quantity
  json.price_cents Money.from_cents(trade.price_cents, 'CAD').format
  json.trade_time trade.time.to_formatted_s(:rfc822)
  json.trade_id trade.id
end
