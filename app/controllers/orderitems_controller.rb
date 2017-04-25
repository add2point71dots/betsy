class OrderitemsController < ApplicationController
  before_action :current_cart, only: [:create, :destroy]

  def create
    @cart.add_to_cart(params)
    if @cart.save
      flash[:success] = "#{new_orderitem.product.name} (Qt: #{new_orderitem.quantity}) has been added to your cart"
      redirect_to cart_path
    else
      flash[:error] = "Oops! Something went wrong and we couldn't add this item to your cart"
      redirect_to product_path(new_orderitem.product_id)
    end
  end

  def update
    @orderitem.update(orderitem_params)
  end

  def destroy
    Orderitem.destroy(params[:id])
    redirect_to cart_path
  end

  private

  def orderitem_params
    params.require(:orderitem).permit( :order_id, :product_id, :quantity, :status)
  end
end
