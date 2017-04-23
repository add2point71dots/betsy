class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      # shipping information
      t.string :name
      t.string :email
      t.string :street_address
      t.string :city
      t.string :state
      t.string :zip_code

      # billing information
      t.string :name_on_card
      t.string :card_number
      t.string :exp_month
      t.string :exp_year
      t.string :cvv
      t.string :billing_zip_code
      t.string :order_state
      
      t.timestamps
    end
  end
end
