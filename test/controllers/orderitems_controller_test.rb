require "test_helper"

describe OrderitemsController do
  it "Should increase the quantity" do
    proc {
      patch increase_path(orderitems(:one).id), params: { orderitem: {order_id: orders(:one).id, product_id: products(:one).id , quantity: '1', status: "Pending"}
      }
    }.must_change 'Orderitem.find(orderitems(:one).id).quantity', 1
  end

  # it "Should not add to cart if the quantity > available stock" do
  #   proc {
  #     patch increase_path(orderitems(:one).id), params: { orderitem: {order_id: orders(:one).id, product_id: products(:one).id , quantity: '3', status: "Pending"}
  #     }
  #   }.must_change 'Orderitem.find(orderitems(:one).id).quantity', 3
  #
  #   flash[:error].must_equal "Oops. Don't be greedy."
  #   must_redirect_to cart_path
  # end







end
