class TaskFilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: %i[show]

  def show
    @file = @task.file
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end
end
