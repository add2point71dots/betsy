class Order < ApplicationRecord
  has_many :orderitems
  validates :order_state, presence: true, inclusion: { in: %w(pending paid completed canceled) }
  validates :name, presence: true, length: { minimum: 2, maximum: 70 }, unless: :in_cart?
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, unless: :in_cart?
  validates :street_address, :city, presence: true, unless: :in_cart?
  validates :state, presence: true, unless: :in_cart?
  validates :zip_code, :billing_zip_code, presence: true, format: { with: /\A\d{5}\z/, message: "only allows 5 digit numbers" }, unless: :in_cart?
  validates :name_on_card, presence: true, length: { minimum: 2, maximum: 70 }, unless: :in_cart?
  validates :card_number, presence: true, format: { with: /\A\d{13,19}\z/ }, unless: :in_cart?
  validates :exp_month, :exp_year, presence: true, format: { with: /\A\d{2}\z/ }, unless: :in_cart?
  validates :cvv, presence: true, format: { with: /\A\d{3}\z/ }, unless: :in_cart?

def in_cart?
  order_state == "pending"
end

  def sub_total
    orderitems.inject(0, :+)
  end

  def last_four_digits
    card_number.split(//).last(4).join
  end
end
