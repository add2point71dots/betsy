class OrderitemsController < ApplicationController
  before_action :current_cart

  def create
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
