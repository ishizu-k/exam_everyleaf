class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :login_task

  def index
    @labels = Label.all
    # binding.pry
    if params[:task].nil?
      @tasks = current_user.tasks.task_index.page(params[:page])
    elsif params[:task][:search]
      if params[:task][:name] && params[:task][:status].blank? && params[:task][:label_id].blank?
        @tasks = current_user.tasks.search_task_name(params[:task][:name]).page(params[:page])
      elsif params[:task][:name].blank? && params[:task][:status] && params[:task][:label_id].blank?
        @tasks = current_user.tasks.search_status(params[:task][:status]).page(params[:page])
      elsif params[:task][:name] && params[:task][:status] && params[:task][:label_id].blank?
        @tasks = current_user.tasks.search_task_name(params[:task][:name]).search_status(params[:task][:status]).page(params[:page])
      elsif params[:task][:name].blank? && params[:task][:status].blank? && params[:task][:label_id]
        @label_id = Label.where(name: params[:task][:label_id]).select("id")
        @labeling = Labeling.where(label_id: @label_id)
        @task_id = @labeling.pluck(:task_id)
        @tasks = current_user.tasks.where(id: @task_id).page(params[:page])
        # @tasks = Task.where("name LIKE ?", "%#{ params[:task][:label_id] }%")
      end
    end
      @tasks = current_user.tasks.all.sort_expired.page(params[:page]) if params[:sort_expired]
      @tasks = current_user.tasks.all.sort_prioritized.page(params[:page]) if params[:sort_prioritized]
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to tasks_path
      flash[:success] = "新規作成しました"
    else
      render 'new'
    end
  end

  def show; end

  def edit; end

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
    params.require(:task).permit(:name, :content, :limit, :sort_expired, :status, :search, :priority, :sort_prioritized, :label_id, label_ids:[])
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def login_task
    unless logged_in
      redirect_to new_session_path
    end
  end
end
