class Admin::UsersController < ApplicationController
  before_action :user_task, only: [:show, :edit, :update, :destroy]
  before_action :user_role

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
    @user.destroy
    redirect_to admin_users_path
    flash[:success] = "削除しました"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  def user_task
    @user = User.find(params[:id])
  end

  def user_role
    if admin_role
      # あとで専用エラーに変更する
      redirect_to new_session_path
    end
  end
end
