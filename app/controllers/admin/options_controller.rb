class Admin::OptionsController < Admin::CommonController
  before_action :set_option, only: [:edit, :update, :destroy]

  def index
    @options = Option.all
  end

  def new
    @option  = Option.new
  end

  def create
    @option = Option.new(option_params)

    respond_to do |format|
      if @option.save
        format.html { redirect_to admin_options_path, notice: t("save_successful") }
      else
        format.turbo_stream { render partial: "admin/errors", locals: { object: @option }}
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @option.update(option_params)
        format.html { redirect_to admin_options_path, notice: t("save_successful") }
      else
        format.turbo_stream { render partial: "admin/errors", locals: { object: @option }}
      end
    end
  end

  def destroy
    @option.destroy
    redirect_to admin_options_path, notice: t("delete_successful")
  end

  def add_new_item
    @option     = Option.new
    @option.items.build

    @unique_id  = SecureRandom.uuid
  end

  def remove_item
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@item) }
    end
  end

  private

  def set_option
    @option = Option.find(params[:id])
  end

  def option_params
    params.fetch(:option, {}).permit(
      :id,
      :sort_order,
      :status,
      Option.globalize_attribute_names,
      items_attributes: [
        :id,
        :image,
        :sort_order,
        :status,
        Item.globalize_attribute_names
      ]
    )
  end
end
