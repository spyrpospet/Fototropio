class Admin::ProductsController < Admin::CommonController
  before_action :set_product, only: %i[edit update destroy move]
  before_action :set_dependencies, only: %i[new edit]

  def index
    @pagy, @products = pagy(Product.common.all, limit: 20)

    if params[:search].present?
      filters = []
      query   = search_params["title"] || "*"
      sorts   = ["sort_order:asc"]

      filters << "status=#{search_params["status"]}" if search_params["status"].present?

      @products = Product.pagy_search(query, {
        attributesToSearchOn: ["title_#{I18n.locale}", :code],
        filter: filters,
        matchingStrategy: "all",
        hitsPerPage: 20,
        sort: sorts
      })

      @pagy, @products = pagy_meilisearch(@products, limit: 20)

      render partial: "admin/products/list"
    end
  end

  def new
    @product  = Product.new
  end

  def create
    @product = Product.new(product_params.except(:images))

    respond_to do |format|
      if @product.save

        params[:product][:images]&.each do |image|
          next if image.blank?

          @product.images.attach(image)
        end

        format.html { redirect_to edit_admin_product_path(@product), notice: t("save_successful") }
      else
        format.turbo_stream { render partial: "admin/errors", locals: { object: @product }}
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @product.update(product_params.except(:images))

        params[:product][:images]&.each do |image|
          next if image.blank?

          @product.images.attach(image)
        end

        format.html { redirect_to edit_admin_product_path(@product), notice: t("save_successful") }
      else
        format.turbo_stream { render partial: "admin/errors", locals: { object: @product }}
      end
    end
  end

  def destroy
    @product.destroy
    redirect_to admin_products_path, notice: t("delete_successful")
  end

  def add_new_option
    @dom_id  = rand(1000..2000)
    @option  = Option.find(params[:option_id])
    @product = params[:product_id].present? ? Product.find(params[:product_id]) : Product.new

    @product.options_products.new
  end

  def add_new_option_item
    @dom_id  = params[:dom_id]
    @option  = Option.find(params[:option_id])
    @product = params[:product_id].present? ? Product.find(params[:product_id]) : Product.new

    @product.options_products.new(option_id: @option.id).options_products_item.new
  end

  def add_new_tab
    @dom_id  = rand(1000..2000)
  end

  def remove_image
    @attachment = ActiveStorage::Attachment.find(params[:id])
    @attachment.purge
  end

  def mass_destroy
    Product.where(id: params[:ids]).destroy_all

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.update("csv-success", partial: "/admin/products/mass_destroy/success") }
    end
  end

  def move
    new_order   = params[:new_order]
    attachments = @product.images

    new_order.each_with_index do |id, index|
      attachments.find(id).update(position: index)
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def set_dependencies
    @categories     = Category.published
    @brands         = Brand.published
    @availabilities = Availability.all
    @options        = Option.published
    @labels         = Label.published
  end

  def search_params
    params.fetch(:search, {}).permit(:title, :status)
  end

  def product_params
    params.fetch(:product, {}).permit(
      :id,
      :code,
      :mpn,
      :sku,
      :brand_id,
      :availability_id,
      :label_id,
      :price,
      :offer,
      :quantity,
      :subtract,
      :images,
      :sort_order,
      :best_seller,
      :new_arrival,
      :status,
      :mechanism,
      :crystal,
      :dial_color,
      :frame_material,
      :bracelet,
      :strap,
      :clasp,
      :raincoat,
      :case_size,
      :operations,
      :warranty,
      :material_metal,
      :gold_karats,
      :finish,
      :weight,
      :stone,
      :stone_cutting,
      :stone_weight,
      :stone_color,
      :stone_purity,
      :jewelry_dimensions,
      :collection,
      Product.globalize_attribute_names,
      category_ids: [],
      tabs_attributes: [
        :id,
        :_destroy,
        Tab.globalize_attribute_names
      ],
      options_products_attributes: [
        :id,
        :option_id,
        :required,
        :filter,
        :characteristic,
        :_destroy,
        options_products_item_attributes: [
          :id,
          :item_id,
          :option_item_id,
          :_destroy
        ]
      ]
    )
  end
end
