class CartItemsController < ApplicationController
  def create
    active_cart = find_or_create_cart
    unless active_cart
      render json: { error: "No se pudo crear o encontrar un carrito activo" }, status: :unprocessable_entity
      return
    end

    product = Product.find_by(id: params[:product_id])
    unless product
      render json: { error: "Producto no encontrado" }, status: :not_found
      return
    end

    quantity_to_add = params[:quantity].to_i
    if quantity_to_add <= 0
      render json: { error: "La cantidad debe ser mayor que 0" }, status: :unprocessable_entity
      return
    end

    cart_item = active_cart.cart_items.build(product: product, quantity: quantity_to_add)
    if cart_item.save
      render json: cart_item, status: :created
    else
      render json: { error: cart_item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def find_or_create_cart
    @cart = Cart.find_or_create_by(user: @current_user)
    @cart.update(status: 0) if @cart.status == 1
    @cart
  end
end
