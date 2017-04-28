require "test_helper"

describe Orderitem do
  let(:orderitem_no_status) { Orderitem.new(order_id: orders(:one).id, product_id: products(:one).id, quantity: 2)}

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
    it "can create an order item of quantity of 1 or more" do
      orderitem = Orderitem.new(order: orders(:one), product: products(:one), quantity: 2)
      orderitem.valid?.must_equal true
    end

    it "can't create an order item of quantity less than 1" do

      orderitem = Orderitem.new(order: orders(:one), product: products(:one), quantity: 0)
      orderitem.valid?.must_equal false
      orderitem.errors.messages.must_include :quantity
    end

    it "can create orderitems of status ['Pending', 'Paid', 'Shipped', 'Cancelled'] " do

      valid_status = ['Pending', 'Paid', 'Shipped', 'Cancelled']
      valid_status.each do |status|
        orderitem_no_status.status = status
        orderitem_no_status.valid?.must_equal true
      end
    end
  end
end
