require 'rails_helper'

RSpec.describe 'Portfolios::Returns', type: :request do
  let(:headers) { { 'ACCEPT': 'application/json' } }

  before do
    Portfolio.create!
  end

  describe 'GET /portfolio/returns' do
    it 'returns http success' do
      get '/portfolio/returns', headers: headers
      expect(response).to have_http_status(:success)
    end
  end
end
