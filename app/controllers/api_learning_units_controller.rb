class ApiLearningUnitsController < ApiApplicationController
  def index
    learning_units = LearningUnit.all()
    render json: learning_units, only: %i[id name]
  end
end
