class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  enum :status, {
    active: 0,
    abandoned: 1,
    completed: 2
  }
end
