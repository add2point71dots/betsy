class AddColumnsToOrderItem < ActiveRecord::Migration[5.0]
  def change
    add_column :orderitems, :quantity, :integer
    add_column :orderitems, :order_state, :string
  end
end
