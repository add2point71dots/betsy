class AddColumnsToOrder < ActiveRecord::Migration[5.0]
  def change
    # shipping information
    add_column :orders, :name, :string
    add_column :orders, :email, :string
    add_column :orders, :street_address, :string
    add_column :orders, :city, :string
    add_column :orders, :state, :string
    add_column :orders, :zip_code, :string

    # billing information
    add_column :orders, :name_on_card, :string
    add_column :orders, :card_number, :string
    add_column :orders, :exp_month, :string
    add_column :orders, :exp_year, :string
    add_column :orders, :cvv, :string
    add_column :orders, :billing_zip_code, :string
  end
end
