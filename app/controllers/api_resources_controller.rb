class ApiResourcesController < ApiApplicationController
  def show
    resource = Resource.find(params[:resource_id])
    render json: resource, only: %i[id name url], methods: [:average_evaluation]
  end

  def resources_of_learning_unit
    resources = LearningUnit.find(params[:learning_unit_id])&.resources
    render json: resources, only: %i[id name url],
           methods: [:average_evaluation]
  end

  def create
    learning_unit = LearningUnit.find(params[:learning_unit_id])
    resource = Resource.create!(
      name: params[:name],
      url: params[:url],
      learning_unit:,
      user: current_user
    )
    render json: resource, only: %i[id name url], status: :created
  end
end
