class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    if params[:sort_expired]
      @tasks = Task.all.order(limit: :desc)
    else
      @tasks = Task.all.order(created_at: :desc)
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path
      flash[:success] = "新規作成しました"
    else
      render 'new'
    end
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
    params.require(:task).permit(:name, :content, :limit, :sort_expired, :status)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
