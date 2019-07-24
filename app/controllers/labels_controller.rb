class LabelsController < ApplicationController
  def new
    @label = Label.new
  end

  def create
    Label.create(label_params)
    redirect_to admin_users_path
  end

  private

  def label_params
    params.require(:label).permit(:name)
  end
end
