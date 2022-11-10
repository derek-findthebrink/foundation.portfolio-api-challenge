# Base controller
class ApplicationController < ActionController::API
  extend Lettable

  let(:portfolio) { Portfolio.first }
end
