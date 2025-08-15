class Admin::AvailabilitiesController < Admin::CommonController
  before_action :set_availability, only: %i[edit update destroy]

  def index
    @availabilities = Availability.all
  end

  def new
    @availability  = Availability.new
  end

  def create
    @availability = Availability.new(availability_params)

    respond_to do |format|
      if @availability.save
        format.html { redirect_to admin_availabilities_path, notice: t("save_successful") }
      else
        format.turbo_stream { render partial: "admin/errors", locals: { object: @availability }}
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @availability.update(availability_params)
        format.html { redirect_to admin_availabilities_path, notice: t("save_successful") }
      else
        format.turbo_stream { render partial: "admin/errors", locals: { object: @availability }}
      end
    end
  end

  def destroy
    @availability.destroy
    redirect_to admin_availabilities_path, notice: t("delete_successful")
  end

  private

  def set_availability
    @availability = Availability.find(params[:id])
  end

  def availability_params
    params.fetch(:availability, {}).permit(:id, :sort_order, :can_buy, Availability.globalize_attribute_names)
  end
end
