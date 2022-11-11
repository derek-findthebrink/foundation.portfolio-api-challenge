# Displays portfolio data
class PortfoliosController < ApplicationController
  let(:holdings) { HoldingsReport.new(portfolio).result.holdings }
  let(:returns) { ReturnsReport.new(portfolio).result.returns }
  let(:trade_query) do
    portfolio.trades.joins(:stock)
             .includes(:stock)
             .order(symbol: :asc, time: :asc)
  end

  def index; end
end
