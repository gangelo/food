# frozen_string_literal: true

# The application controller for this application.
class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user|
      user.permit(:first_name, :last_name, :username, :email, :password, :password_confirmation)
    end
  end

  # def after_sign_in_path_for(resource)
  #   <some>_path
  # end
end
