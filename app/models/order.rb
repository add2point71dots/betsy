class Order < ApplicationRecord
  has_many :orderitems
  validates :name, presence: true
  validates :email, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true
  validates :name_on_card, presence: true
  validates :card_number, presence: true
  validates :exp_month, presence: true
  validates :exp_year, presence: true
  validates :cvv, presence: true
  validates :billing_zip_code, presence: true
end
