class ChangeColumnName < ActiveRecord::Migration[5.0]
  def change
    remove_column :products, :user_id
  end
end
