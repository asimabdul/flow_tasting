class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  
  include ApplicationHelper
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    admin_wines_url
  end

  def check_admin_status
    if current_user.admin?
      return
    else
      flash[:error] = "The section you requested is for admins only."
      redirect_to root_url and return
    end
  end

  def require_guest
    if current_guest.nil?
      if !flash[:success].present?
        flash[:error] = "Please login with your email and event key to proceed. We sent you an email containing this information."  
      end
      redirect_to new_events_session_url 
    end
  end

  protected
  def configure_permitted_parameters
    # devise_parameter_sanitizer.for(:sign_up) << :name
    [:first_name, :last_name, :remember_created_at, :admin].each {|attribute| devise_parameter_sanitizer.for(:sign_up) << attribute}
  end
end
