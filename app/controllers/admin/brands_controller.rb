class Admin::BrandsController < Admin::CommonController
  before_action :set_brand, only: [:edit, :update, :destroy]

  def index
    @brands = Brand.all
  end

  def new
    @brand  = Brand.new

    @brands = Brand.published
  end

  def create
    @brand = Brand.new(brand_params)

    respond_to do |format|
      if @brand.save
        format.html { redirect_to admin_brands_path, notice: t("save_successful") }
      else
        format.turbo_stream { render partial: "admin/errors", locals: { object: @brand }}
      end
    end
  end

  def edit
    @brands = Brand.published
  end

  def update
    respond_to do |format|
      if @brand.update(brand_params)
        format.html { redirect_to admin_brands_path, notice: t("save_successful") }
      else
        format.turbo_stream { render partial: "admin/errors", locals: { object: @brand }}
      end
    end
  end

  def destroy
    @brand.destroy
    redirect_to admin_brands_path, notice: t("delete_successful")
  end

  private

  def set_brand
    @brand = Brand.find(params[:id])
  end

  def brand_params
    params.fetch(:brand, {}).permit(:id, :image, :sort_order, :parent_id, :status, :is_collection, Brand.globalize_attribute_names)
  end
end
