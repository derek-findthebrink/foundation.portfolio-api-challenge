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
    # QUESTION: this could probs be handled with active-record alone, right?
    # TODO: change to before_action filter
    unless id_in_params?(update_params)
      render_failure('You must pass a trade ID in order to update a trade', :bad_request)
      return
    end

    # TODO: change to before_action filter
    # TODO: change to rescue block on ActiveRecord::RecordNotFound
    unless trade_present?(update_params)
      render_failure("Could not find trade with ID: #{trade_id(update_params)}", :not_found)
      # rubocop:disable Style/RedundantReturn
      return
      # rubocop:enable Style/RedundantReturn
    end
  end

  def destroy
    # TODO: change to before_action filter
    unless params.dig('id').present?
      render_failure('You must pass a trade ID in order to delete a trade', :bad_request)
      return
    end

    id = params.fetch('id')

    # TODO: change to before_action filter
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
    # TODO: ensure ID is included in params
    # TODO: get the ID from the route instead
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
