class Admin::PostsController < Admin::CommonController
  before_action :set_post, only: %i[ show edit update destroy ]

  def index
    @pagy, @posts = pagy(Post.common, limit: 20)

    if params[:search].present?
      query = search_params["title"] || "*"
      sorts = ["sort_order:asc"]

      @posts = Post.pagy_search(query, {
        attributesToSearchOn: ["title_#{I18n.locale}"],
        matchingStrategy: "all",
        hitsPerPage: 20,
        sort: sorts
      })

      @pagy, @posts = pagy_meilisearch(@posts, limit: 20)

      render partial: "admin/posts/list"
    elsif turbo_frame_request? || params[:page].present?
      # When paginating within Turbo Frames (or explicitly requesting a page),
      # render only the list to avoid empty responses due to content_for usage
      render partial: "admin/posts/list"
    end
  end

  def show
  end

  def new
    @post       = Post.new
    @categories = Category.published
  end

  def edit
    @categories = Category.published
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to admin_posts_path, notice: "Post was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      redirect_to admin_posts_path, notice: "Post was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to admin_posts_path, notice: "Post was successfully destroyed."
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def search_params
    params.fetch(:search, {}).permit(:title)
  end

  def post_params
    params.require(:post).permit(
      *Post.globalize_attribute_names,
      :popular,
      :image,
      :status,
      :sort_order,
      category_ids: []
    )
  end
end
