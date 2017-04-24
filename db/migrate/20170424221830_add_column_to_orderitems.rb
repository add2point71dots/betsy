class AddColumnToOrderitems < ActiveRecord::Migration[5.0]
  def change
       add_column :orderitems, :status, :string
  end
end
