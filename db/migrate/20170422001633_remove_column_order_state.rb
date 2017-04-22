class RemoveColumnOrderState < ActiveRecord::Migration[5.0]
  def change
    remove_column :orderitems, :order_state
  end
end
