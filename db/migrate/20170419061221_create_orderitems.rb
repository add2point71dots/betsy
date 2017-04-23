class CreateOrderitems < ActiveRecord::Migration[5.0]
  def change
    create_table :orderitems do |t|
      #t.references :order, foreign_key: true

      t.integer :order_id
      t.integer :product_id
      t.integer :quantity
      
      t.timestamps
    end
  end
end
