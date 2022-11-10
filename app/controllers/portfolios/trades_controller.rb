class Portfolios::TradesController < ApplicationController
  # TODO: add unpermitted params error messaging
  let(:create_result) do
    Portfolios::CreateTradeForm
      .new(portfolio, create_params.to_h)
      .result
  end

  let(:update_result) do
    Portfolios::UpdateTradeForm
      .new(portfolio, update_params.to_h)
      .result
  end

  def create; end

  def update
    unless id_in_params?(update_params)
      render_failure('You must pass a trade ID in order to update a trade', :bad_request)
      return
    end

    unless trade_present?(update_params)
      render_failure("Could not find trade with ID: #{update_params.fetch('trade', 'id')}", :not_found)
      # rubocop:disable Style/RedundantReturn
      return
      # rubocop:enable Style/RedundantReturn
    end
  end

  def destroy; end

  private

  def create_params
    params.require(:trade).permit(:trade_type, :quantity, :symbol, :price)
  end

  def update_params
    # TODO: ensure ID is included in params
    params.require(:trade)
          .permit(:id, :time, :trade_type, :quantity, :symbol,
                  :price)
  end

  def id_in_params?(body)
    trade_id(body).present?
  end

  def trade_id(body)
    body['id']
  end

  def trade_present?(body)
    portfolio.trades.find(trade_id(body))
  end
end
