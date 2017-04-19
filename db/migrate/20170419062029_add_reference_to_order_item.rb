class AddReferenceToOrderItem < ActiveRecord::Migration[5.0]
  def change
    add_reference :orderitems, :product, foreign_key: true
  end
end
