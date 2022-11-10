json.extract! portfolio, :id, :created_at, :updated_at
# TODO: add holdings
# TODO: trades should be sorted by time ascending
json.trades portfolio.trades do |trade|
  # TODO: avoid n+1 here (symbol requests stock)
  json.extract! trade, :id, :time, :price_cents, :quantity, :symbol
end
json.url portfolio_url(portfolio, format: :json)
