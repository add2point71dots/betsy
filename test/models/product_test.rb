require "test_helper"

describe Product do
  # let(:product) { Product.new }

  describe "validations" do

    it "can create a product with valid name, price and quantity" do
      # product = Product.new(name: "blender", price: 99.9, quantity: 2)
      product = products(:blue1)
       product.valid?.must_equal true
    end

    it "can't create a product without a valid name" do
      product = Product.new(name: "", price: 99.9, quantity: 2)
      product.valid?.must_equal false
      product.errors.messages.must_include :name

    end

    it "product name should be unique" do
      product_1= products(:blue1)
      product_2 = Product.new(name: "blender", price: 99.9, quantity: 2)
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

    it "belongs to user" do

    end

    it "has_many orderitems " do

    end

    it "has_many itemcategories " do

    end

    it "has_many reviews " do

    end
  end

end
