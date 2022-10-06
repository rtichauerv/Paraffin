class ApiUserController < ApiApplicationController
  def get_user
    user = current_user
    render json: user
  end
end
