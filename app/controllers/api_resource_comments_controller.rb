class ApiResourceCommentsController < ApiApplicationController
  def show
    resource_id = params['resource_id']
    comments = Resource.find(resource_id)&.resource_comments
    render json: comments, only: %i[id content resource_id user_id]
  end
end
