class VendorsController < ApplicationController
  before_action :find_vendor, except: [:index]
  before_action :find_orderitems, except: [:index, :show]
  before_action :render_orderitems, except: [:index, :show, :fulfillment]
  before_action :tally_earnings, except: [:index, :show]
  before_action :tally_count, except: [:index, :show]


  def index
    @vendors = Vendor.all
  end

  def show; end

  def fulfillment; end

  def fulfillment_pending; end

  def fulfillment_paid; end

  def fulfillment_shipped; end

  def fulfillment_cancelled; end

  private

  def tally_earnings
     @total_earnings = @order_items.where('status = ? OR status = ?', 'Paid', 'Shipped').sum(:price)
     @pending_earnings = @order_items.where(status: 'Pending').sum(:price)
     @paid_earnings = @order_items.where(status: 'Paid').sum(:price)
     @shipped_earnings = @order_items.where(status: 'Shipped').sum(:price)
     @cancelled_earnings = @order_items.where(status: 'Cancelled').sum(:price)
  end

  def tally_count
     @total_count = @order_items.where('status = ? OR status = ?', 'Paid', 'Shipped').count
     @pending_count = @order_items.where(status: 'Pending').count
     @paid_count = @order_items.where(status: 'Paid').count
     @shipped_count = @order_items.where(status: 'Shipped').count
     @cancelled_count = @order_items.where(status: 'Cancelled').count
  end

  def render_orderitems
     @order_items = @vendor.orderitems
     render "fulfillment"
  end

  def find_orderitems
   @order_items = @vendor.orderitems
  end

  def find_vendor
    @vendor = Vendor.find_by_id(params[:id])
    render_404 if !@vendor
  end
end
