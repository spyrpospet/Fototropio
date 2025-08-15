class ApplicationController < ActionController::Base
  include Pagy::Backend

  layout :layout_by_resource

  around_action :switch_locale

  private

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  def default_url_options(options = {})
    { locale: (I18n.locale == I18n.default_locale ? nil : I18n.locale)  }
  end

  def layout_by_resource
    "admins/login"  if devise_controller? && resource_name == :admin && action_name == "new"
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
