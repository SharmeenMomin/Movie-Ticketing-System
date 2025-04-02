class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  #before_action :authenticate_admin!, except: [:index, :new, :create, :show]
  helper_method :current_user, :logged_in?
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :current_user

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    else
      @current_user = nil
    end
  end

  def authenticate_user!
    unless current_user
      redirect_to login_path, alert: "You need to sign in first."
    end
  end

  def logged_in?
    !!current_user
  end

  def after_sign_in_path_for(resource)
    if resource.is_a?(Admin)
      authenticated_admin_root_path  # Redirects admin after login
    else
      root_path  # Redirects users to landing page
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :name, :phone_number, :address, :credit_card, :email, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :password_confirmation, :current_password])
  end

end