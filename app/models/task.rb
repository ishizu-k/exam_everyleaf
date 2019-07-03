class Task < ApplicationRecord
  validates :name, presence: true, length:  { maximum: 30 }
  validates :content, presence: true, length: { maximum: 500 }
  validates :limit, presence: true
  validates :status, presence: true
end
