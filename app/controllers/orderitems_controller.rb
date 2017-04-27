class OrderitemsController < ApplicationController
  before_action :find_orderitem, only: [:show, :cancel, :ship]
  before_action :current_cart, only: [:create, :destroy]

  # might not need show action
  def show;end


  def create

    quantity = params[:orderitem][:quantity].to_i
    product = Product.find_by_id(params[:orderitem][:product_id].to_i)
    if product.quantity == 0
      flash[:failure] =  "This item is sold out"
      redirect_to product_path(product.id)
      return
    elsif quantity - product.quantity > 0
      flash[:failure] =  "Quantity too large: only #{product.quantity} left in stock!"
      redirect_to product_path(product.id)
      return
    elsif quantity == 0
      flash[:failure] =  "You must add at least 1 item to the cart"
      redirect_to product_path(product.id)
      return
    end

    if current_orderitem = @cart.orderitems.find_by(product_id: params[:orderitem][:product_id])
     item_quantity = @cart.orderitems.find_by(product_id: params[:orderitem][:product_id]).quantity
   else
     item_quantity = 0
    end

    @cart.add_to_cart(params)

    if @cart.save && item_quantity < @cart.orderitems.find_by(product_id: params[:orderitem][:product_id]).quantity
      flash[:success] = "Item has been added to your cart"
      redirect_to cart_path
      return
    else
      flash[:failure] = "Oops! Something went wrong and we couldn't add this item to your cart"
      redirect_to product_path(product.id)
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

  # checks the availability in the product inventory
  def valid_quantity

  end

  def find_orderitem
    @orderitem = Orderitem.find_by_id(params[:id])
    render_404 if !@orderitem
  end

  def orderitem_params
    params.require(:orderitem).permit( :order_id, :product_id, :quantity, :status)
  end
end
