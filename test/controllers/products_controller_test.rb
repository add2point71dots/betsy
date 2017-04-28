require "test_helper"

describe ProductsController do

  it "Should get index" do
    get products_path
    must_respond_with :success
  end

  it "Should get products by category" do
    get category_products_path(categories(:one).id)
    must_respond_with :success
  end

  it "should get show " do
    get product_path(products(:two).id)
    must_respond_with :success
  end

  it "logged in vendor can update their own products" do
    first_vendor = Vendor.first
    first_product = Product.first
    login_vendor(first_vendor)
    new_data = { product: { quantity: 199}}
    patch product_path(first_product.id), params: new_data

    Product.first.quantity.must_equal new_data[:product][:quantity]
    flash[:success].must_equal "Successfully updated your product"
  end

  it "doesn't update if vendor not logged in & redirects to root" do
    first_product = Product.first

    new_data = { product: { quantity: 77} }
    patch product_path(first_product.id), params: new_data

    must_redirect_to root_path
    Product.first.quantity.must_equal 0
    flash[:error].must_equal "You must be logged in to view this page."
  end

  it "logged in vendor can't update other vendor's product" do
    first_vendor = Vendor.first
    last_product = Product.last
    login_vendor(first_vendor)
    new_data = { product: { quantity: 2000}}
    patch product_path(last_product.id), params: new_data

    Product.last.quantity.must_equal 10
    flash[:error].must_equal "You don't have access to other vendor's products"
    must_redirect_to root_path
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

      post products_path params: { product: {name: "unique_name_2", photo_url: 'http://www.dionwir.jpg', price: 5.0, quantity: 4,description: "nice product" ,vendor_id: vendors(:one).id}
    }
      must_redirect_to root_path
      flash[:success].must_equal "New product added"
    end

    it "should show the new product form" do
      get new_product_path
      must_respond_with :success
    end

    it "shoud affect the model when creating a product " do

      proc {
        post products_path, params: { product: {name: "unique_name", photo_url: 'http://www.dionwired.jpg', price: 5.0, quantity: 4,description: "nice product" ,vendor_id: vendors(:one).id }
        }
      }.must_change 'Product.count', 1
    end

    it "should show flash message when new product was not added " do
      proc {
        post products_path, params: { product: {name: "unique_name", photo_url: 'http://www.dionwired.jpg', quantity: 4,description: "nice product" ,vendor_id: vendors(:one).id }
        }
      }.must_change 'Product.count', 0

      flash[:error].must_equal "Failed to add product"
    end


    it "should be able to edit a product" do
      get edit_product_path(products(:one))
      must_respond_with :success
    end


    it "should not be able to edit other vendor's product" do
    # logged in vendor doesn't own product two
      get edit_product_path(products(:two))
      must_respond_with :redirect
      must_redirect_to root_path
      flash[:error] = "You don't have access to other vendor's products"
    end
  end

  describe "not logged in user" do
     it "can not edit a product" do

       get edit_product_path(products(:two).id)
       must_respond_with :redirect
       must_redirect_to root_path
       flash[:error].must_equal "You must be logged in to view this page."
     end

     it "can not create a product" do

       get new_product_path(products(:two).id)
       must_respond_with :redirect
       must_redirect_to root_path
       flash[:error].must_equal "You must be logged in to view this page."
     end

     it "can't update a product" do
       patch product_path(products(:two).id)
       flash[:error].must_equal "You must be logged in to view this page."
     end
  end

  describe "custom method" do

    it "returns average rating for a specific product" do
      product = products(:one)
      product.average_review.must_equal 4.5
    end
  end
end
