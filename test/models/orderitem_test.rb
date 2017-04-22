require "test_helper"

describe Orderitem do
  describe "relations" do
    it "has an order" do
      orderitem = orderitems(:one)
      orderitem.must_respond_to :order
      orderitem.order.must_be_kind_of Order
    end

    it "has a product" do
      orderitem = orderitems(:one)
      orderitem.must_respond_to :product
      orderitem.product.must_be_kind_of Product
    end
  end

  describe "validations" do
    it "requires a quantity of 1 or more" do
      orderitem = Orderitem.new(order: orders(:one), product: products(:one), quantity: 2)
      orderitem.valid?.must_equal true

      orderitem = Orderitem.new(order: orders(:one), product: products(:one), quantity: 0)
      orderitem.valid?.must_equal false
      orderitem.errors.messages.must_include :quantity
    end
  end

  describe "custom methods" do
    it "returns true if there's enough products to fulfill the quantity entered" do

    end

    it "returns false if there aren't enough products to fulfill the quantity entered" do

    end
  end
end
