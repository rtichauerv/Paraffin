class ApiUserController < ApiApplicationController
  def user_info
    user = current_user
    render json: user
  end
end
