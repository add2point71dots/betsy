class ProductsController < ApplicationController


  before_action :find_product, only: [:show, :edit, :update]

  def index
    if params[:category_id]
    @products = Product.includes(:categories).where(categories: { id: params[:category_id]})
    else
      @products = Product.all
    end
  end


  def show
      if !@product
        render_404
      end
  end

  def create
      @product = Product.create(product_params)
      if @product.save
        flash[:success] = "New product added"
        redirect_to products_path
      else
        flash.now[:error] = "Failed to add product"
        render "new"
      end
    end

    def edit; end

    def update
      @product.update(product_params)
    end

    def destroy
      Product.destroy(params[:id])
      redirect_to products_path
    end

    private

    def product_params
      params.require(:product).permit( :vendor_id, :name, :quantity, :price, :description, :photo_url )
    end

    def find_product
      @product = Product.find_by_id(params[:id])
    end


end
