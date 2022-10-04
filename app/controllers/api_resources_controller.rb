class ApiResourcesController < ApplicationController
  def index
    resources = LearningUnit
                .find(params[:learning_unit_id])
                .resources
    render json: resources, only: %i[id name url description]
  end

  def show
    resource = Resource
               .find(params[:resource_id])

    render json: resource, only: %i[id name url description]
  end

  def index_comments
    comments = Curriculum
               .find(params[:curriculum_id])
               .learning_units
               .find(params[:learning_unit_id])
               .resources
               .find(params[:resource_id])
               .resource_comments
    render json: comments, only: %i[id content]
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
    render json: resource, only: %i[id name url description], status: :created
  end

  def create_comments
    comment = ResourceComment.create!(
      content: params[:content],
      user_id: current_user,
      resource_id: params[resource_id]
    )

    render json: comment, only: %i[content user_id resource_id],
           status: :created
  end
end
