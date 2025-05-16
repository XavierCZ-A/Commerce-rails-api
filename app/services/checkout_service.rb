class CheckoutService
  Result = Struct.new(:order, :error)

  def initialize(user, cart, total_amount)
    @user = user
    @cart = cart
    @total_amount = total_amount
  end

  def call
    ActiveRecord::Base.transaction do
      validate_stock

      order = Order.create!(user: @user, total_amount: @total_amount)

      create_order_items(order)

      update_cart

      update_inventory(order)

      Result.new(order, nil)
    end
  rescue => e
    Rails.logger.error("Checkout failed: #{e.message}")
    Result.new(nil, e.message)
  end

  private

  def validate_stock
    @cart.cart_items.each do |cart_item|
      if cart_item.product.stock < cart_item.quantity
        raise StandardError, "Stock insufficient for product #{cart_item.product.name}"
      end
    end
  end

  def create_order_items(order)
    @cart.cart_items.each do |cart_item|
      order.order_items.create!(
        product: cart_item.product,
        quantity: cart_item.quantity
      )
    end
  end

  def update_cart
    @cart.update!(status: :completed)
  end

  def update_inventory(order)
    order.order_items.each do |order_item|
      product = order_item.product
      product.decrement!(:stock, order_item.quantity)
    end
  end
end
