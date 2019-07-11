class User < ApplicationRecord
  validates :name, presence: true, length:  { maximum: 30 }, uniqueness: true
  validates :email, presence: true, length:  { maximum: 255 }, uniqueness: true,
   format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  has_many :tasks
end
