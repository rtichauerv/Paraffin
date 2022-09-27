class ApiResourcesController < ApiApplicationController
  def show
    resource = Resource.find(params[:resource_id])
    render json: resource, only: %i[id name url], methods: [:average_evaluation]
  end
end
