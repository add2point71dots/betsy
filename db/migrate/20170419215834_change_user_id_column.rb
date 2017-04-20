class ChangeUserIdColumn < ActiveRecord::Migration[5.0]
  def change
    rename_column :products, :user_id, :vendor_id
  end
end
