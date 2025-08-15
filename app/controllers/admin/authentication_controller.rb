class Admin::AuthenticationController < ApplicationController
  def login
    render layout: false
  end

  def authenticate
    @admin = Admin.find_by(email: admin_params[:email])

    respond_to do |format|
      if @admin.present? && @admin.valid_password?(admin_params[:password])
        sign_in(@admin)
        format.turbo_stream { redirect_to admin_root_url }
      else
        format.turbo_stream { render partial: "admin/authentication/error" }
      end
    end
  end

  def logout
    sign_out(current_admin)
    redirect_to root_url
  end

  private

  def admin_params
    params.fetch(:admin, {}).permit(:email, :password)
  end
end
