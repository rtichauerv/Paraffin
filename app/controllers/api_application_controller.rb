class ApiApplicationController < ActionController::API
  before_action :authenticate_user!

  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found_error
  rescue_from ActiveRecord::RecordInvalid, with: :handle_record_invalid_error
  rescue_from ActionController::ParameterMissing,
              with: :handle_record_invalid_error

  private

  def handle_record_not_found_error
    code = 404
    message = 'record_not_found'
    status = :not_found

    render_error(code, message, status)
  end

  def handle_record_invalid_error
    code = 400
    status = :bad_request
    message = 'invalid_record'

    render_error(code, message, status)
  end

  def render_error(code, message, status)
    render json: { code:, message:, status: }, status:
  end
end
