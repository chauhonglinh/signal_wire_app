class ApplicationController < ActionController::API
  def process_api_request(error_message)
    yield
  rescue UnprocessableEntityException => uee
    render json: { error: uee.message }, status: :unprocessable_entity
  rescue StandardError => exc
    Rails.logger.error("Error: #{exc.message}\n#{exc.backtrace.join("\n")}")
    render json: { error: error_message }, status: :internal_server_error
  end
end
