class OrderitemsController < ApplicationController
  before_action :find_orderitem, only: [:show, :cancel, :ship, :increase, :decrease]
  before_action :current_cart, only: [:create]
  before_action :last_page, only: [:create]

  # application controller method 'current_cart' is excecuted prior to entering action to retreive @cart
  def create
    # the item quanity entered by shopper is validated first
    quantity = params[:orderitem][:quantity].to_i
    product = Product.find_by_id(params[:orderitem][:product_id].to_i)
    # product is out of stock
    if product.quantity == 0
      flash[:failure] =  "This item is sold out"
      redirect_to product_path(product.id)
      return
      # the quantity specified by the shopper is greater than the current inventory
    elsif quantity - product.quantity > 0
      flash[:failure] =  "Quantity too large: only #{product.quantity} left in stock!"
      redirect_to product_path(product.id)
      return
      # shopper attemps to add a new item to a cart without specifying quantity
    elsif quantity == 0
      flash[:failure] =  "You must add at least 1 item to the cart"
      redirect_to product_path(product.id)
      return
    end
    # if the prduct has already been added to the cart, then store the current inventory of that product into item_quantity
    if @cart.orderitems.find_by(product_id: params[:orderitem][:product_id])
      item_quantity = @cart.orderitems.find_by(product_id: params[:orderitem][:product_id]).quantity
    else
      item_quantity = 0
    end
    # order model method 'add_to_cart' is excecuted using @cart and the params passed in -- 'add_to_cart' will prevent creating a duplicate orderitems in the cart for the same product, instead it updated the quantity of that item.
    @cart.add_to_cart(params)
    # because the logic that does -- 1) the secondary validation on quantity( which checks against quantity of the product currently in cart) and 2) create or update orderitem -- is inside the order model method 'add_to_cart', we do a
    if product.quantity >= item_quantity + params[:orderitem][:quantity].to_i
      flash[:success] = "Item has been added to your cart"
      redirect_to cart_path
      return
    else
      flash[:failure] = "Oops! Something went wrong and we couldn't add this item to your cart"
      redirect_to product_path(product.id)
    end
  end


     def increase
          increased_quantity = @orderitem.quantity + 1
          if  increased_quantity <= @orderitem.product.quantity
          @orderitem.quantity += 1
               flash[:success] = "Added! Only #{@orderitem.product.quantity - @orderitem.quantity} remaining."
          else
               flash[:error] = "Oops. Don't be greedy."
          end
          @orderitem.save
          redirect_to cart_path
     end

     def decrease
          decreased_quantity = @orderitem.quantity - 1
          if  decreased_quantity <= 0
               flash[:error] = "You would be better off hitting the delete button."
          else
               @orderitem.quantity -= 1
               flash[:success] = "Removed! #{@orderitem.product.quantity - @orderitem.quantity} remaining."
          end
          @orderitem.save
          redirect_to cart_path
     end

     def cancel
          @orderitem.status = "Cancelled"
          @orderitem.save
          flash[:success] = "You have successfully scrapped this item."
          redirect_to fulfillment_path(@orderitem.product.vendor_id)
     end

     def ship
          @orderitem.status = "Shipped"
          @orderitem.save
          flash[:success] = "You have successfully shipped this item."
          redirect_to fulfillment_path(@orderitem.product.vendor_id)
     end

       def destroy
              orderitem = Orderitem.find_by_id(params[:id])
              orderitem.destroy
              redirect_to cart_path
       end

private

     def find_orderitem
          @orderitem = Orderitem.find_by_id(params[:id])
          render_404 if !@orderitem
     end

     def orderitem_params
          params.require(:orderitem).permit( :order_id, :product_id, :quantity, :status)
     end

     def last_page
          session[:last_page] = request.env['HTTP_REFERER']
     end

end
