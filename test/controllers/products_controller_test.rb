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



  describe "Logged in users" do
    before do
      login_vendor(vendors(:one))
    end

    it "shoud redirect to full list after adding a product" do

      post products_path params: { product: {name: "unique_name_2", photo_url: 'http://www.dionwir.jpg', price: 5.0, quantity: 4,description: "nice product" ,vendor_id: vendors(:two).id }
    }
    must_redirect_to products_path

    end

    it "should show the new product form" do
      get new_product_path
      must_respond_with :success
    end


    it "shoud affect the model when creating a product " do

      proc {
        post products_path, params: { product: {name: "unique_name", photo_url: 'http://www.dionwired.jpg', price: 5.0, quantity: 4,description: "nice product" ,vendor_id: vendors(:two).id }
        }
      }.must_change 'Product.count', 1

    end

    it "should be able to see product's detail page" do
        get product_path(products(:two).id)
        must_respond_with :success
      end

    it "should be able to edit a product" do
      get edit_product_path(products(:one))
      must_respond_with :success
    end

    it "should be able to update the hidden field " do
      (products(:one)).hidden.must_be_kind_of Boolean
    end






  end
end
