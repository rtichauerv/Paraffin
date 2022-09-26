class ApiResourceCommentsController < ApiApplicationController
  def show
    resource_id = params['resource_id']
    comments = Resource.find(resource_id)&.resource_comments
    render json: comments, only: %i[id content resource_id user_id]
  end
  
  def create
    content = params['content']
    resource_id = params['resource_id']
    newComment = ResourceComment.new(
      content:,
      user: current_user,
      resource_id:
    )
    newComment.save
    render json: {
      'commentId': newComment.id,
      'content': newComment.content,
      'resourceId': newComment.resource.id
    }
  end
end
