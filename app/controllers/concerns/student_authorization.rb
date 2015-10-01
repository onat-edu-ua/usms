module StudentAuthorization
  extend ActiveSupport::Concern

  included do
    prepend_before_action :authorize_student!

    helper_method :current_student, :signed_in?
  end

  def authorize_student!
    logger.error session[:student_id]
    redirect_to student_sign_in_path unless signed_in?
  end

  def current_student
    @current_student ||= Student.find_by(id: session[:student_id])
  end

  def signed_in?
    !current_student.nil?
  end

end