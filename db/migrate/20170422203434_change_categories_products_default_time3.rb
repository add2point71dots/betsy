class ChangeCategoriesProductsDefaultTime3 < ActiveRecord::Migration[5.0]
  def change
    change_column :categories_products, :created_at, :datetime, :null => true
    change_column :categories_products, :updated_at, :datetime, :null => true
  end
end
