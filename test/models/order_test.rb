require "test_helper"

describe Order do
  let(:order) { Order.new(order_state: "paid", name: "john", email: "johnbuyer@gmail.com", street_address: "333 third st.", city: "seattle", state: "wasington", zip_code: "12345", name_on_card: "john buyer", card_number: "1212121212121212", exp_month:"12", exp_year:"19", cvv: "123", billing_zip_code: "12345") }

  let(:order_no_state) { Order.new(name: "john", email: "johnbuyer@gmail.com", street_address: "333 third st.", city: "seattle", state: "wasington", zip_code: "12345", name_on_card: "john buyer", card_number: "1212121212121212", exp_month:"12", exp_year:"19", cvv: "123", billing_zip_code: "12345") }

  describe "relations" do
    it "has at least one orderitem" do
      order = orders(:one)
      order.must_respond_to :orderitems
      order.orderitems.count.must_be :>, 0
    end

    it "has a list of orderitems" do
      order = orders(:one)
      order.orderitems[0].must_be_instance_of Orderitem
      order.orderitems[-1].must_be_instance_of Orderitem
    end
  end

  describe "validations" do
    it "requires an orderstate" do
      order_no_state.valid?.must_equal false
      order_no_state.errors.messages.must_include :order_state
    end

    it "requires a name" do
      order.name = nil
      order.valid?.must_equal false
      order.errors.messages.must_include :name
    end

    it "requires an email" do
      order.email = nil
      order.valid?.must_equal false
      order.errors.messages.must_include :email
    end

    it "requires a street address" do
      order.street_address = nil
      order.valid?.must_equal false
      order.errors.messages.must_include :street_address
    end

    it "requires a city" do
      order.city = nil
      order.valid?.must_equal false
      order.errors.messages.must_include :city
    end

    it "requires a state" do
      order.state = nil
      order.valid?.must_equal false
      order.errors.messages.must_include :state
    end
    it "requires a zipcode" do
      order.zip_code = nil
      order.valid?.must_equal false
      order.errors.messages.must_include :zip_code
    end

    it "requires a name on card for billing" do
      order.name_on_card = nil
      order.valid?.must_equal false
      order.errors.messages.must_include :name_on_card
    end

    it "requires a credit card number" do
      order.card_number = nil
      order.valid?.must_equal false
      order.errors.messages.must_include :card_number
    end

    it "requires expiration month" do
      order.exp_month = nil
      order.valid?.must_equal false
      order.errors.messages.must_include :exp_month
    end

    it "requires expiration year" do
      order.exp_year = nil
      order.valid?.must_equal false
      order.errors.messages.must_include :exp_year
    end

    it "requires cvv" do
      order.cvv = nil
      order.valid?.must_equal false
      order.errors.messages.must_include :cvv
    end

    it "allows only predefined order_states" do
      valid_states = ['pending', 'paid', 'completed', 'canceled']
      valid_states.each do |state|
        order_no_state.order_state = state
        order_no_state.valid?.must_equal true
      end
    end

    it "rejects invalid order_state" do
      invalid_states = ['lost', 'shipped', 'backordered', 'banana']
      invalid_states.each do |invalid_state|
        order_no_state.order_state = invalid_state
        order_no_state.valid?.must_equal false
        order_no_state.errors.messages.must_include :order_state
      end
    end
  end

  describe "custom methods" do
    it "allow NIL values for all other fields, given order_state is pending/in-cart" do
      cart_order = Order.new(order_state: "pending")
      cart_order.valid?.must_equal true
    end

    it "won't allow NIL values for any fields, given order_state is not pending" do
      cart_order = Order.new(order_state: "paid")
      cart_order.valid?.must_equal false

      cart_order = Order.new(order_state: "completed")
      cart_order.valid?.must_equal false

      cart_order = Order.new(order_state: "canceled")
      cart_order.valid?.must_equal false
    end
  end
end
