class Vendor < ApplicationRecord
  has_many :products
  validates :username, uniqueness: true, presence: true
  validates :provider, presence: true
  validates :uid, presence: true
  validates :email, uniqueness: true, presence: true
end
