class Vendor < ApplicationRecord
  has_many :products
  has_many :orderitems, through: :products

  validates :username, uniqueness: true, presence: true
  validates :provider, presence: true
  validates :uid, presence: true
  validates :email, uniqueness: true, presence: true
end

def revenues
     order_items = vendor.orderitems.map { | orderitem | orderitem.product}

     earnings = order_items.price.inject(0) { | sum, price | sum + price }
end
