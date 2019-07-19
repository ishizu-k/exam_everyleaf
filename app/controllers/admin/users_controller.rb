class Admin::UsersController < ApplicationController
  before_action :user_task, only: [:show, :edit, :update, :destroy]
  before_action :login_task
  before_action :admin_role

  def index
    @users = User.all.includes(:tasks)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path
      flash[:success] = "新規作成しました"
    else
      render 'new'
    end
  end

  def show
    @tasks = @user.tasks
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path
      flash[:success] = "編集しました"
    else
      render 'edit'
    end
  end

  def destroy
    if @user.destroy
       redirect_to admin_users_path
       flash[:success] = "削除しました"
     else
       redirect_to admin_users_path
       flash[:danger] = "管理ユーザーは1人以上必要です"
     end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  def user_task
    @user = User.find(params[:id])
  end

  def login_task
    unless logged_in
      redirect_to new_session_path
    end
  end

  def admin_role
    if current_user.admin?
      redirect_to admin_users_path
    else
      render "sessions/new"
      # errors.add(:admin, "権限がありません")
      flash[:danger] = "権限がありません"
    end
  end

end
