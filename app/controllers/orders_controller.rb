class OrdersController < ApplicationController
  before_action :find_order, only: [:show]

  def index
    @orders = Order.includes(:orderitems).where(orderitems: { order: params[:id]})
  end

  def show;end

  def create
  end

  def edit
  end

  def update
  end

  private

  def find_order
    @order = Order.find_by_id(params[:id])
    render_404 if !@order
  end
end
