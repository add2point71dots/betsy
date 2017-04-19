class Product < ApplicationRecord

  belongs_to :user
  belongs_to :order_item
  belongs_to :category
  belongs_to :review


end
