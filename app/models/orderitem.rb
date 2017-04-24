class Orderitem < ApplicationRecord
  belongs_to :order
  belongs_to :product
  validates :quantity, presence: true, numericality: {  only_integer: true, greater_than: 0 }
  validate :valid_quantity, on: :create
  validate :valid_quantity, on: :update


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
