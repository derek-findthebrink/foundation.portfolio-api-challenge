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
  end

  describe 'DELETE /portfolio/trades/:id' do
    let(:symbol) { 'my_symbol' }
    let(:stock) { create(:stock, symbol: symbol) }
    let!(:trade) { portfolio.trades.create!(stock: stock, quantity: 100, price: 10, trade_type: :buy) }

    before do
      delete "/portfolio/trades/#{trade.id}", headers: headers
    end

    it 'deletes the trade' do
      expect(portfolio.trades.find_by_id(trade.id)).to be_nil
    end
  end
end
