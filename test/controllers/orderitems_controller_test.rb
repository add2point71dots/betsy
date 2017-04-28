require "test_helper"

describe OrderitemsController do
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
