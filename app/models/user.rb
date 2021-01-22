class User < ApplicationRecord
  validates :name, presence: true
  before_validation { email.downcase! }
  validates :email, presence: true,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]*\.[a-z]+\z/i }
  has_secure_password
  validates :password, presence: true, on: :craete
  has_many :tasks, dependent: :destroy
  before_update :admin_change_check
  before_destroy :admin_change_check
  def admin_change_check
    target = User.find_by(id: self.id)
    if User.where(admin: true).count <= 1
      if target.admin
        throw :abort
      end
    end
  end
end