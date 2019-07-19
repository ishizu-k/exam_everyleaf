class User < ApplicationRecord
  before_destroy :need_at_least_one_admin
  before_validation { email.downcase! }
  has_many :tasks, dependent: :destroy
  has_secure_password
  validates :name, presence: true, length:  { maximum: 30 }, uniqueness: true
  validates :email, presence: true, length:  { maximum: 255 }, uniqueness: true,
   format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, length:  { minimum: 6 }

  private

  def need_at_least_one_admin
    if User.where(admin: true).length == 1 && self.admin?
      throw :abort
    end
  end
end
