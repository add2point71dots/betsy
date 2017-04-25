class OrderitemsController < ApplicationController
  before_action :find_orderitem, only: [:show, :cancel, :ship]
  before_action :current_cart, only: [:create, :destroy]

  def show;end


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

  # only updates quantity
  def update
    @orderitem.update(orderitem_params)
  end

  def cancel
     @orderitem.status = "Cancelled"
     @orderitem.save
     flash[:success] = "You have successfully scrapped this item."
     redirect_to fulfillment_path(@orderitem.product.vendor_id)
  end

  def ship
     @orderitem.status = "Shipped"
     @orderitem.save
     flash[:success] = "You have successfully shipped this item."
     redirect_to fulfillment_path(@orderitem.product.vendor_id)
  end

  def destroy
    orderitem = Orderitem.find_by_id(params[:id])
    orderitem.destroy
    redirect_to cart_path
  end

  private


  def find_orderitem
    @orderitem = Orderitem.find_by_id(params[:id])
    render_404 if !@orderitem
  end
  
  def orderitem_params
    params.require(:orderitem).permit( :order_id, :product_id, :quantity, :status)
  end
end
