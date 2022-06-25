class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: %i[top about]
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def not_found
    raise ActionController::RoutingError.new("Not Found")
  end

  private

  def after_sign_in_path_for(resource)
    user_path(current_user)
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end
