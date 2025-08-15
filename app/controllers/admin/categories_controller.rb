require 'csv'

class Admin::CategoriesController < Admin::CommonController
  before_action :set_category, only: [:edit, :update, :destroy, :export_products]

  def index
    @pagy, @categories = pagy(Category.common.all, limit: 20)

    if params[:search].present?
      filters = []
      query   = search_params["title"] || "*"
      sorts   = ["sort_order:asc"]

      filters << "status=#{search_params["status"]}" if search_params["status"].present?

      @categories = Category.pagy_search(query, {
        attributesToSearchOn: ["title_#{I18n.locale}"],
        filter: filters,
        matchingStrategy: "all",
        hitsPerPage: 20,
        sort: sorts
      })

      @pagy, @categories = pagy_meilisearch(@categories, limit: 20)

      render partial: "admin/categories/list"
    end
  end

  def new
    @category   = Category.new
    @categories = Category.all
    @brands     = Brand.published
  end

  def create
    @category = Category.new(category_params)

    respond_to do |format|
     if @category.save
        format.html { redirect_to admin_categories_path, notice: t("save_successful") }
     else
       format.turbo_stream { render partial: "admin/errors", locals: { object: @category } }
      end
    end
  end

  def edit
    # get all categories except the current category and its children
    @categories = Category.all - @category.subtree
    @brands     = Brand.published
  end

  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to admin_categories_path, notice: t("save_successful") }
      else
        format.turbo_stream { render partial: "admin/categories/errors" }
      end
    end
  end

  def destroy
    @category.destroy
    redirect_to admin_categories_path, notice: t("delete_successful")
  end

  def remove_image
    ActiveStorage::Attachment.find(params[:id]).purge
  end

  def export_products
    @category = Category.find(params[:id])
    products = @category.subtree.map(&:products).flatten

    csv_data = CSV.generate(headers: true) do |csv|
      csv << ['Product Title', 'Product Code']

      products.each do |product|
        csv << [product.title, product.code]
      end
    end

    respond_to do |format|
      format.csv { send_data csv_data, filename: "#{@category.title}-products-#{Date.today}.csv" }
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def search_params
    params.fetch(:search, {}).permit(:title, :status)
  end

  def category_params
    params.fetch(:category, {}).permit(
      :id,
      :image,
      :menu_image,
      :menu,
      :parent_id,
      :sort_order,
      :status,
      :product_price_percentage,
      :price_change_from_product_code,
      :price_change_to_product_code,
      :size_guide,
      :url_title,
      :url,
      Category.globalize_attribute_names,
      brand_ids: []
    )
  end
end
