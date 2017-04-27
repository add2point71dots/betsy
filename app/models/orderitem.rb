class Orderitem < ApplicationRecord
  belongs_to :order
  belongs_to :product
  validates :quantity, presence: true, numericality: {  only_integer: true, greater_than: 0 }
  validates_inclusion_of :status, :in => ['Pending', 'Paid', 'Shipped', 'Cancelled'], :allow_nil => true
end
