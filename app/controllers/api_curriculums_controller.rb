class ApiCurriculumsController < ApiApplicationController
  def index
    curriculums = Curriculum.all()
    render json: curriculums, only: %i[id name]
  end
end
