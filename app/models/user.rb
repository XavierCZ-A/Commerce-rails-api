class User < ApplicationRecord
  has_secure_password
  has_many :carts, dependent: :destroy
  has_many :orders, dependent: :destroy

  validates :first_name, presence: true, length: { minimum: 2 }
  validates :last_name, presence: true, length: { minimum: 2 }
  validates :email_address, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 8 }

  def full_name
    "#{first_name} #{last_name}"
  end
end
