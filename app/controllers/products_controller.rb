class ProductsController < ApplicationController
  skip_before_action :authenticate, only: %i[ index show ]
  before_action :set_product, only: %i[ show update destroy ]

  # GET /products
  def index
    @products = Product.all

    render json: ProductBlueprint.render(@products)
  end

  # GET /products/1
  def show
    render json: ProductBlueprint.render(@product)
  end

  # POST /products
  def create
    @product = Product.new(product_params)

    if @product.save
      render json: ProductBlueprint.render(@product), status: :created
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      render json: ProductBlueprint.render(@product)
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.expect(product: [ :name, :description, :price ])
    end
end
