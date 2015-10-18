class Student::SessionsController < ApplicationController

  before_action :already_signed_in, only: [:new, :create], if: proc { signed_in? }

  def new
    render :new, layout: nil
  end

  def create
    student = authenticate_student(session_params[:login].try!(:downcase), session_params[:password])
    if student
      sign_in_student(student)
      flash[:info] = 'Sign in successful'
      redirect_to root_url
    else
      flash.now[:error] = 'Sign in failed!'
      render :new, layout: nil
    end
  end

  def destroy
    sign_out_student
    redirect_to student_sign_in_path
  end

  def current_student
    @current_student ||= find_student(session[:student_id]) if session[:student_id]
  end

  def signed_in?
    !current_student.nil?
  end

  def already_signed_in
    flash[:notice] = 'Already signed in'
    redirect_to root_url
  end


  private
  
  def session_params
    params.require(:session).permit(:login, :password)
  end

  def sign_in_student(student)
    session[:student_id] = student['id']
  end

  def sign_out_student
    session.delete(:student_id)
    @current_student = nil
  end

  def find_student(id)
    begin
      Remote::Student.find(id)
    rescue ActiveResource::ResourceNotFound
      nil
    end
  end

  def authenticate_student(login, password)
    Remote::Student.get(:authenticate, login: login, password: password)
  end



end
