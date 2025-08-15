class OrderMailer < ApplicationMailer
  before_action :set_order

  def notify_client
    mail(to: @order.data["email"], subject: t("client_made_an_order", code: @order.code), from: @settings.email)
  end

  def notify_admin
    mail(to: @settings.email, subject: t("new_order_for_admin", code: @order.code), from: @settings.email)
  end

  private

  def set_order
    @order = params[:order]
  end
end
