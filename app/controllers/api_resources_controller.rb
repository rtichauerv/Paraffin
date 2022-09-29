class ApiResourcesController < ApplicationController
  def index
    resources = Curriculum
                .find(params[:curriculum_id])
                .learning_units
                .find(params[:learning_unit_id])
                .resources
    render json: resources, only: %i[id name description]
  end

  def show
    resource = Curriculum
               .find(params[:curriculum_id])
               .learning_units
               .find(params[:learning_unit_id])
               .resources
               .find(params[:resource_id])

    render json: resource, only: %i[id name description]
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
end
