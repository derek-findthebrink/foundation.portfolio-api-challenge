class Portfolios::TradesController < ApplicationController
  # IDEA: add unpermitted params error messaging
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
    # IDEA: change to before_action filter
    unless id_in_params?(update_params)
      render_failure('You must pass a trade ID in order to update a trade', :bad_request)
      # NOTE: we return early here to prevent the default rendering mechanism from kicking in
      return
    end

    # IDEA: change to before_action filter
    unless trade_present?(update_params)
      render_failure("Could not find trade with ID: #{trade_id(update_params)}", :not_found)
      # NOTE: we return early here to prevent the default rendering mechanism from kicking in
      # rubocop:disable Style/RedundantReturn
      return
      # rubocop:enable Style/RedundantReturn
    end
  end

  def destroy
    # IDEA: change to before_action filter
    unless params.dig('id').present?
      render_failure('You must pass a trade ID in order to delete a trade', :bad_request)
      return
    end

    id = params.fetch('id')

    # IDEA: change to around_action filter
    begin
      portfolio.trades.destroy(id)
      render json: { success: true, data: { trade: { id: id } } }
    rescue ActiveRecord::RecordNotFound
      render_failure("Could not find trade with ID: #{id}")
    end
  end

  private

  def create_params
    params.require(:trade).permit(:trade_type, :quantity, :symbol, :price)
  end

  def update_params
    # IDEA: ID can and probs should be pulled from the path only
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
    portfolio.trades.find_by_id(trade_id(body))
  end
end
