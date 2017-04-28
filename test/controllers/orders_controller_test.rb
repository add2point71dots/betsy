require "test_helper"

describe OrdersController do
  describe "making a new cart" do
    it "should make a new cart" do
      proc {
        post orders_path, params: { order: { order_state: "pending" }}
      }.must_change 'Order.count', 1
    end
  end

  describe "current cart view" do
    it "should show the current cart view" do
      get cart_path
      must_respond_with :success
    end
  end

  describe "order details page" do
    it "should show the order details" do
      get order_path(orders(:two))
      must_respond_with :success
    end

    it "should show a 404 when order is not found" do
      get order_path(0)
      must_respond_with :missing
    end
  end

  describe "order edit(order form) page" do
    it "cannot access edit page when the cart is empty" do
      post orders_path, params: { order: { order_state: "pending" }}
      get edit_order_path(Order.last.id)
      must_respond_with :redirect
      flash[:failure].must_equal "You are trying to checkout with an empty cart"
    end

    it "can access the edit page if the cart is not empty" do
      get edit_order_path(orders(:one).id)
      must_respond_with :redirect
    end
  end

  describe "order update" do

    it "when update is successful it redirects to confirmation page" do
      post orders_path, params: { order: { order_state: "pending" }}

      shopper_data = { order: { order_state: "paid", name: "john", email: "johnbuyer@gmail.com", street_address: "333 third st.", city: "seattle", state: "wasington", zip_code: "12345", name_on_card: "john buyer", card_number: "1212121212121212", exp_month:"12", exp_year:"19", cvv: "123", billing_zip_code: "12345" } }
      patch order_path(orders(:one).id), params: shopper_data
      flash[:success].must_equal "Your order has been placed successfully"
      must_redirect_to confirm_path
    end

    it "when update is unsuccessful due to invalid data, it renders the same edit page " do
      post orders_path, params: { order: { order_state: "pending" }}

      shopper_data = { order: { order_state: "paid", name: "john", email: "johnbuyer@gmail.com", street_address: "333 third st.", city: "seattle", state: "wasington", zip_code: "12345", name_on_card: "john buyer", card_number: nil , exp_month:"12", exp_year:"19", cvv: "123", billing_zip_code: "12345" } }
      patch order_path(orders(:one).id), params: shopper_data
      flash[:failure].must_equal "A problem occurred: Could not place order"
    end
  end

  describe "order confirmation" do
    it "resets session cart once the order is complete" do

      shopper_data = { order: { order_state: "paid", name: "john", email: "johnbuyer@gmail.com", street_address: "333 third st.", city: "seattle", state: "wasington", zip_code: "12345", name_on_card: "john buyer", card_number: "1212121212121212", exp_month:"12", exp_year:"19", cvv: "123", billing_zip_code: "12345" } }

      patch order_path(orders(:one).id), params: shopper_data

      proc {
        get confirm_path
        post orders_path, params: { order: { order_state: "pending" } }
      }.must_change 'Order.count', 1
    end
  end

  describe "reset" do
    it "reset the cart without creating a new cart" do
      get cart_path
      proc {
        patch reset_path(Order.last)
      }.must_change 'Order.count', 0
    end
  end
end
