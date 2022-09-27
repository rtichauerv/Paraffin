class ApiResourceCommentsController < ApiApplicationController
  def show
    resource_id = params['resource_id']
    comments = Resource.find(resource_id)&.resource_comments
    render json: comments, only: %i[id content resource_id user_id]
  end

  def create
    content = params['content']
    resource = Resource.find(params['resource_id'])
    comment = ResourceComment.create!(
      content:,
      user: current_user,
      resource_id: resource.id
    )
    render json: comment, only: %i[id content resource_id], status: :created
  end
end
