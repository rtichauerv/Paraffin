class ApiSessionController < ApiApplicationController
  def index
    user = current_user
    render json: user, only: %i[id name email]
  end
end
