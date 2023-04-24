class ProjectsController < ApplicationController
  include Filterable

  before_action :authenticate_user!
  before_action :set_project, only: %i[show edit update destroy project_tasks]

  # GET /projects or /projects.json
  def index
    @projects = Project.where(user: current_user).includes(:tasks)
  end

  # GET /projects/1 or /projects/1.json
  def show
    @tasks = filter!(Task, "project_tasks_#{@project.id}").where(project_id: @project.id)
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit; end

  # POST /projects or /projects.json
  def create
    @project = Project.new(project_params)
    @project.user = current_user

    if @project.save
      render turbo_stream: turbo_stream.prepend(
        'projects',
        partial: 'project',
        locals: { project: @project }
      )
    else
      render turbo_stream: turbo_stream.replace(
        'project-form',
        partial: 'form',
        locals: { project: @project }
      ), status: :unprocessable_entity
    end
  end

  # PATCH/PUT /projects/1 or /projects/1.json
  def update
    if @project.update(project_params)
      render turbo_stream: turbo_stream.replace(@project)
    else
      render turbo_stream: turbo_stream.replace(
        'project-form',
        partial: 'form',
        locals: { project: @project }
      ), status: :unprocessable_entity
    end
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    @project.destroy
    render turbo_stream: turbo_stream.remove(@project)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def project_params
    params.require(:project).permit(:name)
  end
end
