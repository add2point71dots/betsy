class Order < ApplicationRecord
  has_many :orderitems
  validates :name, presence: true, length: { minimum: 2, maximum: 70 }
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :street_address, :city, presence: true
  validates :state, presence: true
  validates :zip_code, :billing_zip_code, presence: true, format: { with: /\A\d{5}\z/, message: "only allows 5 digit numbers" }
  validates :name_on_card, presence: true, length: { minimum: 2, maximum: 70 }
  validates :card_number, presence: true, format: { with: /\A\d{13,19}\z/ }
  validates :exp_month, :exp_year, presence: true, format: { with: /\A\d{2}\z/ }
  validates :cvv, presence: true, format: { with: /\A\d{3}\z/ }
end
