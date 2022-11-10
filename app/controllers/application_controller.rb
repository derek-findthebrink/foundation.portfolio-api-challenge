# Base controller
class ApplicationController < ActionController::API
  extend Lettable

  let(:portfolio) { Portfolio.first }

  def render_failure(message, status_code = :bad_request)
    render body: {
      success: false,
      error: message
    }, status: status_code
  end
end
