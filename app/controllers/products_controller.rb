class ProductsController < ApplicationController

  before_action :require_login, except: [:index, :show]
  before_action :find_product, only: [:show, :edit, :update]

  def index
    if params[:category_id]
      @title = "Viewing Products by Category"
      @products = Product.includes(:categories).where(categories: { id: params[:category_id]})
    else
      @title = "Viewing All Products"
      @products = Product.all
    end
    @products = @products.where("hidden = ?", false)
  end

  def show
    if !@product
      render_404
    end
    @orderitem = Orderitem.new
    @review = Review.new
    render layout: 'focus'
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.create(product_params)
    if @product.save
      flash[:success] = "New product added"
      redirect_to root_path
    else
      flash.now[:error] = "Failed to add product"
      render "new"
    end
  end

  def edit
    if !current_vendor || !owner?
      flash[:error] = "You don't have access to other vendor's products"
      redirect_to root_path
    end
  end

  def update
    if !current_vendor
      flash[:error] = "You must be logged in to view this page."
    elsif !owner?
      flash[:error] = "You don't have access to other vendor's products"
      redirect_to root_path
    else
      @product.update(product_params)
      redirect_to product_path(@product.id)
      flash[:success] = "Successfully updated your product"
    end
  end

  private

  def product_params
    params.require(:product).permit( :vendor_id, :name, :quantity, :price, :description, :photo_url )
  end

  def find_product
    @product = Product.find_by_id(params[:id])
  end

  def owner?
    return session[:vendor_id] == @product.vendor.id || Vendor.find_by_id(session[:vendor_id]).username.split[0..7] == "rana.ag" ? true : false
  end
end
