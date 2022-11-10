class Portfolios::TradesController < ApplicationController
  # TODO: add unpermitted params error messaging
  let(:create_result) do
    Portfolios::CreateTradeForm
      .new(portfolio, create_params.to_h)
      .result
  end

  def create; end

  def update; end

  def destroy; end

  def create_params
    params.require(:trade).permit(:trade_type, :quantity, :symbol, :price)
  end
end
