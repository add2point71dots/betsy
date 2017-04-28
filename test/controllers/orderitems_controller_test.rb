require "test_helper"

describe OrderitemsController do

  it "should create an orderitem" do
    proc {
      post orderitems_path, params: { orderitem: {quantity: 1, product_id: products(:one).id}
      }
    }.must_change "Orderitem.count", 1
  end

  it "should not create orderitem when product quantity = 0" do

    proc {
      post orderitems_path, params: { orderitem: {quantity: 1, product_id: products(:three).id}
      }
    }.must_change  "Orderitem.count", 0

    must_redirect_to product_path(products(:three).id)

    flash[:failure].must_equal "This item is sold out"
  end

  it "should not create orderitem when product quantity = 0" do

    proc {
      post orderitems_path, params: { orderitem: {quantity: 1, product_id: products(:three).id}
      }
    }.must_change  "Orderitem.count", 0

    must_redirect_to product_path(products(:three).id)

    flash[:failure].must_equal "This item is sold out"
  end

  it "should not create orderitem when quantity > product quantity in stock" do

    proc {
      post orderitems_path, params: { orderitem: {quantity: 100, product_id: products(:one).id}
      }
    }.must_change  "Orderitem.count", 0

    must_redirect_to product_path(products(:one).id)

    flash[:failure].must_equal "Quantity too large: only #{products(:one).quantity} left in stock!"
  end

  it "should not create orderitem when order quantity = 0" do

    proc {
      post orderitems_path, params: { orderitem: {quantity: 0, product_id: products(:one).id}
      }
    }.must_change  "Orderitem.count", 0

    must_redirect_to product_path(products(:one).id)

    flash[:failure].must_equal "You must add at least 1 item to the cart"
  end

  it "Should increase the quantity" do
    proc {
      patch increase_path(orderitems(:one).id), params: { orderitem: {order_id: orders(:one).id, product_id: products(:one).id , quantity: '1', status: "Pending"}
      }
    }.must_change 'Orderitem.find(orderitems(:one).id).quantity', 1
  end

  it "Should not add to cart if the quantity > available stock" do
    proc {
      9.times do |i|
        patch increase_path(orderitems(:one).id), params: { orderitem: {order_id: orders(:one).id, product_id: products(:one).id , quantity: '3', status: "Pending"}
      }
  end

  }.must_change 'Orderitem.find(orderitems(:one).id).quantity', 8

    flash[:error].must_equal "Oops. Don't be greedy."
    must_redirect_to cart_path
  end

  it "Should decrease the quantity" do
    proc {
        patch decrease_path(orderitems(:one).id), params: { orderitem: {order_id: orders(:one).id, product_id: products(:one).id , quantity: '2', status: "Pending"}
      }

  }.must_change 'Orderitem.find(orderitems(:one).id).quantity', (-1)
  end

  it "should be able to cancel" do
    patch cancel_path(orderitems(:one).id)
     Orderitem.find(orderitems(:one).id).status.must_equal "Cancelled"
  end

  it "should be able to ship" do
    patch ship_path(orderitems(:one).id)
    Orderitem.find(orderitems(:one).id).status.must_equal "Shipped"
    must_redirect_to fulfillment_path(orderitems(:one).product.vendor_id)
  end

  it "should be able to destroy" do
    delete orderitem_path(orderitems(:one).id)
    must_redirect_to cart_path
  end
end
