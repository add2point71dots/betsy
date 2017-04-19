require "test_helper"

describe Product do
  let(:product) { Product.new }

  describe "validation" do
    it "must be valid" do
      value(product).must_be :valid?
    end

    it "Can create a product with valid name, price and quantity" do

    end

    it "Can't create a product without a valid name" do
    end

    it "Product name should be unique" do
    end


    it "Can't create a product without a valid price" do

    end

    it "Price should be integer " do

    end

    it "Can't create a product with price = 0" do

    end

    it "Quantity should be integer" do

    end
  end


  
end
