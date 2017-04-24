class Vendor < ApplicationRecord
  has_many :products
  has_many :orderitems, through: :products
  
  validates :username, uniqueness: true, presence: true
  validates :provider, presence: true
  validates :uid, presence: true
  validates :email, uniqueness: true, presence: true
end
