class ApiCompletedLearningUnitsController < ApiApplicationController
  def curriculums_learning_units_completed_by_user
    learning_units = Curriculum.find(params[:curriculum_id])&.learning_units
    completed_learning_units = CompletedLearningUnit.where(
      user: current_user,
      learning_units:
    )
    render json: completed_learning_units, only: %i[id learning_unit_id]
  end
end
