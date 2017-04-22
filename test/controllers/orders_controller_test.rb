require "test_helper"

describe OrdersController do
  it "should get index" do
    get orders_path
    must_respond_with :success
  end

  it "should get show" do
    get order_path(orders(:one))
    must_respond_with :success
  end

  it "should show a 404 when order not found" do
    get order_path(Order.last.id + 1)
    must_respond_with :missing
  end
end
