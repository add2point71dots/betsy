class ProductsController < ApplicationController
  def index
    if params[:category_id]
    @products = Product.includes(:categories).where(categories: { id: params[:category_id]})
    else
      @products = Product.all
    end
  end

  def show
    @product = Product.find_by(params[:id])
      if !@product
        render_404
      end
  end


  end












end
