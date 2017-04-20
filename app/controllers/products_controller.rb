class ProductsController < ApplicationController
  def index
    if params[:category_id]
    @products = Product.includes(:categories).where(categories: { id: params[:category_id]})
    else
      @products = Product.all
    end
  end

  def show
    vendor = Vendor.find_by_id(params[:vendor_id])
    if vendor
    @products = vendor.products
    else
      flash[:warning] = "Invalid vendor id"
      redirect_back fallback_location: products_path
    end
  end









end
