class OrderitemsController < ApplicationController
  before_action :find_orderitem, only: [:show, :cancel, :ship]

  def show;end

  def create
    @orderitem = Orderitem.create(orderitem_params)
    if @orderitem.save
      flash[:success] = "Item: #{@orderitem.product.name} Qt: #{@orderitem.quantity} has been added to your cart"
    else
      flash.now[:error] = "Failed to add item(s) to cart"
    end
  end

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
    Orderitem.destroy(params[:id])
  end

  private

  def find_orderitem
    @orderitem = Orderitem.find_by_id(params[:id])
    render_404 if !@orderitem
  end

  def orderitem_params
    params.require(:orderitem).permit( :order_id, :product_id, :quantity)
  end
end
