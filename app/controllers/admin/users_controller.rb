class Admin::UsersController < ApplicationController
  before_action :user_task, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
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

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def user_task
    @user = User.find(params[:id])
  end
end
