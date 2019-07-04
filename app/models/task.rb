class Task < ApplicationRecord
  validates :name, presence: true, length:  { maximum: 30 }
  validates :content, presence: true, length: { maximum: 500 }
  validates :limit, presence: true
  validates :status, presence: true
  scope :task_index, -> {order(created_at: :desc)}
  scope :sort_expired, -> {order(limit: :desc)}
  scope :search_task_name, -> (params){where("name LIKE ?", "%#{ params }%")}
  scope :search_status, -> (params){where("status LIKE ?", "%#{ params }%")}
  scope :search_and, -> (params1, params2) do
    if params1.present? && params2.present?
      where("name LIKE ? AND status LIKE ?", "%#{ params1 }", "#{ params2 }")
    end
  end
end
