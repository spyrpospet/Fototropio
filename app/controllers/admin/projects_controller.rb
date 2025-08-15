class Admin::ProjectsController < Admin::CommonController
  before_action :set_project, only: [:edit, :update, :destroy]

  def index
    @projects = Project.all
  end

  def new
    @project  = Project.new
  end

  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to admin_projects_path, notice: t("save_successful") }
      else
        format.turbo_stream { render partial: "admin/errors", locals: { object: @project }}
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to admin_projects_path, notice: t("save_successful") }
      else
        format.turbo_stream { render partial: "admin/errors", locals: { object: @project }}
      end
    end
  end

  def destroy
    @project.destroy
    redirect_to admin_projects_path, notice: t("delete_successful")
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.fetch(:project, {}).permit(:id, :image, :sort_order, :status, Project.globalize_attribute_names)
  end
end
