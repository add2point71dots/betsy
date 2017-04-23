# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "csv"

CSV.read("support/vendors_seeds.csv", {:headers => true}).each do |data|
  args = {
          :uid => data[1],
          :provider => data[2],
          :email => data[3],
          :username => data[4]
        }
  Vendor.create(args)
end

CSV.read("support/products_seeds.csv", {:headers => true}).each do |data|
  args = {
          :vendor_id => data[1],
          :name => data[2],
          :description => data[3],
          :photo_url => data[4],
          :price => data[5],
          :quantity => data[6]
        }
  Product.create(args)
end

CSV.read("support/reviews_seeds.csv", {:headers => true}).each do |data|
  args = {
          :product_id => data[1],
          :rating => data[2],
          :comment => data[3]
        }
  Review.create(args)
end

CSV.read("support/categories_seeds.csv", {:headers => true}).each do |data|
  args = {
          :label => data[1]
        }
  Category.create(args)
end

CSV.read("support/orders_seeds.csv", {:headers => true}).each do |data|
  args = {
            :name => data[1],
            :email => data[2],
            :street_address => data[3],
            :city => data[4],
            :state => data[5],
            :zip_code => data[6],
            :name_on_card => data[7],
            :card_number => data[8],
            :exp_month => data[9],
            :exp_year => data[10],
            :cvv => data[11],
            :billing_zip_code => data[12],
            :order_state => data[13]
        }
  Order.create(args)
end

CSV.read("support/orderitems_seeds.csv", {:headers => true}).each do |data|
  args = {
          :order_id => data[1],
          :product_id => data[2],
          :quantity => data[3]
        }
  Orderitem.create(args)
end

CSV.read("support/categories_products_seeds.csv", {:headers => true}).each do |data|
  time = DateTime.now
  inserts = [data[1], data[2]].join(", ")

  sql = "INSERT INTO categories_products (category_id, product_id) VALUES (" + inserts + ")"

  ActiveRecord::Base.connection.execute(sql)
end
