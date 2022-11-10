require 'rails_helper'

RSpec.describe 'Portfolios', type: :request do
  before do
    Portfolio.new.save!
  end

  describe 'GET /index' do
    let(:headers) { { ACCEPT: 'application/json' } }

    before do
      get '/portfolio', headers: headers
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end
end
