class Orderitem < ApplicationRecord
  belongs_to :order
  belongs_to :product
  validates :quantity, presence: true, valid_quantity: true, numericality: {  only_integer: true, greater_than: 0 }
  validates :valid_quantity, on: :create
  validates :valid_quantity, on: :update


  # checks the availability in the product inventory
  def valid_quantity
    unfufilled_quantity = quantity - product.quantity
    if product.quantity == 0
      errors.add(:quantity, "This item is sold out")
    elsif unfufilled_quantity > 0
      errors.add(:quantity, "Quantity too large: only #{product.quantity} left in stock!")
    end
  end
end
