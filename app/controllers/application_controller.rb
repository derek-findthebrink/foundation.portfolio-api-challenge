# Base controller
class ApplicationController < ActionController::API
  extend Lettable

  let(:portfolio) { Portfolio.first }

  def render_failure(message, status_code = :bad_request)
    render json: {
      success: false,
      error: message
    }, status: status_code
  end
end
