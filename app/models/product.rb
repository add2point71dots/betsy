class Product < ApplicationRecord
     has_and_belongs_to_many :categories
  # belongs_to :user
  # has_many :orderitems, :itemcategories, :reviews


  validates :name, presence: true
  validates :name, uniqueness: true
  validates :price, presence: true
  validates :price, numericality: { greator_than: 0 }
  validates :quantity, presence: true
  validates :quantity, numericality: true







end
