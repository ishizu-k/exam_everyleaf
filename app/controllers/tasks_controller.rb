class TasksController < ApplicationController

  def index
  end

  def new
    @task = Task.new
  end

  def create
    Task.create(task_params)
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def task_params
    params.require(:task).permit(:name, :content)
  end
end
