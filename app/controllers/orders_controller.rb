class OrdersController < ApplicationController
  def create
    @order = Order.new(order_params)
    if @order.save
      render json: @order, status: :created
    else
      render json: { errors: @order.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
  def order_params
    params.expect(order: [ :total_amount, :status ])
  end
end
