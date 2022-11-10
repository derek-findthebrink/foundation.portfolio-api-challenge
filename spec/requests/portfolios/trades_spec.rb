require 'rails_helper'

RSpec.describe 'Portfolios::Trades', type: :request do
  before do
    Portfolio.create!
  end

  describe 'POST /portfolio/trades' do
    let(:headers) { { ACCEPT: 'application/json' } }
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
end
