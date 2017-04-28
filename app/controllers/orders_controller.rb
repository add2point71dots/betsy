class OrdersController < ApplicationController
  before_action :find_order, only: [:show]
  before_action :current_cart, except: [:show]
  before_action :total_quantity, only: [:show_cart]
  before_action :total_price, only: [:show_cart]
  before_action :sort_items, only: [:show_cart]


  # shows shipping/billing info for the order
  # orders controller method 'find_order' is excecuted prior to entering action
  def show; end

  # shows current cart detail belonging to session[:order_id]
  # application controller method 'current_cart' is excecuted prior to entering action to retreive @cart
  def show_cart;
       render layout: 'cart'
  end

  # show order edit form for the checkout page where shoppers fill in shipping/billing info for the order
  # application controller method 'current_cart' is excecuted prior to entering action to retreive @cart
  def edit
    if @cart.orderitems.count == 0
      flash[:failure] = "You are trying to checkout with an empty cart"
      redirect_to root_path
      return
    end
    render layout: 'two-columns'
  end

  # completes checkout process -- happens right after clicking the 'place order' button
  # order_state: "paid" is passed into params as a hidden field from the edit form
  # application controller method 'current_cart' is excecuted prior to entering action to retreive @cart
  def update
    if @cart.update(order_params)
      flash[:success] = "Your order has been placed successfully"
      # order model method 'update_orderitem_status' changes the orderitems status from "pending" to "paid"
      @cart.update_orderitem_status
      # order model method 'update_product_stock' updates the inventory of the product ro reflect sale
      @cart.update_product_stock
      # updates the card_number stored in the databas -- only store last 4 digits
      @cart.update(card_number: @cart.card_number.split('').last(4).join)
      redirect_to confirm_path
      return
    else
      flash.now[:failure] = "A problem occurred: Could not place order"
      render :edit
    end
  end

  # show order confirmation page showing each item in the order with a quantity and line-item subtotal
  def confirm
    # resets sessions to  clear the current cart once the order has been confirmed
    session[:order_id] = nil
  end

  def total_quantity
    quantity = @cart.orderitems.map { | orderitem | orderitem.quantity }
    @total_quantity = quantity.inject { | sum, quantity | sum + quantity }
  end

  def total_price
    prices = @cart.orderitems.map { | orderitem | orderitem.product.price * orderitem.quantity }
    @total_price = prices.inject { | sum, price | sum + price }
  end

  def reset
    @cart.orderitems.each do | orderitem |
      orderitem.destroy
    end
    flash[:success] = "Your cart has been emptied!"
    redirect_to root_path
  end

  private

  def order_params
    params.require(:order).permit( :order_state, :name, :email, :street_address, :city, :state, :zip_code, :name_on_card, :card_number, :exp_month, :exp_year, :cvv, :billing_zip_code)
  end

  def find_order
    @order = Order.find_by_id(params[:id])
    render_404 if !@order
  end

  def sort_items
    @sorted_items = @cart.orderitems.sort_by(&:created_at)
  end
end
