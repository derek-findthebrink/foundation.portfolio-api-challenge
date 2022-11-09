require 'rails_helper'

RSpec.describe 'Portfolios::Returns', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/portfolio/returns'
      expect(response).to have_http_status(:success)
    end
  end
end
