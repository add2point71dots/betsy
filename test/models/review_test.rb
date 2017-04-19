require "test_helper"

describe Review do
  let(:review) { Review.new }

  describe "validations" do
    it "requires a rating rating" do
      review = Review.new(comment: "woo")
      review.valid?.must_equal false
      review.errors.messages.must_include :rating
    end

    it "rating must be between 1 and 5" do
      review1 = Review.new(rating: 0)
      review1.valid?.must_equal false
      review1.errors.messages.must_include :rating

      review2 = Review.new(rating: 6)
      review2.valid?.must_equal false
      review2.errors.messages.must_include :rating
    end
  end

  describe "relationships" do
    #write relationship tests here
  end
end
