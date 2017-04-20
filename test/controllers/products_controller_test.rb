require "test_helper"

describe ProductsController do
  it "should get index" do
    get products_index_url
    value(response).must_be :success?
  end

end
