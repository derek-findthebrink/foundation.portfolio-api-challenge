json.success result.success?
json.data do
  json.partial! partial: 'portfolios/portfolio', portfolio: portfolio
end
