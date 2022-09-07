class LearningUnitsController < ApplicationController
  before_action :set_curriculum, only: [:index]
  before_action :set_learning_unit, only: [:show]

  def index; end

  def show
    redirect_to learning_unit_resources_path(@learning_unit)
  end

  private

  def set_curriculum
    @curriculum = Curriculum.find(params[:curriculum_id])
  end

  def set_learning_unit
    @learning_unit = LearningUnit.find(params[:id])
  end
end
