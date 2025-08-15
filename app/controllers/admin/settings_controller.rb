class Admin::SettingsController < Admin::CommonController
  before_action :set_setting, only: [:edit, :update, :destroy]

  def edit; end

  def update
    respond_to do |format|
      if @setting.update(setting_params)
        format.html { redirect_to request.referrer, notice: t("save_successful") }
      else
        format.turbo_stream { render partial: "admin/errors", locals: { object: @setting }}
      end
    end
  end

  def destroy
    @setting.destroy
    redirect_to admin_settings_path, notice: t("delete_successful")
  end

  private

  def set_setting
    @setting = Setting.find(params[:id])
  end

  def setting_params
    params.fetch(:setting, {}).permit(
      :id,
      :logo,
      :website,
      :email,
      :phone,
      :address,
      :bank_url,
      :merchant_id,
      :bank_secret_key,
      :facebook,
      :instagram,
      :youtube,
      :bank_deposit_instruction
    )
  end
end
