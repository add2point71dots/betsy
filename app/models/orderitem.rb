class Orderitem < ApplicationRecord
  belongs_to :order
  belongs_to :product
  validates :order_state, presence: true, inclusion: { in: %w(pending paid completed canceled) }
  validates :quantity, presence: true, numericality: {  only_integer: true, greater_than: 0 }
end
