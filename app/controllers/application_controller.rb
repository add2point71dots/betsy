class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_vendor

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
    if !session[:order_id]
      order = Order.create(order_state: "pending")
      session[:order_id] = order.id
    end
    @cart = Order.find_by(id: session[:order_id])
  end
end
