require "test_helper"

describe Orderitem do
  describe "relations" do
    it "has an order" do
      v = orderitems(:one)
      v.must_respond_to :order
      v.user.must_be_kind_of Order
    end

    # it "has a product" do skip
    #   v = orderitems(:one)
    #   v.must_respond_to :product
    #   v.user.must_be_kind_of Product
    # end
  end

  describe "validations" do
    it "allows the four order_states" do
      valid_states = ['pending', 'paid', 'completed', 'canceled']
      valid_states.each do |state|
        orderitem = Orderitem.new(order_id: orders(:one).id, order_state: state)
        orderitem.valid?.must_equal true
      end
    end

    it "rejects invalid order_state" do
      invalid_states = ['lost', 'shipped', 'backordered', 'banana']
      invalid_states.each do |invalid_state|
        orderitem = Orderitem.new(order_id: orders(:one).id, order_state: invalid_state)
        orderitem.valid?.must_equal false
        orderitem.errors.messages.must_include :order_state
      end
    end

    it "requires a quantity of 1 or more" do
      orderitem = Orderitem.new(order: orders(:one), order_state: 'completed', quantity: 2)
      orderitem.valid?.must_equal true

      orderitem = Orderitem.new(order: orders(:one), order_state: 'completed', quantity: 0)
      orderitem.valid?.must_equal false
      orderitem.errors.messages.must_include :quantity
    end
  end
end
