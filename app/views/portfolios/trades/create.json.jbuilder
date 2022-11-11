json.success create_result.success
json.data do
  json.partial! partial: 'portfolios/trades/trade', trade: create_result.trade
end

unless create_result.success
  json.errors do
    json.array! create_result.trade.errors.map(&:full_message)
  end
end
