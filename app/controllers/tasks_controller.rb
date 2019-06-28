class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all.order(created_at: :desc)
  end

  def new
    @task = Task.new
  end

  def create
    Task.create(task_params)
    redirect_to tasks_path
    flash[:success] = "新規作成しました"
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path
      flash[:success] = "編集しました"
    else
      render 'edit'
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path
    flash[:success] = "削除しました"
  end

  private

  def task_params
    params.require(:task).permit(:name, :content)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
