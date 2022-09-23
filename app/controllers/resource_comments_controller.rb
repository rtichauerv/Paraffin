class ResourceCommentsController < ApplicationController
  def index
    resource_id = params['resource_id']
    comments = ResourceComment.where(resource_id:)
    render json: comments, only: %i[id content resource_id user_id]
  end

  def create
    content = params['resource_comments']['content']
    resource_id = params['resource_id']
    ResourceComment.create!(
      content:,
      user: current_user,
      resource_id:
    )
    redirect_to(Resource.find(resource_id))
  end
end
