class AddColumnsToOrderItem < ActiveRecord::Migration[5.0]
  def change
    def change
      # shipping information
      add_column :orderitems, :quantity, :integer
      add_column :orderitems, :order_state, :string
    end
  end
end
