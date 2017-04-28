require "test_helper"
# require "simplecov"

describe Product do

  describe "validations" do

    it "can create a product with valid name, price and quantity" do

      product = products(:one)
      product.valid?.must_equal true
    end

    it "can't create a product without a valid name" do
      product = Product.new(name: "", price: 99.9, quantity: 2)
      product.valid?.must_equal false
      product.errors.messages.must_include :name
    end

    it "product name should be unique" do
      product_2 = Product.new(name: "scarf", price: 99.9, quantity: 2)
      product_2.valid?.must_equal false
    end

    it "can't create a product without a valid price" do
      product_2 = Product.new(name: "blender", price: nil, quantity: 2)
      product_2.valid?.must_equal false
    end

    it "price should be integer " do
      product_2 = Product.new(name: "blender", price: "fourty five", quantity: 2)
      product_2.valid?.must_equal false
    end

    it "can't create a product with price = 0" do
        product_2 = Product.new(name: "blender", price: 0, quantity: 2)
        product_2.valid?.must_equal false
      end

    it "can't create a product without quantity" do
      product_2 = Product.new(name: "blender", price: 14.99, quantity: nil)
      product_2.valid?.must_equal false
    end

    it "quantity should be integer" do
      #products(:blue4).valid?.must_equal false
      product_2 = Product.new(name: "hat", price: 14.99, quantity: "four")
      product_2.valid?.must_equal false
      product_2.errors.messages.must_include :quantity
    end
  end

  describe "relationships" do

    it "belongs to vendor" do
      product = products(:one)
      product.vendor.must_be_kind_of Vendor
    end

    it "has a list of orderitems " do
      one = products(:one)
      one.must_respond_to :orderitems

      one.orderitems.each do |orderitem|
        orderitem.must_be_kind_of Orderitem
      end
    end

    it "has a list of categories " do
      two = products(:two)
      two.must_respond_to :categories

      two.categories.each do |category|
        category.must_be_kind_of Category
      end
    end

    it "has a list of reviews " do
      three = products(:three)
      three.must_respond_to :reviews

      three.reviews.each do |review|
        review.must_be_kind_of Review
      end
    end
  end

  describe "custom method" do

    it "returns average rating for a specific product" do
      product = products(:one)
      product.average_review.must_equal 4.5
    end
  end
end
