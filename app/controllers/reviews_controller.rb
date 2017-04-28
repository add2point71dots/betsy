class ReviewsController < ApplicationController
  def create
    @product = Product.find_by(id: params[:review][:product_id])

    if current_vendor && owner?
      flash[:error] = "You cannot review your own product."
      redirect_to product_path(@product.id)
    else
      @review = Review.create(review_params)

      unless @review.id == nil
        flash[:success] = "Review added!"
        redirect_to product_path(@product.id)
      else
        flash[:error] = "A problem occurred: Could not create review."
        redirect_to product_path(@product.id)
      end
    end
  end

  private

  def owner?
    return session[:vendor_id] == @product.vendor.id ? true : false
  end

  def review_params
    params.require(:review).permit(:rating, :comment, :product_id)
  end
end
