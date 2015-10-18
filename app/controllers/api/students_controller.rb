class Api::StudentsController < ApiController

  before_action only: [:show, :update] do
    @student = Student.find(params[:id])
  end

  def show
    respond_with @student, location: nil, except: [:password]
  end

  def update
    @student.update(student_update_params)
    respond_with @student, location: nil, except: [:password]
  end

  def authenticate
    @student = Student.find_by(student_auth_params)
    respond_with @student, location: nil, except: [:password]
  end

  private

  def student_update_params
    params.require(:student).permit(:password)
  end

  def student_auth_params
    params.permit(:login, :password)
  end

end
