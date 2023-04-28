class TasksController < ApplicationController
  include Filterable

  before_action :authenticate_user!
  before_action :set_task, only: %i[show edit update destroy]
  before_action :find_project, only: :new

  # GET /tasks or /tasks.json
  def index
    @tasks = filter!(Task, 'tasks').joins(:assigned_users).where('users.id = ?', current_user.id)
  end

  def tasks_map
    @tasks = current_user.assigned_tasks
    respond_to do |format|
      format.html
      format.json { render json: @tasks }
    end
  end

  # GET /tasks/1 or /tasks/1.json
  def show
    authorize @task
  end

  # GET /tasks/new
  def new
    @task = @project.tasks.build
  end

  # GET /tasks/1/edit
  def edit
    authorize @task
  end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)
    authorize @task
    if @task.save
      render turbo_stream: turbo_stream.append(
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
    authorize @task
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
    authorize @task
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
    params.require(:task).permit(:name, :project_id, :description, :priority, :longitude, :latitude, :file,
                                 assigned_user_ids: [])
  end
end
