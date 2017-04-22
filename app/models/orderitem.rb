class Orderitem < ApplicationRecord
  belongs_to :order
  belongs_to :product
  
  validates :quantity, presence: true, numericality: {  only_integer: true, greater_than: 0 }

  # check if quantity is availale
  def valid_quantity?
    fufilled_quantity = product.quantity - quantity
    return fufilled_quantity >= 0
  end
end
