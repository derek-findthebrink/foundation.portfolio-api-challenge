json.success returns_result.success
json.data do
  json.partial! partial: 'portfolios/returns/portfolio_returns', portfolio_returns: returns_result.returns
end
