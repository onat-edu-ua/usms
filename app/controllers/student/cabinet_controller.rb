class Student::CabinetController < ApplicationController
  include StudentAuthorization

  helper_method :admin_assigns

  def admin_assigns
    @admin_assigns ||= {}
  end

  layout 'admin_lte_2'

  def show
    admin_assigns.merge! page_name: 'Dashboard',
        page_description: 'General information'
  end

  def edit
    admin_assigns.merge! page_name: 'Change Password',
                          breadcrumbs: [
                              {name: 'Dashboard', link: student_cabinet_url, icon: 'dashboard'}
                          ]
  end

  def update
    unless student_params[:password].present? && student_params[:password] == student_params[:password_retype]
      flash.now[:alert] = 'Password mismatch!'
      render :edit
    else

      current_student.password = student_params[:password]
      if current_student.save
        flash[:notice] = 'password was updated successfully'
        redirect_to action: :show
      else
        flash.now[:alert] = current_student.errors.full_messages.to_sentence
        # flash.now[:alert] = 'Validation failed!'
        render :edit
      end

    end
  end

  private

  def student_params
    params.require(:student).permit(:password, :password_retype)
  end

end
