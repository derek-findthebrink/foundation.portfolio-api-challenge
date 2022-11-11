# Base controller
class ApplicationController < ActionController::API
  # NOTE: this is a technique I really like! Take a look at the file
  # /app/controllers/concerns/lettable.rb for more info
  extend Lettable

  let(:portfolio) { Portfolio.first }

  def render_failure(message, status_code = :bad_request)
    render json: {
      success: false,
      error: message
    }, status: status_code
  end
end
