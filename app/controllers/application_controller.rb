class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def render_404
    render file: "#{ Rails.root }/public/404.html", status: 404
  end

  def current_cart
    @cart = Order.find_by_id(session[:order_id])
  rescue ActiveRecord::RecordNotFound
    @cart = Order.create(order_state: "pending")
    session[:order_id] = @cart.id
  end
end
