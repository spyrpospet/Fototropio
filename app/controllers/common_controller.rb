class CommonController < ApplicationController
  layout :layout_by_resource

  before_action :set_session
  before_action :set_dependencies
  before_action :set_order
  before_action :redirections

  private

  def set_dependencies
    @settings         = Setting.first
    @user             = User.first
    @menu_categories  = Category.top_menu.published
    @menu_pages       = Page.menu.published
    @footer_pages     = Page.footer.published
    @quick_links      = Page.quick_links.published
  end

  def layout_by_resource
    turbo_frame_request? ? false : "application"
  end

  def set_session
    session["guest"]  ||= {}
    session["cart"]   ||= {}
  end

  def set_order
    @count    = 0

    order_id  = session["cart"]["order_id"]
    @order    = Order.pending_state.find_by(id: order_id) if order_id.present?

    @count    = @order.total_quantity if @order.present?
  end

  def redirections
    if request.path.include?("ell/categories/")
      segments  = request.path.split("/")
      slug      = segments.last
      category  = Category.published.find_by(slug: slug)
      if category.present?
        url      = []
        category.ancestors&.each do |ancestor|
          url << ancestor.slug
        end

        url << category.slug

        redirect_to map_url(url), status: 301
      else
        return render text: "Not Found", status: 404
      end
    end

    if request.path.include?("ell/product/")
      segments  = request.path.split("/")
      slug      = segments.last
      product   = Product.published.find_by(slug: slug)
      if product.present?
        url      = []
        url << product.categories&.first.slug if product.categories.present?

        url << product.slug

        redirect_to map_url(url), status: 301
      else
        return render text: "Not Found", status: 404
      end
    end

    if request.path.include?("ell/supplier/")
      segments  = request.path.split("/")
      slug      = segments.last
      supplier  = Brand.published.find_by(slug: slug)
      if supplier.present?
        url      = ["brands"]
        url << supplier.slug

        redirect_to map_url(url), status: 301
      else
        return render text: "Not Found", status: 404
      end
    end
  end
end
