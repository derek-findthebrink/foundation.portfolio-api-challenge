class Portfolios::TradesController < ApplicationController
  # IDEA: add unpermitted params error messaging
  let(:create_result) do
    Portfolios::CreateTradeForm
      .new(portfolio, create_params.to_h)
      .result
  end

  let(:update_result) do
    Portfolios::UpdateTradeForm
      .new(portfolio, update_params.to_h.merge(id: trade_id))
      .result
  end

  def create; end

  def update
    if trade_present?
      render
    else
      render_failure("Could not find trade with ID: #{trade_id}", :not_found)
    end
  end

  def destroy
    portfolio.trades.destroy(trade_id)
    render json: { success: true, data: { trade: { id: id } } }
  rescue ActiveRecord::RecordNotFound
    render_failure("Could not find trade with ID: #{id}")
  end

  private

  def create_params
    params.require(:trade).permit(:trade_type, :quantity, :symbol, :price)
  end

  def update_params
    # IDEA: ID can and probs should be pulled from the path only
    params.require(:trade)
          .permit(:time, :trade_type, :quantity, :symbol,
                  :price)
  end

  def trade_id
    params[:id]
  end

  def trade_present?
    portfolio.trades.find_by_id(trade_id)
  end
end
