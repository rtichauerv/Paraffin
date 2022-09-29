class ApiResourceEvaluationsController < ApiApplicationController
  def show
    resource = Resource.find(params[:resource_id])
    evaluation = resource.resource_evaluations.find_by(user: current_user)
    if evaluation.nil?
      handle_record_not_found_error
    else
      render json: evaluation, except: %i[created_at updated_at]
    end
  end

  def update
    evaluation = params.require(:evaluation)
    resource_id = params['resource_id']
    Resource.find(resource_id)
    resource_evaluation = ResourceEvaluation
                          .find_or_initialize_by(user_id: current_user.id,
                                                 resource_id:)
    resource_evaluation.evaluation = evaluation
    resource_evaluation.save!
    render json: resource_evaluation, except: %i[created_at updated_at]
  end
end
