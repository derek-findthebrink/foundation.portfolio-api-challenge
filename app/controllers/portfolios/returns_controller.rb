# displays current returns
class Portfolios::ReturnsController < ApplicationController
  def index
    render body: 'returns index'
  end
end
