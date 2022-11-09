# displays current portfolio holdings
class Portfolios::HoldingsController < ApplicationController
  def index
    render body: 'holdings index'
  end
end
