class ChangeVendorUidDataType < ActiveRecord::Migration[5.0]
  def change
    change_column :vendors, :uid, :string
  end
end
