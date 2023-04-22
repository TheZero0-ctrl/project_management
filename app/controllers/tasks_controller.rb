class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: %i[show edit update destroy]
  before_action :find_project, only: :new

  # GET /tasks or /tasks.json
  def index
    @tasks = current_user.assigned_tasks
  end

  # GET /tasks/1 or /tasks/1.json
  def show; end

  # GET /tasks/new
  def new
    @task = @project.tasks.build
  end

  # GET /tasks/1/edit
  def edit; end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)
    if @task.save
      render turbo_stream: turbo_stream.prepend(
        'tasks',
        partial: 'task',
        locals: { task: @task }
      )
    else
      render turbo_stream: turbo_stream.replace(
        'task-form',
        partial: 'form',
        locals: { task: @task }
      ), status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    if @task.update(task_params)
      render turbo_stream: turbo_stream.replace(@task)
    else
      render turbo_stream: turbo_stream.replace(
        'task-form',
        partial: 'form',
        locals: { task: @task }
      ), status: :unprocessable_entity
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy
    render turbo_stream: turbo_stream.remove(@task)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find(params[:id])
  end

  def find_project
    @project = Project.find(params[:project_id])
  end

  # Only allow a list of trusted parameters through.
  def task_params
    params.require(:task).permit(:name, :project_id, :description, :priority, :longitude, :latitude, assigned_user_ids:[])
  end
end
