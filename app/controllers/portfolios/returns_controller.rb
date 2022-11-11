# displays current returns
class Portfolios::ReturnsController < ApplicationController
  let(:returns_result) { ReturnsReport.new(portfolio).result }

  def index; end
end
