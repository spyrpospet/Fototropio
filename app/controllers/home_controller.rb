class HomeController < CommonController
  def index
    @pagy, @posts  = pagy(Post.reversed_published, limit: 7)
    @popular_posts = Post.published.popular.limit(5)
    @categories    = Category.published
    @recent_posts  = Post.published.order(created_at: :desc).limit(3)
  end

  def slider
    @slides = Slider.published
  end

  def posts
    @projects = Project.published
  end

  def about
    @page = Page.published.about
  end
end
