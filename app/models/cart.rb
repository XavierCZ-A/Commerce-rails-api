class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  validates :status, presence: true
  validates :user_id, presence: true

  validates :user_id, uniqueness: { scope: :status }, if: -> { status == :active }

  enum :status, {
    active: 0,
    abandoned: 1,
    completed: 2
  }

  def total
    cart_items.sum { |item| item.product.price * item.quantity }
  end
end
