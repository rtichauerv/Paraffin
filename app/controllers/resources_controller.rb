class ResourcesController < ApplicationController
  def show
    resource = Resource.find(params[:id])
    @service = Resources::ResourceService.new(resource)
    @evaluation = ResourceEvaluation
                  .find_by(user: current_user, resource:)
  end

  def index
    @learning_unit = LearningUnit.find(params[:learning_unit_id])
  end
end
