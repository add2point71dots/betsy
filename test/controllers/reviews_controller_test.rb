require "test_helper"

describe ReviewsController do

  it "should affect the model when creating a review (not logged in)" do
    proc {
      post reviews_path, params: {
        review: { rating: 5, comment: "This is great!", product_id: products(:two).id }
      }
    }.must_change 'Review.count', 1
    flash[:success].must_equal "Review added!"
  end

  it "should redirect to product show after reviewing (not logged in)" do
    post reviews_path params: {
      review: { rating: 3, comment: "It was okay.", product_id: products(:three).id }
    }
    must_redirect_to product_path(products(:three).id)
    flash[:success].must_equal "Review added!"
  end

  it "logged in vendor cannot review their own product" do
    login_vendor(vendors(:one))
    proc {
      post reviews_path, params: {
        review: { rating: 5, comment: "This is great!", product_id: products(:four).id }
      }
    }.must_change 'Review.count', 0

    flash[:error].must_equal "You cannot review your own product."
    must_redirect_to product_path(products(:four).id)
  end

  it "logged in vendor can review products they don't own" do
    login_vendor(vendors(:one))
    proc {
      post reviews_path, params: {
        review: { rating: 5, comment: "This is great!", product_id: products(:two).id }
      }
    }.must_change 'Review.count', 1

    flash[:success].must_equal "Review added!"
    must_redirect_to product_path(products(:two).id)
  end

  it "cannot create review with bad data" do
    proc {
      post reviews_path, params: {
        review: { comment: "This is great!", product_id: products(:four).id }
      }
    }.must_change 'Review.count', 0

    flash[:error].must_equal "A problem occurred: Could not create review."
    must_redirect_to product_path(products(:four).id)
  end
end
