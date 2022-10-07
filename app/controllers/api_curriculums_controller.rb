class ApiCurriculumsController < ApiApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  def index
    curriculums = Curriculum.all
    render json: curriculums, only: %i[id name description]
  end

  def show
    curriculum = Curriculum.find(params[:curriculum_id])
    render json: curriculum, only: %i[id name description]
  end
end
