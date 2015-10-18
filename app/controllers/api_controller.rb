class ApiController < ApplicationController

  protect_from_forgery with: :null_session
  respond_to :json

  rescue_from StandardError, with: :render_500
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  protected

  def render_404(e)
    notify_error(e)
    render :json => {:error => "not-found"}.to_json, :status => 404
  end

  def render_500(e)
    notify_error(e)
    render :json => {:error => "internal-server-error"}.to_json, :status => 500
  end

  def notify_error(e)
    logger.error { "<#{e.class}> #{e.message}" }
    logger.error { e.backtrace.join("\n") }
    #todo: send mail
  end

end
