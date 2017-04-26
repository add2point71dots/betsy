class Vendor < ApplicationRecord
  has_many :products
  has_many :orderitems, through: :products

  validates :username, uniqueness: true, presence: true
  validates :provider, presence: true
  validates :uid, presence: true
  validates :photo_url, presence: true
  validates :email, uniqueness: true, presence: true

  def self.create_from_google(auth_hash)
    vendor = Vendor.new
    vendor.uid = auth_hash["uid"]
    vendor.provider = auth_hash["provider"]
    vendor.email = auth_hash["info"]["email"]
    vendor.name = auth_hash["info"]["name"]
    vendor.username = auth_hash["info"]["email"]

    vendor.save ? vendor : nil
  end
end
