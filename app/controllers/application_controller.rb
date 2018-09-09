class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
#redirect after login
  def after_sign_in_path_for(resource)
  	home_path(current_user)
  end

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
  	devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :password, :password_confirmation, :remember_me] )
  	devise_parameter_sanitizer.permit(:sign_in, keys: [:username, :email, :password, :password_confirmation, :remember_me] )
  	devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email, :password, :password_confirmation, :remember_me] )
  end

end
