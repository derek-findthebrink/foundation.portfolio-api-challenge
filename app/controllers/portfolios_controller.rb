# Displays portfolio data
class PortfoliosController < ApplicationController
  Result = Struct.new(:success, :data) do
    def success?
      success
    end
  end

  # TODO: make success actually reflect success?
  let(:result) { Result.new(true, portfolio) }

  def index; end
end
