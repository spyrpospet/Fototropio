class Admin::SlidersController < Admin::CommonController
  before_action :set_slider, only: [:edit, :update, :destroy]

  def index
    @sliders = Slider.all
  end

  def new
    @slider  = Slider.new
  end

  def create
    @slider = Slider.new(slider_params)

    respond_to do |format|
      if @slider.save
        format.html { redirect_to admin_sliders_path, notice: t("save_successful") }
      else
        format.turbo_stream { render partial: "admin/errors", locals: { object: @slider }}
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @slider.update(slider_params)
        format.html { redirect_to admin_sliders_path, notice: t("save_successful") }
      else
        format.turbo_stream { render partial: "admin/errors", locals: { object: @slider }}
      end
    end
  end

  def destroy
    @slider.destroy
    redirect_to admin_sliders_path, notice: t("delete_successful")
  end

  private

  def set_slider
    @slider = Slider.find(params[:id])
  end

  def slider_params
    params.fetch(:slider, {}).permit(:id, :image, :url, :alt_title, :status, :sort_order)
  end
end
