class OrderitemsController < ApplicationController

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

  def destroy
    Orderitem.destroy(params[:id])
  end

  private

  def orderitem_params
    params.require(:orderitem).permit( :order_id, :product_id, :quantity)
  end
end
