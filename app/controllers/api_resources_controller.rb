class ApiResourcesController < ApplicationController
  def index
    resources = Curriculum.find(params[:curriculum_id]).learning_units.find(params[:learning_unit_id]).resources
    render json: resources, only: %i[id name description]
  end

  def show
    resource = Curriculum.find(params[:curriculum_id]).learning_units.find(params[:learning_unit_id]).resources.find(params[:resource_id])
    # Para tener un path mas lindo 
    # learning_unit = Curriculum.find(params[:curriculum_id]).
    # learning_units[(params[:learning_unit_id]).to_i]
    render json: resource, only: %i[id name description]
  end
end
