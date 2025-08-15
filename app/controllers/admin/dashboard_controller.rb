class Admin::DashboardController < Admin::CommonController
  def index
    @weekly_orders = Order.complete_state
                          .where(created_at: 1.week.ago.beginning_of_day..Time.now.end_of_day)
                          .group_by_day(:created_at).sum(:total)

    @monthly_orders = Order.complete_state
                           .where(created_at: 1.month.ago.beginning_of_day..Time.now.end_of_day)
                           .group_by_day(:created_at).sum(:total)

    @daily_orders = Order.complete_state.where(created_at: Time.now.beginning_of_day..Time.now.end_of_day)
                         .group_by_day(:created_at).sum(:total)
  end
end
