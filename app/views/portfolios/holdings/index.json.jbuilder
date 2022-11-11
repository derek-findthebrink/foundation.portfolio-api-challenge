json.success holdings_result.success
json.data do
  json.partial! partial: 'portfolios/holdings/portfolio_holdings', portfolio_holdings: holdings_result.holdings
end
