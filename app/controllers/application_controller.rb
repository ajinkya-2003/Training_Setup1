# app/controllers/application_controller.rb

class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Add this line to configure Devise strong parameters
  before_action :configure_permitted_parameters, if: :devise_controller?
  layout :set_layout

  protected

  def configure_permitted_parameters
    # For sign up (registration)
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :age, :date_of_birth, :phone])
    # For account updates (if you have an edit profile page)
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :age, :date_of_birth, :phone])
  end

  def set_layout
    devise_controller? ? 'devise' : 'application'
  end
end
