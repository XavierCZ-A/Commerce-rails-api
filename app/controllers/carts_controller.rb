class CartsController < ApplicationController
  def show
    @cart = Cart.find_by(user: @current_user, status: :active)
    @cart_items = @cart.cart_items
    if @cart
      render json: CartBlueprint.render(@cart, view: :with_items)
    else
      render json: { error: "No se encontró un carrito para el usuario actual" }, status: :not_found
    end
  end

  def destroy
    @cart = Cart.find_by(user: @current_user)
    @cart_items = @cart.cart_items
    @cart_items.destroy_all
    render json: { message: "Carrito eliminado correctamente" }, status: :ok
  end
end
