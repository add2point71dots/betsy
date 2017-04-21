class ProductsController < ApplicationController
     def index
          if params[:category_id]
               category = Category.find_by(id: params[:category_id])
               @products = category.products
          else
               @products = Product.all
          end
     end

  def show
    @product = Product.find_by(params[:id])
      if !@product
        render file: "#{Rails.root}/public/404.html", status: 404
      end
  end

  def show_by_vendor_id
    vendor = Vendor.find_by_id(params[:vendor_id])
    if vendor
    @products = vendor.products
    else
      flash[:warning] = "Invalid vendor id"
      redirect_back fallback_location: products_path
    end
  end












end
