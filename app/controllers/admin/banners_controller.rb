class Admin::BannersController < Admin::CommonController
  before_action :set_banner, only: [:edit, :update, :destroy]

  def index
    @banners = Banner.all
  end

  def new
    @banner  = Banner.new
  end

  def create
    @banner = Banner.new(banner_params)

    respond_to do |format|
      if @banner.save
        format.html { redirect_to admin_banners_path, notice: t("save_successful") }
      else
        format.turbo_stream { render partial: "admin/errors", locals: { object: @banner }}
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @banner.update(banner_params)
        format.html { redirect_to admin_banners_path, notice: t("save_successful") }
      else
        format.turbo_stream { render partial: "admin/errors", locals: { object: @banner }}
      end
    end
  end

  def destroy
    @banner.destroy
    redirect_to admin_banners_path, notice: t("delete_successful")
  end

  private

  def set_banner
    @banner = Banner.find(params[:id])
  end

  def banner_params
    params.fetch(:banner, {}).permit(:id, :image, :url, :status, :position, :sort_order, Banner.globalize_attribute_names)
  end
end
