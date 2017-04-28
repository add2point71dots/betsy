class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_vendor
  helper_method :cart_count

  def current_vendor
    @logged_in_vendor ||= Vendor.find_by(id: session[:vendor_id])
  end

  def render_404
   render file: "#{ Rails.root }/public/404.html", status: 404
  end

  def require_login
    if !current_vendor
      flash[:error] = "You must be logged in to view this page."
      redirect_to root_path
    end
  end

  def current_cart
    @cart = Order.find_by(id: session[:order_id])

    if !@cart
      @cart = Order.create(order_state: "pending")
      session[:order_id] = @cart.id
    end
  end

  def cart_count
    current_cart
    if @cart.orderitems.count > 0
       quantity = @cart.orderitems.map { | orderitem | orderitem.quantity }
       @total_quantity = quantity.inject { | sum, quantity | sum + quantity }
    else
      @total_quantitiy = 0
    end
  end
end
