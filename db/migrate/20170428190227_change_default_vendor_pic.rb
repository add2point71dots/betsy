class ChangeDefaultVendorPic < ActiveRecord::Migration[5.0]
  def change
    change_column :vendors, :photo_url, :string, default: "http://icons.iconarchive.com/icons/custom-icon-design/flatastic-4/512/User-blue-icon.png"
  end
end
