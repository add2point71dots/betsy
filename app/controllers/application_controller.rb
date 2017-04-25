class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_vendor

  def current_vendor
    @logged_in_vendor ||= Vendor.find_by(id: session[:vendor_id])
  end

  def render_404
    render file: "#{ Rails.root }/public/404.html", status: 404
  end
end
