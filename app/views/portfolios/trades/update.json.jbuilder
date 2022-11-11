json.success update_result.success
json.data do
  json.partial! partial: 'portfolios/trades/trade', trade: update_result.trade
end

unless update_result.success
  json.errors do
    json.array! update_result.trade.errors.map(&:full_message)
  end
end
