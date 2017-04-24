class AddHiddenColumn < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :hidden, :boolean, default: false
  end
end
