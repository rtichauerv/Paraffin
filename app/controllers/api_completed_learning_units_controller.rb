class ApiCompletedLearningUnitsController < ApiApplicationController
  before_action :set_learning_unit, only: %i[update uncomplete_learning_unit]

  def curriculums_learning_units_completed_by_user
    learning_units = Curriculum.find(params[:curriculum_id])&.learning_units
    completed_learning_units = CompletedLearningUnit.where(
      user: current_user,
      learning_units:
    )
    render json: completed_learning_units, only: %i[id learning_unit_id]
  end

  def uncomplete_learning_unit
    if CompletedLearningUnit.delete_by(
      user: current_user,
      learning_unit: @learning_unit
    ).positive?
      render_deletion_message
    else
      handle_record_invalid_error
    end
  end

  def update
    completition_register = CompletedLearningUnit.find_or_initialize_by(
      user: current_user,
      learning_unit: @learning_unit
    )
    unless completition_register.id?
      completition_register.save
      status = :created
    end

    render json: completition_register, only: %i[id learning_unit_id user_id],
           status:
  end

  private

  def set_learning_unit
    @learning_unit = LearningUnit.find(params[:learning_unit_id])
  end
end
