require 'rails_helper'

RSpec.describe 'Portfolios::Trades', type: :request do
  let!(:portfolio) { Portfolio.create! }
  let(:headers) { { ACCEPT: 'application/json' } }

  describe 'POST /portfolio/trades' do
    let(:params) do
      {
        trade: {
          symbol: 'thnc',
          trade_type: 'buy',
          quantity: 100,
          price: 2.50
        }
      }
    end

    before do
      post '/portfolio/trades', headers: headers, params: params
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    # NOTE: additional tests
    # - when the stock doesn't exist yet, it should be created
    # - when the stock exists, a new stock should not be created
  end

  describe 'PUT /portfolio/trades/:id' do
    let(:new_symbol) { 'noodle' }
    let(:stock) { Stock.create!(symbol: 'thnc') }
    let(:original_trade_attributes) do
      {
        stock: stock,
        trade_type: 'buy',
        quantity: 100,
        price: 2.50,
        time: Time.current
      }
    end
    let(:params) do
      {
        trade: {
          id: trade.id,
          symbol: new_symbol
        }
      }
    end
    let!(:trade) { portfolio.trades.create!(original_trade_attributes) }

    before do
      put "/portfolio/trades/#{trade.id}", headers: headers, params: params
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'modifies the trade as expected' do
      expect(trade.reload.stock.symbol).to eq(new_symbol)
    end

    context 'when ID is not passed' do
      let(:params) do
        {
          trade: {
            symbol: new_symbol
          }
        }
      end

      it 'returns http bad_content' do
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
