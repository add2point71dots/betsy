class CreateCategoriesProducts < ActiveRecord::Migration[5.0]
     def change
          create_table :categories_products do |t|
               t.integer :category_id, index: true
               t.integer :product_id, index: true
               t.datetime :created_at, :null => true
               t.datetime :updated_at, :null => true
               t.timestamps
          end
     end
end
