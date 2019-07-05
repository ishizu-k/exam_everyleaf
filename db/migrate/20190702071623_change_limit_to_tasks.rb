class ChangeLimitToTasks < ActiveRecord::Migration[5.2]
  def change
    change_column_null :tasks, :limit, false
    change_column_default :tasks, :limit, ""
  end
end
