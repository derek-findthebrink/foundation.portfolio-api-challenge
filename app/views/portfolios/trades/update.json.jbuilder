json.success update_result.success
json.data do
  json.partial! partial: 'portfolios/trades/trade', trade: update_result.trade
end
