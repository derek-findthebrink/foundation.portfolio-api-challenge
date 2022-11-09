require 'rails_helper'

RSpec.describe 'Portfolios::Holdings', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/portfolio/holdings'
      expect(response).to have_http_status(:success)
    end
  end
end
