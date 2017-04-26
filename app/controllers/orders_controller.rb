class OrdersController < ApplicationController
  before_action :find_order, only: [:show]
  before_action :current_cart, except: [:show]

  # shows current cart detail belonging to session[:order_id]
  def show_cart;end

  # shows shipping/billing info for the order
  def show;end

  # show form for checkout page where shopper puts in shipping/billing info
  def edit;end

  # completes checkout and order state is changed to paid
  def update
    @cart.order_state = "paid"

    if @cart.update(order_params)
      flash[:success] = "Your order has been placed successfully"

      @cart.update_orderitem_status
      @cart.update_product_stock
      @cart.last_four_digits
      redirect_to confirm_path
    else
      flash.now[:failure] = "A problem occurred: Could not place order"
      render :edit
    end
  end

  def confirm
    # resets sessions
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
