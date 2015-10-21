class Api::StudentsController < ApiController

  before_action only: [:show, :update] do
    @student = Student.find(params[:id])
  end

  def show
    respond_with @student, location: nil, except: [:password]
  end

  def update
    @student.update(student_params)
    respond_with @student, location: nil, except: [:password]
  end

  def authenticate
    @student = Student.find_by! params.permit(:login, :password)
    render json: {id: @student.id}.to_json
  end

  private

  def student_params
    params.require(:student).permit(:password)
  end

end
