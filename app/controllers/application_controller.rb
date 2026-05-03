class ApplicationController < ActionController::API
  include SetCurrentTenant
  include AuthorizeRequest

  rescue_from StandardError, with: :handle_internal_error
  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  private

  def handle_internal_error(error)
    Rails.logger.error(error.message)
    Rails.logger.error(error.backtrace.join("\n"))

    render json: { error: "Internal server error" }, status: :internal_server_error
  end

  def handle_not_found(error)
    render json: { error: error.message }, status: :not_found
  end
end
