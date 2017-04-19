class RenameTable < ActiveRecord::Migration[5.0]
  def change
       rename_table :products_categories, :product_categories
  end
end
