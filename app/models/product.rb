class Product < ApplicationRecord

  belongs_to :user
  has_many :orderitems, :itemcategories, :reviews


  validates :name, presence: true, uniqueness: true
  validates :price, presence: true
  #validates :quantity, presence: true






end
