require "test_helper"

describe ReviewsController do

  it "should affect the model when creating a review (not logged in)" do
    proc {
      post reviews_path, params: {
        review: { rating: 5, comment: "This is great!", product_id: products(:two).id }
      }
    }.must_change 'Review.count', 1
  end

  it "should redirect to product show after reviewing (not logged in)" do
    post reviews_path params: {
      review: { rating: 3, comment: "It was okay.", product_id: products(:three).id }
    }
    must_redirect_to product_path(products(:three).id)
  end

  it "should not affect the model when vendor tries to review their own product" do
    #figure out how to mimic logging in
  end
end
