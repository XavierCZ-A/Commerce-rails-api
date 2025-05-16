class OrdersController < ApplicationController
  def index
    orders = @current_user.orders
    render json: { orders: orders }, status: :ok
  end

  def create
    cart = current_active_cart
    if cart.nil? || cart.cart_items.empty?
      render json: { error: "Carrito vacío" }, status: :unprocessable_entity and return
    end

    checkout_service = CheckoutService.new(@current_user, cart, cart.total)

    result = checkout_service.call

    if result.order
      render json: OrderBlueprint.render(result.order), status: :created
    else
      render json: { error: result.error }, status: :unprocessable_entity
    end
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end
end
