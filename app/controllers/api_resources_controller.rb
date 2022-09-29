class ApiResourcesController < ApplicationController
  def index
    resources = LearningUnit
                .find(params[:learning_unit_id])
                .resources
    render json: resources, only: %i[,
       name description]
  end

  def show
    resource = Resource
               .find(params[:resource_id])

    render json: resource, only: %i[name description]
  end

  def create
    learning_unit = LearningUnit.find(params[:learning_unit_id])
    resource = Resource.create!(
      name: params[:name],
      url: params[:url],
      description: params[:description],
      learning_unit:,
      user: current_user
    )
    render json: resource, only: %i[name url description], status: :created
  end


  def index_comments
    comments = Resource
               .find(params[:resource_id])
               .resource_comments.includes(:user)

    resource_comments = []
    comments.each do |comment| 
      json_hash = {
        ,
        : comment.,
        , 
        content: comment.content,
        user_name: comment.user.name,
        created_at: comment.created_at
      }
      resource_comments << json_hash  
    end 
    render json: resource_comments
  end
end

  def create_comments
    comment = ResourceComment.create!(
      content: params[:content],
      user_id: current_user,
      resource_id: params[resource_id]
    )
    
    render json: comment, only: %i[content user_id resource_id], status: :created
  end
end
