class ApiResourceCommentsController < ApiApplicationController
  def show
    resource_id = params['resource_id']
    resource = Resource.find(resource_id)
    comments = resource.resource_comments
    render json: comments, only: %i[id content resource_id user_id]
  end
end
