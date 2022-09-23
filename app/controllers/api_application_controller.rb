class ApiApplicationController < ActionController::API
  before_action :authenticate_user!

  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found_error

  private

  def handle_record_not_found_error
    code = 404
    message = 'record_not_found'
    status = :not_found

    render json: { code:, message:, status: }, status:
  end
end
