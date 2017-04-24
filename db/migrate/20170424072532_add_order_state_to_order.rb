class AddOrderStateToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :order_state, :string
  end
end
