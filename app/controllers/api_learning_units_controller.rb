class ApiLearningUnitsController < ApiApplicationController
  def learning_units_of_curriculum
    learning_units = Curriculum.find(params[:curriculum_id])&.learning_units
    render json: learning_units, only: %i[id name]
  end
end
