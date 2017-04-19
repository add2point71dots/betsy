class AddReferenceToProduct < ActiveRecord::Migration[5.0]
  def change
    add_reference :products, :vendor, foreign_key: true
  end
end
