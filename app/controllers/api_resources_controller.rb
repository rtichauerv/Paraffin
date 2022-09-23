class ApiResourcesController < ApiApplicationController
  def show
    resource = Resource.find(params[:resource_id])
    render json: {
      'resource': resource.attributes.slice('id', 'name', 'url'),
      'average_evaluation': resource.average_evaluation.to_f
    }
  end
end
