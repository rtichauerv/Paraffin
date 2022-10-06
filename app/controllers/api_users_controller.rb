class ApiUsersController < ApiApplicationController
  def user_info
    user = current_user
    render json: user, only: %i[id name email]
  end
end
