class ApplicationMailer < ActionMailer::Base
  before_action :set_default_settings

  layout 'mailer'

  protected

  def set_default_settings
    @settings = Setting.first
  end
end
