class AddColsToVendors < ActiveRecord::Migration[5.0]
  def change
    add_column :vendors, :photo_url, :string, default: "https://openclipart.org/download/250353/icon_user_whiteongrey.svg"
    add_column :vendors, :name, :string
    add_column :vendors, :description, :text
  end
end
