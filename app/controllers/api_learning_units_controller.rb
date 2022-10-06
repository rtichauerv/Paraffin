class ApiLearningUnitsController < ApiApplicationController
  def show
    learning_unit = LearningUnit.find(params[:learning_unit_id])
    render json: learning_unit, only: %i[id name]
  end

  def learning_units_of_curriculum
    learning_units = Curriculum.find(params[:curriculum_id])&.learning_units
    render json: learning_units, only: %i[id name]
  end
end
