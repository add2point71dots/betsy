class ChangeCategoriesProductsDefaultTime2 < ActiveRecord::Migration[5.0]
  def change
    change_column_default(:categories_products, :created_at, nil)
    change_column_default(:categories_products, :updated_at, nil)
  end
end
