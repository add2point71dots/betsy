class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.integer :vendor_id
      t.string :name
      t.text :description
      t.string :photo_url
      t.float :price
      t.integer :quantity

      t.timestamps
    end
  end
end
