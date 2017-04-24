require "test_helper"

describe OrderitemsController do
  it "should get show" do
    get orderitem_path(orderitems(:one))
    must_respond_with :success
  end

  it "should show a 404 when order not found" do
    get orderitem_path(Orderitem.last.id + 1)
    must_respond_with :missing
  end
end
