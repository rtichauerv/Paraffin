class ApiCompletedLearningUnitsController < ApiApplicationController
  before_action :set_learning_unit, only: [:update]

  def curriculums_learning_units_completed_by_user
    learning_units = Curriculum.find(params[:curriculum_id])&.learning_units
    completed_learning_units = CompletedLearningUnit.where(
      user: current_user,
      learning_units:
    )
    render json: completed_learning_units, only: %i[id learning_unit_id]
  end

  def update
    completition_register = CompletedLearningUnit.find {|record|
      record.learning_unit_id == @learning_unit.id &&
      record.user_id == current_user.id
    }
    if completition_register.nil?
      completition_register = CompletedLearningUnit.create(
        learning_unit: @learning_unit,
        user: current_user)
      status = :created
    else
      status = :ok
    end
    render json: completition_register,
          only: %i[id learning_unit_id user_id],
          status:
  end

  private

  def set_learning_unit
    @learning_unit = LearningUnit.find(params[:learning_unit_id])
  end
end

