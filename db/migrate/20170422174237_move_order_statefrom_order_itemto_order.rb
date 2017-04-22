class MoveOrderStatefromOrderItemtoOrder < ActiveRecord::Migration[5.0]
  def change
    remove_column :orderitems, :order_state
    add_column :orders, :order_state, :string
  end
end
