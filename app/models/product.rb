class Product < ApplicationRecord
  has_and_belongs_to_many :categories
  belongs_to :vendor
  has_many :orderitems
  has_many :reviews


  validates :name, presence: true
  validates :name, uniqueness: true
  validates :price, presence: true
  validates :price, numericality: { greator_than: 0 }
  validates :quantity, presence: true
  validates :quantity, numericality: true
  validates :photo_url, presence: true



  def average_review
    (reviews.average(:rating) || 0).round(1)
  end


end
