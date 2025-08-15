class Admin::PagesController < Admin::CommonController
  before_action :set_page, only: [:edit, :update, :destroy]

  def index
    @pages = Page.all
  end

  def new
    @page  = Page.new
    @pages = Page.published
  end

  def create
    @page = Page.new(page_params)

    respond_to do |format|
      if @page.save
        format.html { redirect_to admin_pages_path, notice: t("save_successful") }
      else
        format.turbo_stream { render partial: "admin/errors", locals: { object: @page }}
      end
    end
  end

  def edit
    @pages = Page.published
  end

  def update
    respond_to do |format|
      if @page.update(page_params)
        format.html { redirect_to admin_pages_path, notice: t("save_successful") }
      else
        format.turbo_stream { render partial: "admin/errors", locals: { object: @page }}
      end
    end
  end

  def destroy
    @page.destroy
    redirect_to admin_pages_path, notice: t("delete_successful")
  end

  private

  def set_page
    @page = Page.find(params[:id])
  end

  def page_params
    params.fetch(:page, {}).permit(
      :id,
      :parent_id,
      :image,
      :second_image,
      :sub_image,
      :sort_order,
      :status,
      :footer,
      :menu,
      :qlink,
      Page.globalize_attribute_names
    )
  end
end
