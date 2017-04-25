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
    post products_path params: { product: {name: "unique_name_2", photo_url: 'http://www.dionwired.co.za/media/catalog/product/cache/1/thumbnail/14f6260e656af55ad0e5dd0aab46f1ea/5/9/599475.jpg', price: 5.0, quantity: 4,description: "nice product" ,vendor_id: vendors(:two).id }
  }
  must_redirect_to products_path

  end

  it "shoud affect the model when creating a product (not logged in)" do

    proc {
      post products_path, params: { product: {name: "unique_name", photo_url: 'http://www.dionwired.co.za/media/catalog/product/cache/1/thumbnail/14f6260e656af55ad0e5dd0aab46f1ea/5/9/599475.jpg', price: 5.0, quantity: 4,description: "nice product" ,vendor_id: vendors(:two).id }
      }
    }.must_change 'Product.count', 1

  end

  it "Check the new form"do

  end

end
