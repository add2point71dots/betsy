class OrdersController < ApplicationController
  before_action :find_order, only: [:show,]
  before_action :current_cart, except: [:show]

  # order details: we may not need this action/view, which will show shipping/billing info
  def show;end

  # shows current cart with all the orderitem belonging to session[:order_id]
  def show_cart;end

  # show form for checkout page
  def edit;end

  # update order state from pening to paid with required shipping/billing info
  def update
    @cart.update(order_params)
    @cart.update(order_state: "paid")
    redirect_to confirm_path
  end

  # shows order summary and confirmation page, then resets session[:order_id] to nil
  def confirm
    session[:order_id] = nil
  end

  private

  def order_params
    params.require(:order).permit( :order_state, :name, :email, :street_address, :city, :state, :zip_code, :name_on_card, :card_number, :exp_month, :exp_year, :cvv, :billing_zip_code)
  end

  def find_order
    @order = Order.find_by_id(params[:id])
    render_404 if !@order
  end
end
