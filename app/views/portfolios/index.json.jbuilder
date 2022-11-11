# TODO: attach to real life value
json.success true
json.data do
  json.partial! partial: 'portfolios/portfolio', portfolio: portfolio
end
