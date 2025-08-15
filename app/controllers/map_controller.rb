class MapController < CommonController
  def index
    @slugs = params[:slugs].split('/')

    return if about_page
    return if post
    return if category
    return if page
    return if contact

    raise ActionController::RoutingError, 'Not Found' if @slugs.length > 0
  end

  def about_page
    return false unless @slugs.length == 1 && @slugs.first == 'about-page'

    @user = User.first

    respond_to do |format|
      format.html { render "about"}
    end

    true
  end

  def post
    return false unless @slugs.length == 1

    @post = Post.published.find_by(slug: @slugs.first)

    return false if @post.blank?

    respond_to do |format|
      format.html { render "post"}
    end

    true
  end

  def category
    @category = Category.find_by(slug: @slugs.last)

    return false if @category.blank?

    respond_to do |format|
      format.html { render "category"}
    end

    true
  end

  def page
    return false unless @slugs.length == 1

    @page = Page.published.find_by(slug: @slugs.first)

    return false if @page.blank?

    respond_to do |format|
      format.html { render "page"}
    end

    true
  end

  def contact
    return unless @slugs.length == 1 && @slugs.first == "epikoinwnia"

    respond_to do |format|
      format.html { render "contact"}
    end

    true
  end
end
