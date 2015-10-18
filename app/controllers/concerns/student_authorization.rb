module StudentAuthorization
  extend ActiveSupport::Concern

  included do
    prepend_before_action :authorize_student!

    helper_method :current_student, :signed_in?
  end

  def authorize_student!
    redirect_to student_sign_in_path unless signed_in?
  end

  def current_student
    @current_student ||= find_student(session[:student_id]) if session[:student_id]
  end

  def signed_in?
    !current_student.nil?
  end

  private

  def find_student(id)
    begin
      Remote::Student.find(id)
    rescue ActiveResource::ResourceNotFound
      nil
    end
  end

end