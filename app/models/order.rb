class Order < ApplicationRecord
  has_many :orderitems, dependent: :destroy
  validates :order_state, presence: true, inclusion: { in: %w(pending paid) }
  validates :name, presence: true, length: { minimum: 2, maximum: 70 }, unless: :in_cart?
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, unless: :in_cart?
  validates :street_address, :city, presence: true, unless: :in_cart?
  validates :state, presence: true, unless: :in_cart?
  validates :zip_code, :billing_zip_code, presence: true, format: { with: /\A\d{5}\z/, message: "only allows 5 digit numbers" }, unless: :in_cart?
  validates :name_on_card, presence: true, length: { minimum: 2, maximum: 70 }, unless: :in_cart?
  validates :card_number, presence: true, format: { with: /\A\d{13,19}\z/ }, unless: :in_cart?
  validates :exp_month, :exp_year, presence: true, format: { with: /\A\d{2}\z/ }, unless: :in_cart?
  validates :cvv, presence: true, format: { with: /\A\d{3}\z/ }, unless: :in_cart?

  def in_cart?
    order_state == "pending"
  end

  def add_to_cart(product_params)
    current_orderitem = orderitems.find_by(product_id: product_params[:orderitem][:product_id].to_i)

    # already existing orderitem
    if current_orderitem && current_orderitem.quantity + (product_params[:orderitem][:quantity].to_i) <= Product.find_by_id(product_params[:orderitem][:product_id].to_i).quantity
      current_orderitem.quantity += product_params[:orderitem][:quantity].to_i
      current_orderitem.save!

      # non existing orderitem
    elsif !current_orderitem
      new_orderitem = Orderitem.create!(product_id: product_params[:orderitem][:product_id], quantity: product_params[:orderitem][:quantity].to_i, order_id: self.id, status: "Pending")
      new_orderitem.save!
    end
  end

  def update_orderitem_status
    orderitems.each do | orderitem |
      orderitem.update(status: "Paid")
      orderitem.save!
    end
  end

  def update_product_stock
    orderitems.each do |orderitem|
      orderitem.product.update(quantity: orderitem.product.quantity - orderitem.quantity)
      orderitem.save!
    end
  end

  def total
    total = 0
    orderitems.each do |orderitem|
      product = Product.find_by_id(orderitem.product_id)
      total += product.price * orderitem.quantity
    end
    return total
  end
end
