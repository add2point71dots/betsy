require "test_helper"

describe ProductsController do

  it "Should get index" do
    get products_path
    must_respond_with :success
  end

  it "should get show " do
    get product_path(products(:two).id)
    must_respond_with :success
  end

  it "should show a 404 when product is not found" do
    get product_path(0)
    must_respond_with :missing
  end

  it "shoud redirect to full list after adding a product" do
  end

  it "shoud affect the model when creating a product" do
  end



end
