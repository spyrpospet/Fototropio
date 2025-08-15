class Admin::LabelsController < Admin::CommonController
  before_action :set_label, only: [:edit, :update, :destroy]

  def index
    @labels = Label.all
  end

  def new
    @label  = Label.new
  end

  def create
    @label = Label.new(label_params)

    respond_to do |format|
      if @label.save
        format.html { redirect_to admin_labels_path, notice: t("save_successful") }
      else
        format.turbo_stream { render partial: "admin/errors", locals: { object: @label }}
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @label.update(label_params)
        format.html { redirect_to admin_labels_path, notice: t("save_successful") }
      else
        format.turbo_stream { render partial: "admin/errors", locals: { object: @label }}
      end
    end
  end

  def destroy
    @label.destroy
    redirect_to admin_labels_path, notice: t("delete_successful")
  end

  private

  def set_label
    @label = Label.find(params[:id])
  end

  def label_params
    params.fetch(:label, {}).permit(:id, :sort_order, :status, Label.globalize_attribute_names)
  end
end
