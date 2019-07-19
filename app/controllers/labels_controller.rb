class LabelsController < ApplicationController

  def index
  end

  def new
    @label = Label.new
  end

  def create
    Label.create(label_params)
    redirect_to admin_users_path
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def label_params
    params.require(:label).permit(:name)
  end
end
