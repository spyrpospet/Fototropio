class Admin::PostsController < Admin::CommonController
  before_action :set_post, only: %i[ show edit update destroy ]

  def index
    @posts = Post.common
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

  def post_params
    params.require(:post).permit(
      *Post.globalize_attribute_names,
      :popular,
      :image,
      :status,
      category_ids: []
    )
  end
end
