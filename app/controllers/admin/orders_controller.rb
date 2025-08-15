class Admin::OrdersController < Admin::CommonController
  def index
    @orders = Order.complete_state.order(created_at: :desc)
  end

  def view
    @order = Order.complete_state.find_by(code: params[:code])
  end

  def destroy
    @order = Order.complete_state.find_by(code: params[:code])

    if @order&.destroy
      redirect_to admin_orders_path, notice: t("successfully_deleted")
    else
      redirect_to admin_orders_path, status: :unprocessable_entity, alert: t("deletion_failed")
    end
  end
end