class Task < ApplicationRecord
  validates :name, presence: true, length:  { maximum: 30 }
  validates :content, presence: true, length: { maximum: 500 }
  validates :limit, presence: true
  validates :status, presence: true
  validates :priority, presence: true
  scope :task_index, -> {order(created_at: :desc)}
  scope :sort_expired, -> {order(limit: :desc)}
  scope :search_task_name, -> (params){where("name LIKE ?", "%#{ params }%")}
  scope :search_status, -> (params){where("status LIKE ?", "#{ params }%")}
  scope :sort_prioritized, -> {order(priority: :asc)}
  enum priority: {高: 0, 中: 1, 低: 2}
  paginates_per 10
  belongs_to :user
end
