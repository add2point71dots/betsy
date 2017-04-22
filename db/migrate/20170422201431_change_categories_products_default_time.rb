class ChangeCategoriesProductsDefaultTime < ActiveRecord::Migration[5.0]
  def change
    change_column_default(:categories_products, :created_at, Date.current)
    change_column_default(:categories_products, :updated_at, Date.current)

  end
end
