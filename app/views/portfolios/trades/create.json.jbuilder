json.success create_result.success
json.data do
  json.partial! partial: 'portfolios/trades/trade', trade: create_result.trade
end
