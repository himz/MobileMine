class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :banned?, :prepare_for_mobile

  def banned?
    if current_user.present? && !current_user.activated?
      sign_out current_user
      flash[:error] = "This account has been suspended...."
      redirect_to new_user_session_path
    end
  end



  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      request.user_agent =~ /Mobile|webOS/
    end
  end
  helper_method :mobile_device?

  def prepare_for_mobile
    session[:mobile_param] = params[:mobile] if params[:mobile]
    request.format = :mobile if mobile_device?
  end
end
