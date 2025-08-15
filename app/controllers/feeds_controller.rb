class FeedsController < CommonController
  def sitemap
    @products   = Product.published
    @pages      = Page.published
    @brands     = Brand.published
    @categories = Category.published

    respond_to do |format|
      format.xml
    end
  end

  def google_merchant
    @products = Product.published

    respond_to do |format|
      format.xml
    end
  end
end
