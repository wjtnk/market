class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # deviseで追加でUserテーブルに入れたいカラム
  def configure_permitted_parameters
    added_attrs = [:name, :address]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
  end

end
