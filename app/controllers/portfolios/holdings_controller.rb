# displays current portfolio holdings
class Portfolios::HoldingsController < ApplicationController
  let(:holdings_result) { HoldingsReport.new(portfolio).result }

  def index; end
end
