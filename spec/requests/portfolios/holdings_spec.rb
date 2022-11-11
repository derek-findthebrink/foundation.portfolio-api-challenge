require 'rails_helper'

RSpec.describe 'Portfolios::Holdings', type: :request do
  let(:headers) { { ACCEPT: 'application/json' } }

  describe 'GET /index' do
    it 'returns http success' do
      get '/portfolio/holdings', headers: headers
      expect(response).to have_http_status(:success)
    end
  end
end
