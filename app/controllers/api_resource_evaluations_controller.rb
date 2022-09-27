class ApiResourceEvaluationsController < ApiApplicationController
  def update
    evaluation = params['evaluation']
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
