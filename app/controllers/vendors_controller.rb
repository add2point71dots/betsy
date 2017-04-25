class VendorsController < ApplicationController
  before_action :find_vendor, only: [:show, :fulfillment]

  def index
    @vendors = Vendor.all
  end

  def show; end

  def fulfillment
     @order_items = @vendor.orderitems
  end

  private

  def find_vendor
    @vendor = Vendor.find_by_id(params[:id])
    render_404 if !@vendor
  end
end
