class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :devise_controller?

  before_action :set_locale
  helper_method :resource

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:email, :password, :password_confirmation)
    end
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:email, :password, :password_confirmation)
    end
  end

  def authenticate_admin!
    unless current_user
      redirect_to root_path and return
    end
    redirect_to new_user_session_path unless current_user.is_admin?
  end

private
def set_locale
  I18n.locale = extract_locale || I18n.default_locale
end
def extract_locale
  parsed_locale = params[:locale]
  I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
end

private
def default_url_options
  { locale: I18n.locale }
end
end
