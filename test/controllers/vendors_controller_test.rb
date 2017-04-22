require "test_helper"

describe VendorsController do
  it "should get index" do
    get vendors_path
    must_respond_with :success
  end

  it "should show one vendor" do
    get vendor_path(vendors(:one))
    must_respond_with :success
  end

  it "should show a 404 when vendor not found" do
    get vendor_path(1)
    must_respond_with :missing
  end
end
