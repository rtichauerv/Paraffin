class ApiResourceEvaluationsController < ApiApplicationController
  def update
    evaluation = params['evaluation']
    resource_id = params['resource_id']
    resource_evaluation = ResourceEvaluation
                          .find_or_initialize_by(user_id: current_user.id,
                                                 resource_id:)
    resource_evaluation.evaluation = evaluation
    resource_evaluation.save if resource_evaluation.has_changes_to_save?
    render json: resource_evaluation
  end
end
