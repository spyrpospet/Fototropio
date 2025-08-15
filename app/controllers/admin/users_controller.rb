class Admin::UsersController < Admin::CommonController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.order(created_at: :desc)
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to admin_users_path, notice: t("save_successful") }
      else
        format.turbo_stream { render partial: "admin/errors", locals: { object: @user } }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to admin_users_path, notice: t("save_successful") }
      else
        format.turbo_stream { render partial: "admin/errors", locals: { object: @user } }
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: t("delete_successful")
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  # Only allow the specified fields; no password updates here.
  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :description, :image)
  end
end
