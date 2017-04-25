class ReviewsController < ApplicationController
  def create

  end

  private

  def not_owner?
    if session[:vendor_id]
      errors[:product] << "You cannot rate a product you own."
      return false
    end
  end
end
